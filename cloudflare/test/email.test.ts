import { afterEach, describe, expect, it, vi } from 'vitest';
import { emailSender, resendSender } from '../src/email';
import type { Env } from '../src/http';

describe('Resend va provayder tanlash', () => {
  afterEach(() => vi.restoreAllMocks());
  const env = { RESEND_API_KEY: 're_secret', LG_SENDER_EMAIL: 'nurseguide@nfcstore.uz', LG_SENDER_NAME: 'NurseGuide' } as Env;
  const bodyOf = (spy: { mock: { calls: unknown[][] } }, i = 0) => JSON.parse((spy.mock.calls[i][1] as RequestInit).body as string);

  it("to'g'ri so'rov shakli: Bearer, from, to massiv, text+html", async () => {
    const spy = vi.spyOn(globalThis, 'fetch').mockResolvedValue(new Response('{"id":"x"}', { status: 200 }));
    expect(await resendSender(env, 'a@b.uz', '123456', 'ru')).toBe('sent');
    const [url, init] = spy.mock.calls[0] as [string, RequestInit];
    expect(url).toBe('https://api.resend.com/emails');
    expect(init.method).toBe('POST');
    expect((init.headers as Record<string, string>).authorization).toBe('Bearer re_secret');
    const body = bodyOf(spy);
    expect(body.from).toBe('NurseGuide <nurseguide@nfcstore.uz>');
    expect(body.to).toEqual(['a@b.uz']);
    expect(body.subject).toBe('NurseGuide: код входа');
    expect(body.text).toContain('123456');
    expect(body.text).toContain('10 минут');
    expect(body.html).toContain('<strong');
  });

  it("til: noma'lum bo'lsa uz, en ham ishlaydi", async () => {
    const spy = vi.spyOn(globalThis, 'fetch').mockResolvedValue(new Response('{}', { status: 200 }));
    await resendSender(env, 'a@b.uz', '654321', 'xx');
    expect(bodyOf(spy).subject).toBe('NurseGuide: kirish kodi');
    expect(bodyOf(spy).text).toContain('10 daqiqa');
    expect(bodyOf(spy).text).toContain("e'tibor bermang");
    await resendSender(env, 'a@b.uz', '654321', 'en');
    expect(bodyOf(spy, 1).subject).toBe('NurseGuide: sign-in code');
  });

  it('LG_SENDER_EMAIL berilmasa standart nfcstore.uz', async () => {
    const spy = vi.spyOn(globalThis, 'fetch').mockResolvedValue(new Response('{}', { status: 200 }));
    await resendSender({ RESEND_API_KEY: 'k' } as Env, 'a@b.uz', '111111', 'uz');
    expect(bodyOf(spy).from).toBe('NurseGuide <nurseguide@nfcstore.uz>');
  });

  it("noto'g'ri formatdagi LG_SENDER_EMAIL (Ism <manzil>, boshqa domen) — standart manzil", async () => {
    const spy = vi.spyOn(globalThis, 'fetch').mockResolvedValue(new Response('{}', { status: 200 }));
    for (const bad of ['NurseGuide <nurseguide@nfcstore.uz>', 'x@gmail.com', 'nurseguide', ' ']) {
      await resendSender({ RESEND_API_KEY: 'k', LG_SENDER_EMAIL: bad } as Env, 'a@b.uz', '111111', 'uz');
    }
    for (let i = 0; i < 4; i++) expect(bodyOf(spy, i).from).toBe('NurseGuide <nurseguide@nfcstore.uz>');
    await resendSender({ RESEND_API_KEY: 'k', LG_SENDER_EMAIL: 'hello@nfcstore.uz' } as Env, 'a@b.uz', '111111', 'uz');
    expect(bodyOf(spy, 4).from).toBe('NurseGuide <hello@nfcstore.uz>');
  });

  it('4xx/429/5xx va tarmoq xatosi — failed; kalit, email va kod logga chiqmaydi', async () => {
    const warn = vi.spyOn(console, 'warn').mockImplementation(() => {});
    for (const status of [401, 422, 429, 500]) {
      vi.spyOn(globalThis, 'fetch').mockResolvedValue(new Response('{"message":"bad a@b.uz 987654 re_secret"}', { status }));
      expect(await resendSender(env, 'a@b.uz', '987654', 'uz')).toBe('failed');
    }
    vi.spyOn(globalThis, 'fetch').mockRejectedValue(new Error('boom a@b.uz 987654 re_secret'));
    expect(await resendSender(env, 'a@b.uz', '987654', 'uz')).toBe('failed');
    const logged = JSON.stringify(warn.mock.calls);
    for (const leak of ['re_secret', 'a@b.uz', '987654']) expect(logged).not.toContain(leak);
    expect(logged).toContain('429');
  });

  it("kalit yo'q — not_configured, so'rov yuborilmaydi", async () => {
    const spy = vi.spyOn(globalThis, 'fetch');
    expect(await resendSender({} as Env, 'a@b.uz', '111111', 'uz')).toBe('not_configured');
    expect(spy).not.toHaveBeenCalled();
  });

  it('EMAIL_PROVIDER: standart resend, "brevo" — Brevo', async () => {
    const spy = vi.spyOn(globalThis, 'fetch').mockResolvedValue(new Response('{}', { status: 200 }));
    const both = { RESEND_API_KEY: 'r', BREVO_API_KEY: 'b', LG_SENDER_EMAIL: 's@x.uz' } as Env;
    await emailSender(both, 'a@b.uz', '111111', 'uz');
    await emailSender({ ...both, EMAIL_PROVIDER: 'resend' }, 'a@b.uz', '111111', 'uz');
    await emailSender({ ...both, EMAIL_PROVIDER: 'Brevo' }, 'a@b.uz', '111111', 'uz');
    expect(spy.mock.calls.map((c) => c[0])).toEqual([
      'https://api.resend.com/emails',
      'https://api.resend.com/emails',
      'https://api.brevo.com/v3/smtp/email',
    ]);
  });
});
