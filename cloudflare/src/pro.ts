// Pro obuna: admin istalgan emailga qo'lda daraja beradi/olib tashlaydi.
// Xavfsizlik: yo'llar — faqat panel admin (email kodi bilan kirgan egasi),
// email HMAC bilan saqlanadi (javobda faqat niqoblangan), yozish amallari
// audit_log ga (id emas — niqoblangan email va daraja), soatiga 120 ta.
import { audit, emailHash, maskEmail, normalizeEmail, requirePanelAdmin } from './auth';
import type { Ctx } from './context';
import { sha256Hex } from './crypto';
import { badRequest, json, notFound, readJson } from './http';
import { hit } from './ratelimit';

export const PRO_TIERS = ['student', 'teacher', 'specialist'] as const;
export type ProTier = (typeof PRO_TIERS)[number];
const DAY = 86400_000;
const MAX_DAYS = 3650;

type Handler = (ctx: Ctx, ...params: string[]) => Promise<Response>;

/** Faol Pro (muddati o'tmagan) — `/v1/me` uchun. */
export async function activePro(
  ctx: Ctx,
  userId: string,
): Promise<{ tier: ProTier; until: string | null } | null> {
  const r = await ctx.db
    .prepare(
      `SELECT g.tier AS tier, g.until AS until
       FROM pro_grants g JOIN users u ON u.email_hash = g.email_hash
       WHERE u.id = ?1 AND (g.until IS NULL OR g.until > ?2)`,
    )
    .bind(userId, ctx.now)
    .first<{ tier: ProTier; until: number | null }>();
  return r ? { tier: r.tier, until: r.until === null ? null : new Date(r.until).toISOString() } : null;
}

async function panel(ctx: Ctx, write: boolean) {
  const s = await requirePanelAdmin(ctx);
  const tag = (await sha256Hex(s.userId)).slice(0, 32);
  if (write) await hit(ctx.db, `adm-w:${tag}`, 120, 3600, ctx.now);
  else await hit(ctx.db, `adm-r:${tag}`, 300, 600, ctx.now);
  return s;
}

/** POST /v1/admin/pro {email, tier, days?} — days bo'lmasa muddatsiz. */
export async function grant(ctx: Ctx): Promise<Response> {
  const s = await panel(ctx, true);
  const body = await readJson(ctx.req);
  const email = normalizeEmail(body.email);
  if (!email) throw badRequest('invalid_email');
  const tier = typeof body.tier === 'string' ? body.tier : '';
  if (!(PRO_TIERS as readonly string[]).includes(tier)) throw badRequest('invalid_tier');
  let until: number | null = null;
  if (body.days !== undefined && body.days !== null) {
    const d = body.days;
    if (typeof d !== 'number' || !Number.isInteger(d) || d < 1 || d > MAX_DAYS) throw badRequest('invalid_days');
    until = ctx.now + d * DAY;
  }
  const masked = maskEmail(email);
  await ctx.db
    .prepare(
      `INSERT INTO pro_grants (email_hash, email_masked, tier, until, granted_by, created_at)
       VALUES (?1, ?2, ?3, ?4, ?5, ?6)
       ON CONFLICT (email_hash) DO UPDATE SET tier = ?3, until = ?4, granted_by = ?5, created_at = ?6`,
    )
    .bind(await emailHash(ctx, email), masked, tier, until, (await sha256Hex(s.userId)).slice(0, 32), ctx.now)
    .run();
  await audit(ctx, s.userId, 'pro_granted', null, { email: masked, tier, until });
  return json({ email_masked: masked, tier, until: until === null ? null : new Date(until).toISOString() });
}

/** DELETE /v1/admin/pro {email} — Pro ni olib tashlaydi. */
export async function revoke(ctx: Ctx): Promise<Response> {
  const s = await panel(ctx, true);
  const body = await readJson(ctx.req);
  const email = normalizeEmail(body.email);
  if (!email) throw badRequest('invalid_email');
  const r = await ctx.db
    .prepare('DELETE FROM pro_grants WHERE email_hash = ?1')
    .bind(await emailHash(ctx, email))
    .run();
  if (!r.meta.changes) throw notFound();
  await audit(ctx, s.userId, 'pro_revoked', null, { email: maskEmail(email) });
  return json({ revoked: true, email_masked: maskEmail(email) });
}

/** GET /v1/admin/pro — berilgan Pro lar (niqoblangan email). */
export async function list(ctx: Ctx): Promise<Response> {
  await panel(ctx, false);
  const rows = await ctx.db
    .prepare('SELECT email_masked, tier, until, created_at FROM pro_grants ORDER BY created_at DESC LIMIT 200')
    .all<{ email_masked: string; tier: string; until: number | null; created_at: number }>();
  return json({
    grants: rows.results.map((g) => ({
      email_masked: g.email_masked,
      tier: g.tier,
      until: g.until === null ? null : new Date(g.until).toISOString(),
      active: g.until === null || g.until > ctx.now,
    })),
  });
}

/** app.ts da `/v1/admin` umumiy (501) yo'lidan OLDIN ro'yxatga olinadi. */
export const ROUTES: [string, string, Handler][] = [
  ['GET', '/v1/admin/pro', list],
  ['POST', '/v1/admin/pro', grant],
  ['DELETE', '/v1/admin/pro', revoke],
];
