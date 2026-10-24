import { describe, expect, it } from 'vitest';
import { makeServer, uniqueEmail } from './helpers';

const DAY = 86400_000;

async function setup() {
  const owner = uniqueEmail('owner');
  const s = makeServer({ ADMIN_EMAILS: owner, LG_ADMIN_EMAILS: '' } as never);
  const boss = await s.signIn(owner);
  return { s, boss };
}

describe('admin: emailga Pro berish', () => {
  it('faqat panel admin; oddiy foydalanuvchi va mehmon rad etiladi', async () => {
    const { s, boss } = await setup();
    const user = await s.signIn(uniqueEmail('plain'));
    const body = { email: uniqueEmail('x'), tier: 'student' };
    expect((await s.call('POST', '/v1/admin/pro', { body })).status).toBe(401);
    expect((await s.call('POST', '/v1/admin/pro', { token: user.token, body })).status).toBe(403);
    expect((await s.call('GET', '/v1/admin/pro', { token: user.token })).status).toBe(403);
    expect((await s.call('POST', '/v1/admin/pro', { token: boss.token, body })).status).toBe(200);
  });

  it('email bo‘yicha beriladi, /v1/me da pro ko‘rinadi, olib tashlanadi', async () => {
    const { s, boss } = await setup();
    const email = uniqueEmail('pro');
    // Hisob hali yo'q — kirganda ham ishlaydi.
    const g = await s.call('POST', '/v1/admin/pro', {
      token: boss.token,
      body: { email, tier: 'specialist', days: 30 },
    });
    expect(g.status).toBe(200);
    expect(JSON.stringify(g.data)).not.toContain(email);
    expect(JSON.stringify(g.data)).not.toMatch(/\b[0-9a-f]{64}\b/);
    const u = await s.signIn(email);
    const me = await s.call('GET', '/v1/me', { token: u.token });
    expect(me.data.pro.tier).toBe('specialist');
    expect(me.data.pro.until).toBe(g.data.until);
    expect(new Date(g.data.until).getTime() - Date.parse('2000-01-01')).toBeGreaterThan(29 * DAY);

    const list = await s.call('GET', '/v1/admin/pro', { token: boss.token });
    const mine = list.data.grants.filter((x: { email_masked: string }) => x.email_masked === g.data.email_masked);
    expect(mine).toHaveLength(1);
    expect(mine[0].active).toBe(true);

    const r = await s.call('DELETE', '/v1/admin/pro', { token: boss.token, body: { email } });
    expect(r.status).toBe(200);
    expect((await s.call('GET', '/v1/me', { token: u.token })).data.pro).toBeNull();
    expect((await s.call('DELETE', '/v1/admin/pro', { token: boss.token, body: { email } })).status).toBe(404);
  });

  it('noto‘g‘ri kirishlar', async () => {
    const { s, boss } = await setup();
    const post = (body: unknown) => s.call('POST', '/v1/admin/pro', { token: boss.token, body });
    expect((await post({ email: 'nope', tier: 'student' })).status).toBe(400);
    expect((await post({ email: uniqueEmail('a'), tier: 'gold' })).status).toBe(400);
    expect((await post({ email: uniqueEmail('a'), tier: 'student', days: 0 })).status).toBe(400);
    expect((await post({ email: uniqueEmail('a'), tier: 'student', days: 99999 })).status).toBe(400);
  });
});
