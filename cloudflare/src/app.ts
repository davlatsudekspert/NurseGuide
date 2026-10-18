// Marshrutlar va umumiy so'rov qayta ishlash (xatolar ichki ma'lumotsiz).

import * as admins from './admins';
import * as adminConsole from './adminconsole';
import * as auth from './auth';
import * as complaints from './complaints';
import type { Ctx, Deps } from './context';
import { deriveKeys, hex, hmac } from './crypto';
import * as groups from './groups';
import * as social from './social';
import * as support from './support';
import {
  ApiError,
  corsHeaders,
  type Env,
  errorResponse,
  json,
  withCors,
} from './http';

type Handler = (ctx: Ctx, ...params: string[]) => Promise<Response>;

interface Route {
  method: string;
  pattern: RegExp;
  handler: Handler;
}

const P = '([^/]+)';
const r = (method: string, path: string, handler: Handler): Route => ({
  method,
  pattern: new RegExp(`^${path.replace(/:[a-z]+/g, P)}$`),
  handler,
});

const routes: Route[] = [
  r('GET', '/v1/health', async () => json({ ok: true, api: 1, service: 'nurseguide-api' })),

  // Auth
  r('POST', '/v1/auth/otp/request', auth.requestCode),
  r('POST', '/v1/auth/otp/verify', auth.verifyCode),
  // Google / Apple bilan kirish (D-56): ID token serverda tekshiriladi.
  r('GET', '/v1/auth/providers', social.providers),
  r('POST', '/v1/auth/google', social.googleLogin),
  r('POST', '/v1/auth/apple', social.appleLogin),
  r('POST', '/v1/auth/apple/callback', social.appleCallback),
  r('POST', '/v1/auth/logout', auth.logout),
  r('POST', '/v1/auth/logout-all', auth.logoutAll),
  r('GET', '/v1/auth/mfa', auth.mfaStatus),
  r('POST', '/v1/auth/mfa/enroll', auth.mfaEnroll),
  r('POST', '/v1/auth/mfa/verify', auth.mfaVerify),

  // Hisob
  r('GET', '/v1/me', auth.me),
  r('PUT', '/v1/me/profile', auth.updateProfile),
  r('DELETE', '/v1/me', auth.deleteAccount),
  r('POST', '/v1/me/teacher', groups.registerTeacher),

  // Guruhlar
  r('GET', '/v1/groups', groups.listGroups),
  r('POST', '/v1/groups', groups.createGroup),
  r('POST', '/v1/groups/join', groups.joinGroup),
  r('DELETE', '/v1/groups/:g', groups.deleteGroup),
  r('POST', '/v1/groups/:g/leave', groups.leaveGroup),
  r('PUT', '/v1/groups/:g/alias', groups.setAlias),
  r('POST', '/v1/groups/:g/code', groups.rotateCode),
  r('GET', '/v1/groups/:g/members', groups.listMembers),
  r('DELETE', '/v1/groups/:g/members/:u', groups.removeMember),
  r('GET', '/v1/groups/:g/topics', groups.listTopics),
  r('PUT', '/v1/groups/:g/topics/:d', groups.openTopic),
  r('DELETE', '/v1/groups/:g/topics/:d', groups.closeTopic),
  r('POST', '/v1/groups/:g/topics/:d/stage', groups.markTopicStage),
  r('POST', '/v1/groups/:g/topics/:d/test', groups.startTopicTest),
  r('POST', '/v1/groups/:g/topics/:d/finish', groups.finishTopicTest),
  r('GET', '/v1/groups/:g/marks', groups.listMarks),
  r('PUT', '/v1/groups/:g/marks', groups.putMark),
  r('DELETE', '/v1/groups/:g/marks/:m', groups.deleteMark),
  r('GET', '/v1/groups/:g/assignments', groups.listAssignments),
  r('POST', '/v1/groups/:g/assignments', groups.createAssignment),
  r('GET', '/v1/groups/:g/submissions', groups.groupSubmissions),
  r('POST', '/v1/assignments/:a/open', (c, a) => groups.setAssignmentStatus(c, a, 'open')),
  r('POST', '/v1/assignments/:a/close', (c, a) => groups.setAssignmentStatus(c, a, 'closed')),
  r('POST', '/v1/assignments/:a/start', groups.startAssignment),
  r('POST', '/v1/assignments/:a/submit', groups.submitAssignment),
  r('GET', '/v1/assignments/:a/submissions', groups.listSubmissions),
  r('GET', '/v1/assignments/:a/key', groups.assignmentKey),
  r('GET', '/v1/assignments/:a/progress', groups.assignmentProgress),

  // Adminlar boshqaruvi (D-44): ro'yxat — har admin, o'zgartirish — super admin.
  r('GET', '/v1/admin/admins', admins.listAdmins),
  r('POST', '/v1/admin/admins', admins.addAdmin),
  r('DELETE', '/v1/admin/admins/:id', admins.removeAdmin),

  // Taklif va yordam, shikoyatlar, egasi admin paneli (support.ts, complaints.ts, adminconsole.ts).
  ...[...support.ROUTES, ...complaints.ROUTES, ...adminConsole.ROUTES].map(([m, p, h]) => r(m, p, h)),
];

