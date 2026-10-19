// Egasi admin paneli: umumiy ko'rsatkichlar, foydalanuvchilar (rol,
// to'xtatish), amallar tarixi. To'lov/obuna yo'q
// (ilova hozircha bepul). Ilova ichidagi shikoyatlar — complaints.ts.
//
// Xavfsizlik:
// * Har yo'l — `requirePanelAdmin`: email kodi bilan ochilgan sessiya, hisob
//   emaili maxfiy ADMIN_EMAILS da (har so'rovda HMAC bilan qayta tekshiriladi;
//   secret o'zgarsa — darhol), hisob to'xtatilmagan. TOTP talab qilinmaydi —
//   egasining ongli qarori (docs/ADMIN_PANEL_GUIDE.md).
// * Javoblarda shaxsiy ma'lumot yo'q: email faqat niqoblangan (`da***@…`),
//   hech qanday hash (email HMAC) chiqmaydi;
//   statistika — faqat umumiy sonlar.
// * Email bo'yicha qidiruv — serverda HMAC (aniq moslik). Taxallus bo'yicha
//   qidiruv — LIKE, `%`, `_` va `\` ekranlanadi (hammani sanab chiqib bo'lmaydi).
// * Admin to'xtatilmaydi va o'z rolini o'zgartira olmaydi.
// * Har yozish amali audit_log ga (faqat id va qisqa tafsilot).
// * SQL faqat parametrli (`?1`); ro'yxat qiymatlari `json_each(?)` bilan.
// * Limitlar: o'qish 10 daqiqada 300, yozish soatiga 120.

import { adminAllowlist, audit, deleteUserData, emailHash, normalizeEmail, requirePanelAdmin } from './auth';
import type { Ctx, Session } from './context';
import { iso } from './context';
import { sha256Hex } from './crypto';
import { badRequest, conflict, forbidden, json, notFound, readJson } from './http';
import { hit } from './ratelimit';

export const READS_PER_10_MIN = 300;
export const WRITES_PER_HOUR = 120;
export const ONLINE_WINDOW_MS = 5 * 60_000;

const DAY = 86400_000;
const TZ_OFFSET = 5 * 3600_000; // Asia/Tashkent (UTC+5), users.last_seen_on bilan bir xil
const UUID_RE = /^[0-9a-f-]{36}$/;
const ROLES = new Set(['hamshira', 'talaba', 'ustoz']);
const LANGS = new Set(['uz', 'ru', 'en']);

const tagOf = async (userId: string) => (await sha256Hex(userId)).slice(0, 32);

async function admin(ctx: Ctx, write = false): Promise<Session> {
  const s = await requirePanelAdmin(ctx);
  const tag = await tagOf(s.userId);
  if (write) await hit(ctx.db, `adm-w:${tag}`, WRITES_PER_HOUR, 3600, ctx.now);
  else await hit(ctx.db, `adm-r:${tag}`, READS_PER_10_MIN, 600, ctx.now);
  return s;
}

/** Admin emaillarining HMAC lari (JSON massiv — `json_each(?)` uchun; javobga chiqmaydi). */
async function adminHashes(ctx: Ctx): Promise<string> {
  const out: string[] = [];
  for (const e of adminAllowlist(ctx)) out.push(await emailHash(ctx, e));
  return JSON.stringify(out);
}

/** Toshkent kuni 'YYYY-MM-DD' ([daysAgo] kun oldin). */
const tashkentDay = (now: number, daysAgo = 0) => new Date(now + TZ_OFFSET - daysAgo * DAY).toISOString().slice(0, 10);

/** Bugungi Toshkent kunining boshlanishi (UTC ms). */
const tashkentMidnight = (now: number) => Math.floor((now + TZ_OFFSET) / DAY) * DAY - TZ_OFFSET;

// ------------------------------------------------------------- statistika
type Num = number | null;

/**
 * GET /v1/admin/stats — faqat umumiy sonlar. Do'kondan yuklab olishlar va
 * sotuvlar bu yerda YO'Q (App Store Connect / Play Console da; to'lov yo'q);
 * “ro'yxatdan o'tgan” — emailini tasdiqlagan hisob (mehmonlar serverga tushmaydi).
 */
