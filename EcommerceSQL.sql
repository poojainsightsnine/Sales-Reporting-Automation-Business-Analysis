create database ECommerce_HealthSuppliments;
use ECommerce_HealthSuppliments;
Alter table customer rename to customers;
Alter table customecustomer rename to customers;
alter table customer change ï»¿customer_id customer_id varchar(100);
select * from customer; 
alter table orders change ï»¿order_id order_id varchar(100);
alter table order_items change ï»¿order_id order_id varchar(100);
alter table complaints change ï»¿complaint_id complaint_id varchar(100);
alter table products change ï»¿product_id  product_id varchar(100);
select * from orders;
-- Q.1- Write a query that shows all customers along with their total number of orders, total spend, and latest order date. Customers who have never placed 
-- an order should still appear in the result with 0 orders and NULL for spend and date. Then extend the same query: also show the complaint count per customer 
-- (joining through their orders to the complaints table). Customers with no complaints should show 0.Expected output columns: customer_id, name, city, total_orders,
-- total_spend, latest_order_date,total_complaints.
select c.customer_id,c.`name`,c.city, count(o.order_id) as total_orders,sum(o.total_amount) as total_spend,
max(str_to_date(o.order_date,'%d-%m-%y')) as latest_order_date ,count(cmp.complaint_id) as total_complaints from customers c
left join orders as o on c.customer_id=o.customer_id
left join complaints as cmp on o.order_id = cmp.order_id
group by c.customer_id,c.`name`,c.city; 
-- ** -- Extend Query **--
select c.customer_id,c.`name`,c.city, count(o.order_id) as total_orders,sum(o.total_amount) as total_spend,
max(str_to_date(o.order_date,'%d-%m-%y')) as latest_order_date ,count(cmp.complaint_id) as total_complaints from customers c
left join orders as o on c.customer_id=o.customer_id
left join complaints as cmp on o.order_id = cmp.order_id
group by c.customer_id,c.`name`,c.city
ORDER BY total_spend DESC LIMIT 1;
-- Based on total_spend, Priya Sharma appears to be the highest-value customer with ₹10,710 --

-- Q.2-- Find the top 10 product pairs most frequently bought together in the same order. For each pair, also
-- show the product names. Requirements: (a) each pair should appear only once, (b) include product names not just IDs, (c) sort by
-- co-occurrence count descending.
select OI1.product_id as product_1 ,
OI2.product_id as product_2,
P1.product_name as product_name_1,
P2.product_name as  product_name_2,
count(*) as Co_occurance_count
from order_items as OI1
join order_items as OI2 on OI1.order_id = OI2.order_id
AND OI1.product_id <OI2.Product_id
join products as p1 on OI1.product_id = p1.product_id
join products as p2 on OI2.product_id = p2.product_id
group by OI1.product_id,OI2.product_id,P1.product_name,P2.product_name
order by Co_occurance_count desc limit 10;
-- ***Whey Protein drives most purchases and creates strong bundling opportunities with other supplements**--