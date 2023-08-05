--Selecciona las columnas film_id y title de la tabla film.
select film_id, title from film;

--Selecciona 5 filas de la tabla film, obteniendo todas las columnas.
select * from film limit 5;

--Selecciona filas de la tabla film donde film_id sea menor que 4.
select * from film where film_id <4;

--Selecciona filas de la tabla film donde el rating sea PG o G.
select * from film where rating = 'PG' OR rating = 'G';

--Selecciona filas de la tabla actor donde el nombre sea Angela, Angelina o Audrey usando IN.
select * from actor where first_name in ('Angela','Angelina','Audrey');

--Obtén una lista de actores con el nombre Julia.
select * from actor where first_name in ('Julia');

--Obtén una lista de actores con los nombres Chris, Cameron o Cuba.
select * from actor where first_name in ('Chris','Cameron','Cuba');

--Selecciona la fila de la tabla customer para el cliente con el nombre Jamie Rice.
select * from customer where first_name in ('Jamie')and last_name in ('Rice');

--Selecciona el monto y la fecha de pago de la tabla payment donde el monto pagado sea menor a $1.
select * from payment where amount < 1;

--¿Cuáles son las diferentes duraciones de alquiler permitidas por la tienda?
select distinct rental_duration from film
order by rental_duration 

--Ordena las filas en la tabla city por country_id y luego por city.
select * from city order by country_id,city asc;

--¿Cuáles son los ID de los últimos 3 clientes que devolvieron un alquiler?
select customer_id, return_date 
from rental 
where return_date IS NOT NULL
order by return_date desc
limit 3

--¿Cuántas películas tienen clasificación NC-17? ¿Cuántas tienen clasificación PG o PG-13?
select 
sum(case when rating = 'PG'  OR rating = 'PG-13' then 1 else 0 end) as ratingPG_PG13,
sum(case when rating = 'NC-17' then 1 else 0 end) as   ratingNC_17
from film

--¿Cuántos clientes diferentes tienen registros en la tabla rental?
select distinct customer_id  from rental

--¿Hay algún cliente con el mismo apellido?
select distinct first_name, count(*) as duplicados  from customer group by first_name
having count(*)>1

--¿Qué película (id) tiene la mayor cantidad de actores?
select title as title_movie, count(fi.actor_id) as numbers_actor from film_actor fi
inner join film f on fi.film_id = f.film_id
group by title
order by numbers_actor asc;

--¿Qué actor (id) aparece en la mayor cantidad de películas?
select CONCAT(first_name,' ', last_name) as actor,fi.actor_id, count(fi.film_id) as numbers_movie 
from film_actor fi
inner join film f on fi.film_id = f.film_id
inner join actor a on fi.actor_id = a.actor_id
group by actor,fi.actor_id
order by numbers_movie asc;

--Cuenta el número de ciudades para cada country_id en la tabla city. Ordena los resultados por count(*).
select  country_id, count(city) as numbers_city from city
group  by country_id
order by numbers_city 

--¿Cuál es la tarifa de alquiler promedio de las películas? ¿Puedes redondear el resultado a 2 decimales?
select round(avg(rental_rate),2) as avg_movies from film;

--Selecciona los 10 actores que tienen los nombres más largos (nombre y apellido combinados).
select length(CONCAT(first_name,' ', last_name)) as long_name,CONCAT(first_name,' ', last_name) as name_actor
from actor 
order by name_actor
 limit 10 
