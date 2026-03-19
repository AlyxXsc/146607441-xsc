SELECT name 
FROM people
WHERE id IN (
    SELECT DISTINCT person_id
    FROM directors
    WHERE movie_id IN (
        SELECT movie_id
        FROM ratings
        WHERE rating IS 9.0 
        OR rating > 9.0
    )
)