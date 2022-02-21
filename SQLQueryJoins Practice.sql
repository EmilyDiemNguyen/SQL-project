/* Cross Join Example */

select * 
from customers 
cross join orders;

/* Self Join Example */

select *
from customers as c1, customers as c2
where c1.customer_id =c2.customer_id;

/* Inner Join Example */

select first_name, last_name, order_date, amount
from customers c
inner join orders o
on c.customer_id = o.customer_id;

/* Left Join Example */

select first_name, last_name, order_date, amount
from customers c
left join orders o
on c.customer_id = o.customer_id;


select first_name, last_name, order_date, amount
from customers c
left join orders o
on c.customer_id = o.customer_id
where order_date is NULL;


/* Right Join Example */

select first_name, last_name, order_date, amount
from customers c
Right join orders o
on c.customer_id = o.customer_id;

select first_name, last_name, order_date, amount
from customers c
Right join orders o
on c.customer_id = o.customer_id
where first_name is NULL;

/* Full Join Example */

select first_name, last_name, order_date, amount
from customers c
FULL join orders o
on c.customer_id = o.customer_id;









