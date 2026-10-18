import { describe, expect, it } from 'vitest';
import { makeServer } from './helpers';

describe('GET /v1/health', () => {
  it('kirishsiz ochiq: 200 {ok, api, service}; secret sozlanmagan bo‘lsa ham ishlaydi', async () => {
    const s = makeServer();
    const r = await s.call('GET', '/v1/health');
    expect(r.status).toBe(200);
    expect(r.data).toEqual({ ok: true, api: 1, service: 'nurseguide-api' });
    // Sessiya talab qilinmaydi va hech qanday ichki ma'lumot chiqmaydi.
    expect(r.text).not.toMatch(/secret|token|key/i);

    const noSecret = makeServer({ LG_SERVER_SECRET: '' });
    expect((await noSecret.call('GET', '/v1/health')).status).toBe(200);
    // Boshqa yo'llar sozlanmagan serverda 503.
    expect((await noSecret.call('GET', '/v1/me')).status).toBe(503);
  });

  it('faqat GET; noma‘lum yo‘l — 404', async () => {
    const s = makeServer();
    expect((await s.call('POST', '/v1/health', { body: {} })).status).toBe(405);
    expect((await s.call('GET', '/v1/healthz')).status).toBe(404);
  });
});
