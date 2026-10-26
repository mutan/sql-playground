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