export async function stats(ctx: Ctx): Promise<Response> {
  await admin(ctx);
  const now = ctx.now;
  const midnight = tashkentMidnight(now);
  const today = tashkentDay(now);
  const db = ctx.db;
  const [users, roles, langs, daily, objects, support, platforms, methods] = await db.batch([
    db
      .prepare(
        `SELECT COUNT(*) AS total, SUM(created_at >= ?1) AS today, SUM(created_at >= ?2) AS d7,
           SUM(created_at >= ?3) AS d30, SUM(last_seen_on >= ?4) AS a1, SUM(last_seen_on >= ?5) AS a7,
           SUM(last_seen_on >= ?6) AS a30, SUM(last_seen_at >= ?7) AS online,
           SUM(suspended_at IS NOT NULL) AS suspended
         FROM users`,
      )
      .bind(
        midnight,
        midnight - 6 * DAY,
        midnight - 29 * DAY,
        today,
        tashkentDay(now, 6),
        tashkentDay(now, 29),
        now - ONLINE_WINDOW_MS,
      ),
    db.prepare('SELECT role AS k, COUNT(*) AS n FROM users GROUP BY role'),
    db.prepare('SELECT language AS k, COUNT(*) AS n FROM users GROUP BY language'),
    // Oxirgi 14 kun (Toshkent kunlari) bo'yicha yangi hisoblar.
    db
      .prepare(
        `SELECT CAST((created_at - ?1) / ?2 AS INTEGER) AS d, COUNT(*) AS n FROM users
         WHERE created_at >= ?1 GROUP BY d`,
      )
      .bind(midnight - 13 * DAY, DAY),
    db.prepare(
      `SELECT (SELECT COUNT(*) FROM study_groups) AS groups_count,
              (SELECT COUNT(*) FROM teacher_accounts) AS teachers,
              (SELECT COUNT(*) FROM group_members WHERE member_role = 'student') AS students,
              (SELECT COUNT(*) FROM assignments) AS assignments,
              (SELECT COUNT(*) FROM submissions) AS results,
              (SELECT COUNT(*) FROM complaints WHERE status = 'open') AS complaints_open,
              (SELECT COUNT(*) FROM complaints WHERE status = 'resolved') AS complaints_resolved`,
    ),
    db.prepare(
      `SELECT COUNT(*) AS total, SUM(status IN ('new', 'in_review')) AS open,
              SUM(status = 'new') AS awaiting,
              SUM(admin_read_at IS NULL OR last_user_message_at > admin_read_at) AS unread
       FROM support_threads`,
    ),
    db.prepare("SELECT COALESCE(platform, 'unknown') AS k, COUNT(*) AS n FROM users GROUP BY 1"),
    db.prepare("SELECT COALESCE(signup_via, 'unknown') AS k, COUNT(*) AS n FROM users GROUP BY 1"),
  ]);
  const one = <T>(r: D1Result<unknown>) => (r.results[0] ?? {}) as T;
  const n = (v: Num | undefined) => Number(v ?? 0);
  const u = one<Record<string, Num>>(users);
  const o = one<Record<string, Num>>(objects);
  const sp = one<Record<string, Num>>(support);
  const map = (r: D1Result<unknown>) =>
    Object.fromEntries((r.results as { k: string; n: number }[]).map((x) => [x.k, x.n]));
  const perDay = new Map((daily.results as { d: number; n: number }[]).map((x) => [x.d, x.n]));
  return json({
    generated_at: iso(now),
    registered: n(u.total),
    new_today: n(u.today),
    new_7d: n(u.d7),
    new_30d: n(u.d30),
    online_now: n(u.online),
    active_today: n(u.a1),
    active_7d: n(u.a7),
    active_30d: n(u.a30),
    suspended_accounts: n(u.suspended),
    without_profile: 0,
    by_role: map(roles),
    by_language: map(langs),
    by_platform: map(platforms),
    by_login_method: map(methods),
    new_by_day: Array.from({ length: 14 }, (_, i) => ({ day: tashkentDay(now, 13 - i), n: perDay.get(i) ?? 0 })),
    groups: {
      groups: n(o.groups_count),
      teachers: n(o.teachers),
      students: n(o.students),
      assignments: n(o.assignments),
      results: n(o.results),
    },
    complaints: { open: n(o.complaints_open), resolved: n(o.complaints_resolved) },
    support: { total: n(sp.total), open: n(sp.open), awaiting_reply: n(sp.awaiting), unread: n(sp.unread) },
  });
}

// --------------------------------------------------------- foydalanuvchilar
interface UserRow {
  id: string;
  email_masked: string;
  role: string;
  language: string;
  created_at: number;
  last_seen_on: string | null;
  suspended_at: number | null;
  is_admin: number;
}

