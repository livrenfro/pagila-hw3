/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
 
WITH children AS(
    SELECT DISTINCT actor.first_name, actor.last_name from actor 
    JOIN film_actor USING(actor_id)
    JOIN film_category USING(film_id)
    JOIN category USING(category_id)
    WHERE category.name = 'Children'),

horror AS(
    SELECT DISTINCT actor.first_name, actor.last_name from actor
    JOIN film_actor USING(actor_id)
    JOIN film_category USING(film_id)
    JOIN category USING(category_id)
    WHERE category.name = 'Horror')

SELECT * FROM children
EXCEPT 
SELECT * FROM horror
ORDER BY last_name, first_name;
