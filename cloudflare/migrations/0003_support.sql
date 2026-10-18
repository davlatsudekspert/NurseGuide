-- "Taklif va yordam" (murojaatlar): foydalanuvchi faqat o'z yozishmasini
-- ko'radi; javobni admin o'zi yozadi (avtomatik/AI javob yo'q).
-- Skrinshotlar uchun `attachment_key` faqat joy (yopiq R2 bucket hali ulanmagan).
CREATE TABLE support_threads (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  kind TEXT NOT NULL CHECK (kind IN ('suggestion', 'bug', 'question')),
  subject TEXT NOT NULL CHECK (length(trim(subject)) BETWEEN 3 AND 120),
  status TEXT NOT NULL DEFAULT 'new' CHECK (status IN ('new', 'in_review', 'answered', 'closed')),
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  last_user_message_at INTEGER NOT NULL,
  last_admin_message_at INTEGER,
  user_read_at INTEGER NOT NULL,
  admin_read_at INTEGER
);
CREATE INDEX support_threads_user ON support_threads (user_id, updated_at DESC);

CREATE TABLE support_messages (
  id TEXT PRIMARY KEY,
  thread_id TEXT NOT NULL REFERENCES support_threads (id) ON DELETE CASCADE,
  from_admin INTEGER NOT NULL DEFAULT 0,
  body TEXT NOT NULL CHECK (length(trim(body)) BETWEEN 1 AND 4000),
  attachment_key TEXT,
  created_at INTEGER NOT NULL
);
CREATE INDEX support_messages_thread ON support_messages (thread_id, created_at);