const userJson = (r: UserRow) => ({
  user_id: r.id,
  email_masked: r.email_masked,
  role: r.role,
  language: r.language,
  registered_on: iso(r.created_at),
  last_seen_on: r.last_seen_on,
  status: r.suspended_at == null ? 'active' : 'suspended',
  suspended_at: iso(r.suspended_at),
  admin: r.is_admin === 1,
});

/** LIKE uchun: `\`, `%`, `_` ekranlanadi (ESCAPE '\'). */
export const likeEscape = (v: string) => v.replace(/[\\%_]/g, (c) => `\\${c}`);

/**
 * GET /v1/admin/users?email=|name=&role=&status=&language=&limit=&offset= —
 * email: serverda HMAC, aniq moslik (email saqlanmaydi). name: guruhdagi
 * taxallus (2–40 belgi, `%`/`_` oddiy belgi). Aks holda — oxirgi ro'yxatdan
 * o'tganlar.
 */
export async function users(ctx: Ctx): Promise<Response> {
  await admin(ctx);
  const q = new URL(ctx.req.url).searchParams;
  const rawEmail = q.get('email')?.trim() || null;
  const rawName = q.get('name')?.trim() || null;
  const role = q.get('role');
  const language = q.get('language');
  const status = q.get('status');
  if (role != null && !ROLES.has(role)) throw badRequest('invalid_role');
  if (language != null && !LANGS.has(language)) throw badRequest('invalid_language');
  if (status != null && status !== 'active' && status !== 'suspended') throw badRequest('invalid_status');
  const limit = Math.min(50, Math.max(1, Number.parseInt(q.get('limit') ?? '20', 10) || 20));
  const offset = Math.min(100_000, Math.max(0, Number.parseInt(q.get('offset') ?? '0', 10) || 0));
  let eh: string | null = null;
  if (rawEmail != null) {
    const email = normalizeEmail(rawEmail);
    if (!email) throw badRequest('invalid_email');
    eh = await emailHash(ctx, email);
  }
  let name: string | null = null;
  if (rawName != null) {
    if (rawName.length < 2 || rawName.length > 40) throw badRequest('invalid_name');
    name = `%${likeEscape(rawName)}%`;
  }
  const admins = await adminHashes(ctx);
  const [rows, total] = await ctx.db.batch([
    ctx.db
      .prepare(
        `SELECT u.id, u.email_masked, u.role, u.language, u.created_at, u.last_seen_on, u.suspended_at,
                u.email_hash IN (SELECT value FROM json_each(?7)) AS is_admin
         FROM users u
         WHERE (?1 IS NULL OR u.email_hash = ?1) AND (?2 IS NULL OR u.role = ?2) AND (?3 IS NULL OR u.language = ?3)
           AND (?4 IS NULL OR (CASE WHEN u.suspended_at IS NULL THEN 'active' ELSE 'suspended' END) = ?4)
           AND (?8 IS NULL OR EXISTS (SELECT 1 FROM group_members g WHERE g.user_id = u.id
                                      AND g.nickname LIKE ?8 ESCAPE '\\'))
         ORDER BY u.created_at DESC LIMIT ?5 OFFSET ?6`,
      )
      .bind(eh, role, language, status, limit, offset, admins, name),
    ctx.db
      .prepare(
        `SELECT COUNT(*) AS n FROM users u
         WHERE (?1 IS NULL OR u.email_hash = ?1) AND (?2 IS NULL OR u.role = ?2) AND (?3 IS NULL OR u.language = ?3)
           AND (?4 IS NULL OR (CASE WHEN u.suspended_at IS NULL THEN 'active' ELSE 'suspended' END) = ?4)
           AND (?5 IS NULL OR EXISTS (SELECT 1 FROM group_members g WHERE g.user_id = u.id
                                      AND g.nickname LIKE ?5 ESCAPE '\\'))`,
      )
      .bind(eh, role, language, status, name),
  ]);
  return json({
    items: (rows.results as UserRow[]).map(userJson),
    total: Number((total.results[0] as { n: number } | undefined)?.n ?? 0),
  });
}

