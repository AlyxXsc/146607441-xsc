SELECT AVG(rating) AS '2012 Average Rating' 
FROM ratings 
WHERE movie_id IN (
    SELECT id 
    FROM movies 
    WHERE year IS 2012
    )