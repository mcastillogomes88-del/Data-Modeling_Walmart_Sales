use WalmartBD;

-- Poblamos la tabla temporal sales_raw
LOAD DATA LOCAL INFILE 'C:/Users/Portatil/Documents/Proyectos/WalmartSalesPoyect_Python_SQL_PowerBI/walmart_sales_cleaned.csv' 
INTO TABLE sales_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from sales_raw;

-- Ahora poblamos las demás tablas
INSERT INTO customer (customer_name)
SELECT DISTINCT customer_name
FROM sales_raw
ORDER BY customer_name;

SELECT * FROM customer;

INSERT INTO category (category_name)
SELECT DISTINCT category
FROM sales_raw
ORDER BY category;

select * from category;

INSERT INTO location (country, state, city)
SELECT DISTINCT
    country,
    state,
    city
FROM sales_raw
ORDER BY country, state, city;

select * from location;

-- Poblamos la tabla 'product'
INSERT INTO product (
    product_name,
    id_category
)
SELECT DISTINCT
    sr.product_name,
    c.id_category
FROM sales_raw sr
JOIN category c
    ON sr.category = c.category_name;
    
select * from product;

-- Poblar customer_orders
INSERT INTO customer_orders (
    id_order_serie,
    id_customer,
    order_date,
    ship_date,
    id_location
)
SELECT DISTINCT
    sr.order_id,
    c.id_customer,
    sr.order_date,
    sr.ship_date,
    l.id_location
FROM sales_raw sr
JOIN customer c
    ON sr.customer_name = c.customer_name
JOIN location l
    ON sr.country = l.country
   AND sr.state = l.state
   AND sr.city = l.city;
   
select * from customer_orders;

-- Poblar Order_detail
INSERT INTO order_detail (
    id_order_serie,
    id_product,
    line_sales,
    quantity,
    line_profit
)
SELECT
    sr.order_id,
    p.id_product,
    sr.sales,
    sr.quantity,
    sr.profit
FROM sales_raw sr
JOIN product p
    ON sr.product_name = p.product_name;
    
select * from order_detail;
