-- Question 1
select distinct title
, length
, DENSE_RANK() over (ORDER BY length DESC) AS length_rank
from sakila.film
where length is not null 
and length > 0;

-- Question 2
select distinct title
, length
, rating
, dense_rank() over (partition by rating order by length desc) as rating_length_rank
		-- using dense_rank instead of rank function as length has no decimals and hence, rank should be the same
from sakila.film
where length is not null
and length > 0;

-- Question 3
select distinct t1.name as category_name
	, count(distinct t2.film_id) as film_count
from sakila.category t1
	inner join sakila.film_category t2 
		on t1.category_id = t2.category_id
group by 1
order by film_count desc;

-- Question 4
select distinct t1.actor_id
	, CONCAT(t1.first_name,' ',t1.last_name) as actor_full_name
	, count(distinct film_id) as film_count
from sakila.actor t1
	inner join sakila.film_actor t2
		on t1.actor_id = t2.actor_id
group by 1
order by film_count desc
limit 1;

-- Question 5
select distinct CONCAT(t1.first_name,' ',t1.last_name) as customer_full_name
	, count(distinct rental_id) as rental_count
from sakila.customer t1
	inner join sakila.rental t2
		on t1.customer_id = t2.customer_id
group by 1
order by rental_count desc
limit 1;

-- Bonus
select distinct t1.title
		, count(distinct rental_id) as rental_count
from sakila.film t1
	inner join sakila.inventory t2
		on t1.film_id = t2.film_id
	inner join sakila.rental t3
		on t2.inventory_id = t3.inventory_id
group by 1
order by rental_count desc
limit 1;