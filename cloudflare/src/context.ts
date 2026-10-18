import { hex, hmac, type Keys } from './crypto';
import type { CodeSender } from './email';
import type { Env } from './http';

export interface Deps {
  sendCode: CodeSender;
  /** Unix ms (testlarda soat almashtiriladi). */
  now: () => number;
  /**
   * Tashqi so'rovlar (App Store / Google Play API). Standart: global `fetch`;
   * testlarda soxta — haqiqiy do'konga hech qachon murojaat qilinmaydi.
   */
  fetch?: typeof fetch;
}

export interface Ctx {
  req: Request;
  env: Env;
  db: D1Database;
  keys: Keys;
  deps: Deps;
  now: number;
  /** HMAC(IP) ning qisqa ko'rinishi — faqat limit kaliti, saqlanmaydi. */
  ipTag: string;
}

export interface Session {
  userId: string;
  tokenHash: string;
  aal: 'aal1' | 'aal2';
  role: string;
  language: string;
  /** Kirish usuli: otp (email kodi) | google | apple. */
  via: string;
}

export const iso = (ms: number | null | undefined): string | null =>
  ms == null ? null : new Date(ms).toISOString();

/** HMAC(server kaliti, user_id): admin yozuvlarida "kim" — id ochiq saqlanmaydi. */
export async function userHash(ctx: Ctx, userId: string): Promise<string> {
  return hex(await hmac(ctx.keys.uid, userId));
}
