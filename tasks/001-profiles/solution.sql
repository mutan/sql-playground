-- Выбери все профили, у которых больше 1000 подписчиков.

SELECT p.nickname, sc.followers_count
FROM profile p LEFT JOIN subscription_count sc ON p.id = sc.profile_id
WHERE followers_count > 1000
;

-- Выбери профили, у которых больше 10 публикаций

SELECT p.nickname, COUNT(po.owner_id) as posts
FROM profile p LEFT JOIN post po ON p.id = po.owner_id
GROUP BY p.id --, p.nickname
HAVING COUNT(po.owner_id) > 10
;

