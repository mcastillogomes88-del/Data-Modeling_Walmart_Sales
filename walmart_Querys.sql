use walmartbd;
-- VERIFICANDO LA CALIDAD DEL DATO

-- Cada producto debe pertenecer a una y solo una categoria.
select Product_name, count(distinct(Category)) as Cuenta 
from sales_raw
-- where Product_name = 'Staples'
group by Product_name
-- having Cuenta > 1
order by Cuenta desc;

-- Cada Order ID debe tener asociada una y solo una Order Date
select order_id, count(distinct(order_date)) as Cuenta
from sales_raw
group by order_id
order by Cuenta desc;

-- Order_id tiene asociados uno y solo uno curtomer name 
select order_id, count(distinct(customer_name)) as cantidad_customer -- ✅
from sales_raw
group by order_id
order by cantidad_customer desc;

-- Un Customer_name puede tener asociados varios Order_id
select customer_name, count(distinct(order_id)) as cantidad_order_id
from sales_raw
group by customer_name
order by cantidad_order_id desc;

-- Order_id tiene asociado una y solo una order_date y una solo una ship_date
with ComprobarFechas as(
select 
order_id, 
concat(order_date,"_",ship_date) as Fechas_Asociadas
from sales_raw
)
select 
order_id, 
count(distinct(Fechas_Asociadas)) as Cantidad_fechas
from ComprobarFechas
group by order_id
order by Cantidad_fechas desc;

-- Order_id tiene asociado uno y solo uno Country, City y State
with Concatenar_Locaciones as (
select Order_id,
concat(country,"-",city,"-",state) as Locacion
from sales_raw
)

select 
Order_id,
count(distinct(Locacion)) as No_Locaciones_Asociadas
from Concatenar_Locaciones
group by order_id
order by No_Locaciones_Asociadas desc;


-- -------------------------------------------------------------------
-- Llamo al procediemiento para realizar la acción de limpiado de todas las tablas
CALL sp_clean_walmart_db();

-- Procedo a verificar que las tablas hayan quedado vacías.
select * from customer;
select * from category;
select * from location;
select * from product;
select * from customer_orders;
select * from order_detail;

-- Llamo al procedimiento para poblar las tablas del modelo desde la tabla sales_raw
CALL sp_etl_load_from_staging();

select * from customer;
select * from category;
select * from location;
select * from product;  -- ⚠️⚠️⚠️
select * from customer_orders;
select * from order_detail;

select count(distinct(product_name)) from product;







-- Ventas totales
select sum(line_sales) as Ventas_Totales from order_detail;
-- Utilidad total
select count(*) from order_detail;  -- 3639
-- Ventas por categoría

-- Utilidad por categoría

-- Top 10 productos más vendidos


-- Top 10 productos más rentables

-- Ventas por estado

-- Ventas por ciudad

-- Evolución mensual de ventas

-- Ticket promedio por pedido