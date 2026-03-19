SELECT name
FROM people
WHERE id IN (
    SELECT person_id
    FROM stars
    WHERE person_id NOT IN (
        SELECT id
        FROM people
        WHERE name IS 'Kevin Bacon'
        AND birth IS 1958
    )
    AND person_id IN (
        SELECT person_id
        FROM stars
        WHERE movie_id IN (
            SELECT movie_id
            FROM stars
            WHERE person_id IN (
                SELECT id
                FROM people
                WHERE name IS 'Kevin Bacon'
                AND birth IS 1958
            )
        )
    )
)
ORDER BY name