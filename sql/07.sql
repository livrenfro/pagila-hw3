/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

WITH bacall_films AS( 
    SELECT film_id, actor_id from actor
    JOIN film_actor USING(actor_id)
    WHERE actor.first_name = 'RUSSELL' and actor.last_name = 'BACALL'),

first_degree AS(
    SELECT actor_id FROM film_actor
    WHERE film_id IN(SELECT film_id FROM bacall_films) AND
    actor_id NOT IN(SELECT actor_id FROM bacall_films)),

first_degree_films AS(
    SELECT * from actor
    JOIN first_degree USING(actor_id)
    WHERE actor_id IN(SELECT * FROM first_degree)),

second_degree AS(
    SELECT actor_id FROM film_actor
    WHERE film_id IN(SELECT film_id from first_degree_films) AND
    actor_id NOT IN(SELECT * FROM first_degree) AND
    actor_id NOT IN(SELECT actor_id FROM bacall_films))

SELECT 
DISTINCT CONCAT(first_name, ' ', last_name) AS "Actor Name" FROM second_degree
JOIN actor USING(actor_id)
ORDER BY  "Actor Name";


--SELECT DISTINCT(actor.first_name || ' ' || actor.last_name) AS "Actor Name" FROM actor--
--J-OIN film_actor USING(actor_id)
--WHERE actor.actor_id = film_actor.actor_id AND
--film_actor.film_id IN(SELECT * FROM first_degree_films) AND
--film_actor.actor_id NOT IN(SELECT actor_id FROM bacall_films)
--ORDER BY  "Actor Name";

--fllm_actor.film_id NOT IN(SELECT * FROM bacall_films);