async function targetUser(ctx: Ctx, id: string): Promise<UserRow> {
  if (!UUID_RE.test(id)) throw notFound();
  const u = await ctx.db
    .prepare(
      `SELECT id, email_masked, role, language, created_at, last_seen_on, suspended_at,
              email_hash IN (SELECT value FROM json_each(?2)) AS is_admin
       FROM users WHERE id = ?1`,
    )
    .bind(id, await adminHashes(ctx))
    .first<UserRow>();
  if (!u) throw notFound();
  return u;
}

/** GET /v1/admin/users/:id — bitta hisob: rol, til, holat, guruhlar. */
export async function userDetail(ctx: Ctx, id: string): Promise<Response> {
  const s = await admin(ctx);
  const u = await targetUser(ctx, id);
  const flags = await ctx.db
    .prepare(
        `SELECT EXISTS (SELECT 1 FROM teacher_accounts WHERE user_id = ?1) AS teacher,
                (SELECT COUNT(*) FROM study_groups WHERE owner_id = ?1) AS groups_owned,
                (SELECT COUNT(*) FROM group_members WHERE user_id = ?1 AND member_role = 'student') AS groups_joined,
                (SELECT COUNT(*) FROM support_threads WHERE user_id = ?1) AS support_threads,
                (SELECT COUNT(*) FROM complaints WHERE user_id = ?1) AS complaints`,
      )
    .bind(u.id)
    .first<Record<string, number>>();
  const f = flags ?? {};
  return json({
    ...userJson(u),
    you: u.id === s.userId,
    teacher: f.teacher === 1,
    groups_owned: f.groups_owned ?? 0,
    groups_joined: f.groups_joined ?? 0,
    support_threads: f.support_threads ?? 0,
    complaints: f.complaints ?? 0,
  });
}

/** POST /v1/admin/users/:id/role {role} — profil roli (admin o'z rolini o'zgartira olmaydi). */
export async function setRole(ctx: Ctx, id: string): Promise<Response> {
  const s = await admin(ctx, true);
  const u = await targetUser(ctx, id);
  if (u.id === s.userId) throw forbidden('self');
  const body = await readJson(ctx.req);
  const role = typeof body.role === 'string' && ROLES.has(body.role) ? body.role : null;
  if (!role) throw badRequest('invalid_role');
  if (role !== u.role) {
    await ctx.db.prepare('UPDATE users SET role = ?2 WHERE id = ?1').bind(u.id, role).run();
    await audit(ctx, s.userId, 'role_changed', u.id, { from: u.role, to: role });
  }
  return json(userJson({ ...u, role }));
}

/**
 * POST /v1/admin/users/:id/suspend — hisobni to'xtatish: hamma sessiyalari
 * o'chadi, qayta kirish (email kodi, Google, Apple) `403 account_suspended`.
 * Admin (ADMIN_EMAILS yoki admin vakolati bor hisob) to'xtatilmaydi.
 */
export async function suspendAccount(ctx: Ctx, id: string): Promise<Response> {
  const s = await admin(ctx, true);
  const u = await targetUser(ctx, id);
  if (u.id === s.userId) throw forbidden('self');
  const isAdmin = await ctx.db.prepare('SELECT 1 AS ok FROM admins WHERE user_id = ?1').bind(u.id).first();
  if (u.is_admin === 1 || isAdmin) throw forbidden('admin');
  if (u.suspended_at == null) {
    await ctx.db.batch([
      ctx.db.prepare('UPDATE users SET suspended_at = ?2 WHERE id = ?1 AND suspended_at IS NULL').bind(u.id, ctx.now),
      ctx.db.prepare('DELETE FROM sessions WHERE user_id = ?1').bind(u.id),
    ]);
    await audit(ctx, s.userId, 'account_suspended', u.id);
  }
  return json(userJson({ ...u, suspended_at: u.suspended_at ?? ctx.now }));
}

/** POST /v1/admin/users/:id/reactivate — to'xtatishni bekor qilish (qayta kira oladi). */
export async function reactivateAccount(ctx: Ctx, id: string): Promise<Response> {
  const s = await admin(ctx, true);
  const u = await targetUser(ctx, id);
  if (u.suspended_at != null) {
    await ctx.db.prepare('UPDATE users SET suspended_at = NULL WHERE id = ?1').bind(u.id).run();
    await audit(ctx, s.userId, 'account_reactivated', u.id);
  }
  return json(userJson({ ...u, suspended_at: null }));
}

