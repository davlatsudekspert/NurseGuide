// Pro obuna: admin istalgan emailga qo'lda daraja beradi/olib tashlaydi.
// Xavfsizlik: yo'llar — faqat panel admin (email kodi bilan kirgan egasi),
// email HMAC bilan saqlanadi (javobda faqat niqoblangan), yozish amallari
// audit_log ga (id emas — niqoblangan email va daraja), soatiga 120 ta.
import { audit, emailHash, isSuperAdmin, maskEmail, normalizeEmail, requirePanelAdmin } from './auth';
import type { Ctx } from './context';
import { hex, hmac, sha256Hex } from './crypto';
import { badRequest, json, notFound, readJson } from './http';
import { hit } from './ratelimit';

export const PRO_TIERS = ['student', 'teacher', 'specialist'] as const;
export type ProTier = (typeof PRO_TIERS)[number];
const DAY = 86400_000;
const MAX_DAYS = 3650;
const MAX_MONTHS = 120;

const hmacHex = async (ctx: Ctx, v: string) => hex(await hmac(ctx.keys.uid, v));

type Handler = (ctx: Ctx, ...params: string[]) => Promise<Response>;

/** Faol Pro (muddati o'tmagan) — `/v1/me` uchun. */
export async function activePro(
  ctx: Ctx,
  userId: string,
): Promise<{ tier: ProTier; until: string | null } | null> {
  // Egasi (super admin) — doim to'liq (Mutaxassis) kirish, muddatsiz.
  if (await isSuperAdmin(ctx, userId)) return { tier: 'specialist', until: null };
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

const TRIAL_DAYS = 30;
const DEVICE_RE = /^[A-Za-z0-9._:-]{16,128}$/;

/**
 * Bepul sinov: `X-Device-Id` sarlavhasi bo'lsa qurilma birinchi marta
 * ro'yxatga olinadi (keyingi hisoblar uning soatini YANGILAMAYDI). Sinov
 * muddati — hisob va qurilmaning eng erta vaqti + 30 kun. Sarlavha yo'q yoki
 * noto'g'ri — sinov berilmaydi (null). `LG_BILLING_LAUNCH` (ISO sana) bo'lsa,
 * sinov shu sanadan oldin boshlanmaydi: obuna yoqilishidan oldingi hisoblar ham
 * yoqilish kunidan 30 kun oladi. Bir hisobdan sutkada 5 tadan ortiq yangi
 * qurilma yozilmaydi (jadval ko'payib ketmasin).
 */
export async function trialInfo(ctx: Ctx, userId: string): Promise<{ until: string } | null> {
  const raw = ctx.req.headers.get('x-device-id') ?? '';
  if (!DEVICE_RE.test(raw)) return null;
  const dh = await hmacHex(ctx, `dev:${raw}`);
  const known = await ctx.db.prepare('SELECT 1 AS x FROM device_trials WHERE device_hash = ?1').bind(dh).first();
  if (!known) {
    try {
      await hit(ctx.db, `dev-new:${userId}`, 5, 86400, ctx.now);
    } catch {
      return null;
    }
  }
  await ctx.db
    .prepare('INSERT OR IGNORE INTO device_trials (device_hash, first_seen) VALUES (?1, ?2)')
    .bind(dh, ctx.now)
    .run();
  const r = await ctx.db
    .prepare(
      `SELECT MIN(u.created_at, d.first_seen) AS start
       FROM users u, device_trials d WHERE u.id = ?1 AND d.device_hash = ?2`,
    )
    .bind(userId, dh)
    .first<{ start: number }>();
  if (!r) return null;
  const launch = Date.parse(ctx.env.LG_BILLING_LAUNCH ?? '');
  const start = Number.isNaN(launch) ? r.start : Math.max(r.start, launch);
  const end = start + TRIAL_DAYS * DAY;
  return end > ctx.now ? { until: new Date(end).toISOString() } : null;
}

/** Admin bergan faol Pro darajasi berilgan ro'yxatdagimi (ustoz cheklovi uchun). */
export async function hasGrantTier(ctx: Ctx, userId: string, tiers: ProTier[]): Promise<boolean> {
  const p = await activePro(ctx, userId);
  return p !== null && tiers.includes(p.tier);
}

async function panel(ctx: Ctx, write: boolean) {
  const s = await requirePanelAdmin(ctx);
  const tag = (await sha256Hex(s.userId)).slice(0, 32);
  if (write) await hit(ctx.db, `adm-w:${tag}`, 120, 3600, ctx.now);
  else await hit(ctx.db, `adm-r:${tag}`, 300, 600, ctx.now);
  return s;
}

/** POST /v1/admin/pro {email, tier, days? | months?} — ikkalasi ham bo'lmasa muddatsiz. */
export async function grant(ctx: Ctx): Promise<Response> {
  const s = await panel(ctx, true);
  const body = await readJson(ctx.req);
  const email = normalizeEmail(body.email);
  if (!email) throw badRequest('invalid_email');
  const tier = typeof body.tier === 'string' ? body.tier : '';
  if (!(PRO_TIERS as readonly string[]).includes(tier)) throw badRequest('invalid_tier');
  let until: number | null = null;
  const hasDays = body.days !== undefined && body.days !== null;
  const hasMonths = body.months !== undefined && body.months !== null;
  if (hasDays && hasMonths) throw badRequest('invalid_days');
  if (hasDays) {
    const d = body.days;
    if (typeof d !== 'number' || !Number.isInteger(d) || d < 1 || d > MAX_DAYS) throw badRequest('invalid_days');
    until = ctx.now + d * DAY;
  } else if (hasMonths) {
    const m = body.months;
    if (typeof m !== 'number' || !Number.isInteger(m) || m < 1 || m > MAX_MONTHS) throw badRequest('invalid_days');
    const at = new Date(ctx.now);
    at.setUTCMonth(at.getUTCMonth() + m);
    until = at.getTime();
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
    .prepare('SELECT email_masked, tier, until, created_at FROM pro_grants ORDER BY created_at DESC LIMIT 500')
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
