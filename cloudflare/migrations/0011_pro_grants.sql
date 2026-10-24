-- Pro obuna: admin istalgan emailga qo'lda Pro beradi (do'kon xaridiga
-- bog'liq emas). Email ochiq saqlanmaydi: `email_hash` = users.email_hash
-- bilan bir xil HMAC (hisob hali ochilmagan bo'lsa ham — kirganda ishlaydi).
-- `until` NULL — muddatsiz. Bitta email — bitta faol yozuv (qayta berilsa
-- yangilanadi). Yozuvni faqat admin paneli (email kodi bilan kirgan egasi) yozadi.

CREATE TABLE pro_grants (
  email_hash TEXT PRIMARY KEY CHECK (length(email_hash) = 64),
  email_masked TEXT NOT NULL,
  tier TEXT NOT NULL CHECK (tier IN ('student', 'teacher', 'specialist')),
  until INTEGER,
  granted_by TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
CREATE INDEX pro_grants_created ON pro_grants (created_at DESC);
