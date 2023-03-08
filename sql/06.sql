/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */

WITH bacall_films AS(
    SELECT film_actor.film_id from film_actor, actor
    WHERE film_actor.actor_id = actor.actor_id
    AND actor.first_name = 'RUSSELL' and actor.last_name = 'BACALL')

SELECT DISTINCT(actor.first_name || ' ' || actor.last_name) AS "Actor Name" FROM actor, film_actor
WHERE actor.actor_id = film_actor.actor_id AND
film_actor.film_id IN(SELECT * FROM bacall_films) AND
(actor.first_name || ' ' || actor.last_name) NOT LIKE 'RUSSELL BACALL'
ORDER BY "Actor Name";
