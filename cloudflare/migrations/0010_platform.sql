-- Admin panel statistikasi: ilova platformasi (iOS / Android) va ro'yxatdan
-- o'tish usuli (email kodi / Google / Apple). Faqat qisqa belgi saqlanadi:
-- qurilma modeli, IP yoki boshqa identifikator YO'Q.
ALTER TABLE users ADD COLUMN platform TEXT CHECK (platform IS NULL OR platform IN ('ios', 'android'));
ALTER TABLE users ADD COLUMN signup_via TEXT CHECK (signup_via IS NULL OR signup_via IN ('otp', 'google', 'apple'));