const MIN_SECRET = 32;

export function createApp(deps: Deps) {
  return {
    async fetch(req: Request, env: Env): Promise<Response> {
      const cors = corsHeaders(req, env);
      if (req.method === 'OPTIONS') {
        // Preflight faqat ruxsat etilgan originga.
        return cors ? new Response(null, { status: 204, headers: cors }) : new Response(null, { status: 403 });
      }
      try {
        const url = new URL(req.url);
        let match: { route: Route; params: string[] } | null = null;
        let pathKnown = false;
        for (const route of routes) {
          const m = route.pattern.exec(url.pathname);
          if (!m) continue;
          pathKnown = true;
          if (route.method === '*' || route.method === req.method) {
            match = { route, params: m.slice(1).filter((x) => x !== undefined && !x.startsWith('/')) };
            break;
          }
        }
        if (!match) throw new ApiError(pathKnown ? 405 : 404, pathKnown ? 'method_not_allowed' : 'not_found');
        if (url.pathname === '/v1/health') return withCors(await match.route.handler({} as Ctx), cors);

        const secret = env.LG_SERVER_SECRET ?? '';
        if (secret.length < MIN_SECRET) throw new ApiError(503, 'not_configured');
        const keys = await deriveKeys(secret);
        const ip = req.headers.get('cf-connecting-ip') ?? 'unknown';
        const ctx: Ctx = {
          req,
          env,
          db: env.DB,
          keys,
          deps,
          now: deps.now(),
          ipTag: hex(await hmac(keys.ip, ip)).slice(0, 32),
        };
        return withCors(await match.route.handler(ctx, ...match.params), cors);
      } catch (e) {
        if (e instanceof ApiError) return withCors(errorResponse(e), cors);
        // Ichki tafsilot (SQL, stack) javobga chiqmaydi; logda faqat tur.
        console.error('internal error', e instanceof Error ? e.name : typeof e);
        return withCors(json({ error: 'internal' }, 500), cors);
      }
    },

    /** Kunlik tozalash: bitta batch (bepul tarif limitlarini tejaydi). */
    async scheduled(env: Env): Promise<void> {
      const now = deps.now();
      await env.DB.batch([
        env.DB.prepare('DELETE FROM otp_challenges WHERE expires_at < ?1').bind(now),
        env.DB.prepare('DELETE FROM sessions WHERE expires_at < ?1').bind(now),
        env.DB.prepare('DELETE FROM auth_replay WHERE expires_at < ?1').bind(now),
        env.DB.prepare('DELETE FROM rate_limits WHERE window_start < ?1').bind(now - 86400_000),
      ]);
    },
  };
}
