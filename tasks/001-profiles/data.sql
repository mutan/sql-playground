-- Test data for task 001-profiles.
-- Loaded by `task load T=001-profiles` right after schema.sql, into empty tables.

-- 20 profiles -----------------------------------------------------------------

INSERT INTO profile (id, nickname, registered_at)
VALUES (1,  'northstar',   '2024-01-03 10:15:00'),
       (2,  'pixelfox',    '2024-01-11 14:20:00'),
       (3,  'mira',        '2024-02-02 09:00:00'),
       (4,  'coffee_dev',  '2024-02-17 18:45:00'),
       (5,  'owlbear',     '2024-03-05 12:30:00'),
       (6,  'tinyplanet',  '2024-03-22 08:10:00'),
       (7,  'red_panda',   '2024-04-01 16:05:00'),
       (8,  'syntax_cat',  '2024-04-19 11:40:00'),
       (9,  'wanderer',    '2024-05-07 07:25:00'),
       (10, 'bluejay',     '2024-05-29 20:00:00'),
       (11, 'nightshift',  '2024-06-12 13:15:00'),
       (12, 'mapleleaf',   '2024-06-30 09:35:00'),
       (13, 'quietstorm',  '2024-07-14 17:50:00'),
       (14, 'goldenhour',  '2024-08-03 10:05:00'),
       (15, 'bytebard',    '2024-08-21 15:25:00'),
       (16, 'moonrabbit',  '2024-09-09 06:55:00'),
       (17, 'stonebridge', '2024-09-28 19:10:00'),
       (18, 'cloudberry',  '2024-10-16 12:00:00'),
       (19, 'last_train',  '2024-11-02 21:30:00'),
       (20, 'emberline',   '2024-11-25 08:45:00');

-- The ids above are explicit, so move the sequence past them:
-- the next INSERT without an id gets 21.
SELECT setval(pg_get_serial_sequence('profile', 'id'), (SELECT max(id) FROM profile));

-- Posts -----------------------------------------------------------------------

-- Post counts per profile cover the edge cases for "more than 10 posts":
--   0 posts:   3, 16
--   10 posts:  7                                  (boundary, must NOT match)
--   11 posts:  4, 11, 18                          (just above the boundary)
--   > 10 posts in total: 1, 4, 6, 8, 11, 13, 15, 18, 20
-- Each post is created 3 days after the previous one; likes are pseudo-random.

WITH post_counts (profile_id, post_count) AS (
    VALUES (1, 15), (2, 8),   (3, 0),   (4, 11),  (5, 3),
           (6, 20), (7, 10),  (8, 12),  (9, 1),   (10, 5),
           (11, 11), (12, 2), (13, 15), (14, 7),  (15, 12),
           (16, 0), (17, 4),  (18, 11), (19, 6),  (20, 12)
)
INSERT INTO post (owner_id, body, inserted_at, likes_count)
SELECT pc.profile_id,
       format('Post %s by profile %s', n, pc.profile_id),
       p.registered_at + n * INTERVAL '3 days',
    (pc.profile_id * 17 + n * 13) % 250
FROM post_counts AS pc
    JOIN profile AS p ON p.id = pc.profile_id
    CROSS JOIN LATERAL generate_series(1, pc.post_count) AS n
ORDER BY pc.profile_id, n;

-- Subscription counts ---------------------------------------------------------

-- Follower counts cover the edge cases for "more than 1000 followers":
--   999, 1000 (profiles 7, 17; must NOT match), 1001, 1002.

INSERT INTO subscription_count (profile_id, followers_count, following_count)
VALUES (1,  2500, 120),
       (2,  980,  340),
       (3,  1001, 25),
       (4,  1500, 600),
       (5,  12,   8),
       (6,  8700, 90),
       (7,  1000, 1000),
       (8,  1002, 77),
       (9,  0,    15),
       (10, 450,  220),
       (11, 1200, 45),
       (12, 999,  50),
       (13, 3400, 180),
       (14, 76,   91),
       (15, 1050, 300),
       (16, 5,    0),
       (17, 1000, 12),
       (18, 2200, 410),
       (19, 640,  72),
       (20, 1001, 65);