SET GLOBAL local_infile = 1;


-- Error Code: 1062 Duplicate entry 'Staples' for key 'product.product_name'

SELECT
    product_name,
    COUNT(*) AS veces
FROM sales_raw
GROUP BY product_name
HAVING COUNT(*) > 1
ORDER BY veces DESC;

SELECT
    product_name,
    COUNT(DISTINCT category) AS categorias
FROM sales_raw
GROUP BY product_name
HAVING COUNT(DISTINCT category) > 1;

SELECT DISTINCT
    sr.product_name,
    c.id_category
FROM sales_raw sr
JOIN category c
    ON sr.category = c.category_name
WHERE sr.product_name = 'Staples';

-- Vamos a eliminar la restricción unique a product_name en la tabla product 
ALTER TABLE product
DROP INDEX product_name;

-- Agregaremos una restricción compuesta en su lugar
ALTER TABLE product
ADD CONSTRAINT uq_product_IDcategory UNIQUE (product_name, id_category);

-- Eliminaremos los datos ya cargados a la tabla product
TRUNCATE TABLE product;

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
    
    
    
    
    
    
    
    
    
    -- ------------------------------
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
    STR_TO_DATE(sr.order_date,'%d/%m/%Y'),
    STR_TO_DATE(sr.ship_date,'%d/%m/%Y'),
    l.id_location
FROM sales_raw sr
JOIN customer c
    ON sr.customer_name = c.customer_name
JOIN location l
    ON sr.country = l.country
   AND sr.state = l.state
   AND sr.city = l.city;
   
   
   -- --------------------------------
   -- Product_name tiene asociadas varias Category, especificamente Staples esta clasificado dentro de 
-- varias categorias: Envelopes, Paper, Fasteners, Supplies, Labels, Art, Furnishings, Binders, Appliances y Storage
select
product_name,
count(distinct(category)) as Cant_Asociada_Categorias
from sales_raw
group by product_name
order by Cant_Asociada_Categorias desc;

select
distinct(category)
from sales_raw
where product_name = "Staples";

-- Para seguir con la conformidad de los datos vamos a categorizar Staples en la categoría de Fasteners.

UPDATE sales_raw 
SET category = "Fasteners" 
WHERE product_name = "Staples";

select  -- comprobamos los cambios sean correctos
product_name,
count(distinct(category)) as Cant_Asociada_Categorias
from sales_raw
where product_name = "Staples"
group by product_name
order by Cant_Asociada_Categorias desc;
