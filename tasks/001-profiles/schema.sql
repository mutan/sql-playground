CREATE TABLE profile
(
    id            BIGSERIAL PRIMARY KEY,
    nickname      VARCHAR,
    registered_at TIMESTAMP
);

CREATE TABLE post
(
    id          BIGSERIAL PRIMARY KEY,
    owner_id    BIGINT REFERENCES profile (id),
    body        TEXT,
    inserted_at TIMESTAMP,
    likes_count INT
);

CREATE TABLE subscription_count
(
    profile_id      BIGINT REFERENCES profile (id) UNIQUE,
    followers_count INT,
    following_count INT
);

-- Схема взята с собеседования, поэтому дается как есть.
-- Но в нее можно внести исправлени:

-- В subscription_count сделать profile_id первичным ключом вместо UNIQUE. UNIQUE допускает несколько строк с NULL
-- Добавить NOT NULL к nickname, owner_id и датам
-- Добавить DEFAULT 0 и CHECK (... >= 0) к счётчикам
-- Сделать nickname уникальным
-- Добавить индекс на post(owner_id). Postgres не создаёт индексы для внешних ключей сам, а второе задание группирует как раз по этой колонке
-- Использовать timestamptz вместо timestamp