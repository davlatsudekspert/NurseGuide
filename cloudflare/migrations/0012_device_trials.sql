-- 30 kunlik bepul sinov: HISOB va QURILMA bo'yicha bir martalik.
-- Sinov tugashi = min(hisob ochilgan vaqt, qurilma birinchi ko'rilgan vaqt) + 30 kun:
-- bitta telefondan har xil emaillar bilan qayta-qayta sinov olib bo'lmaydi,
-- eski emailni yangi telefonda ishlatib ham bo'lmaydi.
-- Qurilma identifikatori ochiq saqlanmaydi: HMAC(server kaliti, id).
CREATE TABLE device_trials (
  device_hash TEXT PRIMARY KEY CHECK (length(device_hash) = 64),
  first_seen INTEGER NOT NULL
);
