SELECT
  shortened_urls.long_url,
  shortened_urls.created_at AS "created",
  visits.created_at AS "last_visited",
  users.premium AS "premium"
FROM
  shortened_urls
  JOIN users ON users.id = shortened_urls.submitter_id
  LEFT JOIN visits ON shortened_urls.id = visits.shortened_url_id
WHERE
  (
    shortened_urls.created_at < CURRENT_TIMESTAMP - INTERVAL '1 minute'
    AND visits.created_at IS NULL
  )
  OR shortened_urls.created_at < CURRENT_TIMESTAMP - INTERVAL '5 minute';