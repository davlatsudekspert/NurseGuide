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

  it('egasi (super admin) doim Mutaxassis, muddatsiz; oddiy foydalanuvchi — yo‘q', async () => {
    const { s, boss } = await setup();
    const me = await s.call('GET', '/v1/me', { token: boss.token });
    expect(me.data.pro).toEqual({ tier: 'specialist', until: null });
    const user = await s.signIn(uniqueEmail('plain2'));
    expect((await s.call('GET', '/v1/me', { token: user.token })).data.pro).toBeNull();
  });

  it('muddat oyda: kalendar oy bo‘yicha; kun va oy birga — rad', async () => {
    const { s, boss } = await setup();
    const post = (body: unknown) => s.call('POST', '/v1/admin/pro', { token: boss.token, body });
    const r = await post({ email: uniqueEmail('m'), tier: 'teacher', months: 3 });
    expect(r.status).toBe(200);
    const left = Date.parse(r.data.until) - s.clock.now;
    expect(left).toBeGreaterThanOrEqual(89 * DAY);
    expect(left).toBeLessThanOrEqual(93 * DAY);
    expect((await post({ email: uniqueEmail('m'), tier: 'student', months: 0 })).status).toBe(400);
    expect((await post({ email: uniqueEmail('m'), tier: 'student', months: 121 })).status).toBe(400);
    expect((await post({ email: uniqueEmail('m'), tier: 'student', months: 1.5 })).status).toBe(400);
    expect((await post({ email: uniqueEmail('m'), tier: 'student', days: 5, months: 1 })).status).toBe(400);
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

describe('30 kunlik sinov: hisob + qurilma bo‘yicha bir martalik', () => {
  const DEV = 'device-aaaaaaaaaaaaaaaa';
  const me = (s: ReturnType<typeof makeServer>, token: string, dev: string | null = DEV) =>
    s.call('GET', '/v1/me', { token, headers: dev ? { 'x-device-id': dev } : {} });

  it('yangi hisob + yangi qurilma: 30 kun; sarlavhasiz — sinov yo‘q', async () => {
    const s = makeServer();
    const u = await s.signIn(uniqueEmail('t1'));
    expect((await me(s, u.token, null)).data.trial).toBeNull();
    const r = await me(s, u.token, 'device-bbbbbbbbbbbbbbbb');
    expect(Date.parse(r.data.trial.until) - s.clock.now).toBeGreaterThan(29 * DAY);
    expect(Date.parse(r.data.trial.until) - s.clock.now).toBeLessThanOrEqual(30 * DAY);
  });

  it('bitta telefondan yangi email: sinov qayta berilmaydi', async () => {
    const s = makeServer();
    const first = await s.signIn(uniqueEmail('a'));
    expect((await me(s, first.token)).data.trial).not.toBeNull();
    s.clock.now += 31 * DAY;
    const second = await s.signIn(uniqueEmail('b'));
    expect((await me(s, second.token)).data.trial).toBeNull();
  });

  it('eski email yangi telefonda: sinov qayta berilmaydi', async () => {
    const s = makeServer();
    const email = uniqueEmail('c');
    const u = await s.signIn(email);
    s.clock.now += 31 * DAY;
    expect((await me(s, u.token, 'device-cccccccccccccccc')).data.trial).toBeNull();
  });

  it('qurilma identifikatori javobda yo‘q', async () => {
    const s = makeServer();
    const u = await s.signIn(uniqueEmail('d'));
    expect((await me(s, u.token)).text).not.toContain(DEV);
  });
});

describe('ustoz bo‘lib o‘tish cheklovi', () => {
  it('LG_TEACHER_REQUIRES_PRO=1: talaba ro‘yxatdan o‘ta olmaydi, admin bergan Ustoz o‘tadi', async () => {
    const owner = uniqueEmail('owner');
    const s = makeServer({ ADMIN_EMAILS: owner, LG_ADMIN_EMAILS: '', LG_TEACHER_REQUIRES_PRO: '1' } as never);
    const boss = await s.signIn(owner);
    const email = uniqueEmail('stu');
    const u = await s.signIn(email);
    expect((await s.call('POST', '/v1/me/teacher', { token: u.token })).status).toBe(403);
    await s.call('POST', '/v1/admin/pro', { token: boss.token, body: { email, tier: 'teacher' } });
    expect((await s.call('POST', '/v1/me/teacher', { token: u.token })).status).toBe(200);
  });

  it('standart (o‘chiq): oldingidek ro‘yxatdan o‘tadi', async () => {
    const s = makeServer();
    const u = await s.signIn(uniqueEmail('x'));
    expect((await s.call('POST', '/v1/me/teacher', { token: u.token })).status).toBe(200);
  });
});

describe('hisob o‘chirilganda', () => {
  it('admin bergan Pro ham o‘chadi', async () => {
    const owner = uniqueEmail('owner');
    const s = makeServer({ ADMIN_EMAILS: owner, LG_ADMIN_EMAILS: '' } as never);
    const boss = await s.signIn(owner);
    const email = uniqueEmail('del');
    const u = await s.signIn(email);
    await s.call('POST', '/v1/admin/pro', { token: boss.token, body: { email, tier: 'student' } });
    const before = await s.env.DB.prepare('SELECT COUNT(*) AS n FROM pro_grants').first<{ n: number }>();
    expect((await s.call('DELETE', '/v1/me', { token: u.token })).status).toBe(204);
    const after = await s.env.DB.prepare('SELECT COUNT(*) AS n FROM pro_grants').first<{ n: number }>();
    expect(after!.n).toBe(before!.n - 1);
  });
});

describe('sinov: yoqilish sanasi va cheklov', () => {
  it('LG_BILLING_LAUNCH: eski hisob ham yoqilish kunidan 30 kun oladi', async () => {
    const launch = '2026-12-01T00:00:00Z';
    const s = makeServer({ LG_BILLING_LAUNCH: launch } as never);
    const u = await s.signIn(uniqueEmail('old'));
    s.clock.now = Date.parse('2026-12-10T00:00:00Z');
    const r = await s.call('GET', '/v1/me', { token: u.token, headers: { 'x-device-id': 'device-launchaaaaaaaaa' } });
    expect(r.data.trial).not.toBeNull();
    expect(Date.parse(r.data.trial.until)).toBe(Date.parse(launch) + 30 * DAY);
    const plain = makeServer();
    const p = await plain.signIn(uniqueEmail('old2'));
    plain.clock.now += 40 * DAY;
    const r2 = await plain.call('GET', '/v1/me', { token: p.token, headers: { 'x-device-id': 'device-launchbbbbbbbbb' } });
    expect(r2.data.trial).toBeNull();
  });

  it('bir hisobdan sutkada 5 tadan ortiq yangi qurilma yozilmaydi', async () => {
    const s = makeServer();
    const u = await s.signIn(uniqueEmail('many'));
    let last = null as unknown;
    for (let i = 0; i < 7; i++) {
      const r = await s.call('GET', '/v1/me', { token: u.token, headers: { 'x-device-id': `device-many-${i}-aaaaaaaa` } });
      last = r.data.trial;
    }
    expect(last).toBeNull();
  });
});