/**
 * POST /v1/admin/accounts/delete {email, confirm_user_id} — egasi hisobni
 * aniq email bo'yicha o'chiradi (D-63; emailda kelgan o'chirish so'rovlari,
 * maxfiylik siyosati: 30 kun ichida).
 *
 * * Email serverda HMAC qilinadi (aniq moslik; email saqlanmaydi, logga
 *   tushmaydi). `confirm_user_id` — panel avval shu email bo'yicha topib
 *   ko'rsatgan hisob id si: boshqa hisob (yoki eskirgan sahifa) o'chirilmaydi.
 * * O'zini va adminni (ADMIN_EMAILS yoki admin vakolati) o'chirib bo'lmaydi.
 * * O'chirish — o'zi o'chirgandagi bilan BIR XIL yo'l (`deleteUserData`):
 *   Apple tokeni (kod yo'q — `no_code` jurnalda), guruhlar,
 *   murojaatlar, sessiyalar. Jurnal: `account_deleted_by_admin`.
 */
export async function deleteAccountByEmail(ctx: Ctx): Promise<Response> {
  const s = await admin(ctx, true);
  const body = await readJson(ctx.req);
  const email = normalizeEmail(body.email);
  if (!email) throw badRequest('invalid_email');
  const confirm = typeof body.confirm_user_id === 'string' ? body.confirm_user_id : '';
  if (!UUID_RE.test(confirm)) throw badRequest('confirmation_required');
  const u = await ctx.db
    .prepare(
      `SELECT id, email_masked, email_hash IN (SELECT value FROM json_each(?2)) AS is_admin
       FROM users WHERE email_hash = ?1`,
    )
    .bind(await emailHash(ctx, email), await adminHashes(ctx))
    .first<{ id: string; email_masked: string; is_admin: number }>();
  if (!u) throw notFound();
  if (u.id !== confirm) throw conflict('confirmation_mismatch');
  if (u.id === s.userId) throw forbidden('self');
  const isAdmin = await ctx.db.prepare('SELECT 1 AS ok FROM admins WHERE user_id = ?1').bind(u.id).first();
  if (u.is_admin === 1 || isAdmin) throw forbidden('admin');
  await deleteUserData(ctx, u.id, s.userId);
  return json({ deleted: true, user_id: u.id, email_masked: u.email_masked });
}

// --------------------------------------------------------------- jurnal
/**
 * GET /v1/admin/audit?limit= — oxirgi amallar. Bajaruvchi — niqoblangan email;
 * nishon faqat id (hisob/murojaat); hash ko'rinishidagi
 * eski nishonlar chiqarilmaydi.
 */
export async function auditLog(ctx: Ctx): Promise<Response> {
  await admin(ctx);
  const limit = Math.min(100, Math.max(1, Number.parseInt(new URL(ctx.req.url).searchParams.get('limit') ?? '50', 10) || 50));
  const rows = await ctx.db
    .prepare(
      `SELECT l.at, l.action, l.target, l.details, u.email_masked AS actor_masked
       FROM audit_log l LEFT JOIN users u ON u.id = l.actor
       ORDER BY l.at DESC, l.id DESC LIMIT ?1`,
    )
    .bind(limit)
    .all<{ at: number; action: string; target: string | null; details: string; actor_masked: string | null }>();
  const safeTarget = (t: string | null) =>
    t != null && UUID_RE.test(t) ? t : null;
  return json(
    rows.results.map((r) => {
      let details: Record<string, unknown> = {};
      try {
        const d = JSON.parse(r.details) as unknown;
        if (d && typeof d === 'object' && !Array.isArray(d)) details = d as Record<string, unknown>;
      } catch {
        details = {};
      }
      return { at: iso(r.at), action: r.action, actor_masked: r.actor_masked, target: safeTarget(r.target), details };
    }),
  );
}

type Handler = (ctx: Ctx, ...params: string[]) => Promise<Response>;

/** app.ts da `/v1/admin` umumiy (501) yo'lidan OLDIN ro'yxatga olinadi. */
export const ROUTES: [string, string, Handler][] = [
  ['GET', '/v1/admin/stats', stats],
  ['GET', '/v1/admin/users', users],
  ['GET', '/v1/admin/users/:u', userDetail],
  ['POST', '/v1/admin/users/:u/role', setRole],
  ['POST', '/v1/admin/users/:u/suspend', suspendAccount],
  ['POST', '/v1/admin/users/:u/reactivate', reactivateAccount],
  ['POST', '/v1/admin/accounts/delete', deleteAccountByEmail],
  ['GET', '/v1/admin/audit', auditLog],
];
