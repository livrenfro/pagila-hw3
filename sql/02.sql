/*
 * Compute the country with the most customers in it. 
 */

--groupby country, count unique(customer id)
SELECT country.country FROM country
JOIN city USING(country_id)
JOIN address USING(city_id)
JOIN customer USING(address_id)
GROUP BY country 
ORDER BY (count(distinct(customer_id))) DESC
LIMIT 1;
