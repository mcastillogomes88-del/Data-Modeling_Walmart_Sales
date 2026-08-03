create database if not exists WalmartBD;
use WalmartBD;

-- Creamos la estructura de las tablas para nuestro modelo

-- Tabla de staging para carga inicial
create table sales_raw(
id_raw int auto_increment primary key,
order_id varchar(255),
order_date date,
ship_date date,
customer_name varchar(255),
country varchar(255),
city varchar(255),
state varchar(255),
category varchar(255),
product_name varchar(255),
sales decimal(10,2),
quantity int,
profit decimal(10,2)
);

-- Dimensión de clientes
create table if not exists customer(
id_customer int auto_increment primary key,
customer_name varchar(255) not null unique
);

-- Tabla de categorías
create table if not exists category(
id_category int auto_increment primary key,
category_name varchar(255) not null unique
);

-- Tabla de locación
create table if not exists location(
id_location int auto_increment primary key,
country varchar(255) not null,
state varchar(255) not null,
city varchar(255) not null,
UNIQUE(country, state, city)
);

-- Tabla de productos
create table if not exists product(
id_product int auto_increment primary key,
product_name varchar(255) not null unique,
id_category int not null,
CONSTRAINT fk_product_category
FOREIGN KEY (id_category) REFERENCES category(id_category)
ON UPDATE CASCADE
ON DELETE RESTRICT
);

-- Tabla de encabezado de pedidos
create table if not exists customer_orders(  -- ❤️
id_order_serie varchar(255) primary key,
id_customer int not null,
order_date date not null,
ship_date date not null,
id_location int not null,
CONSTRAINT fk_orders_customer
FOREIGN KEY (id_customer) REFERENCES customer(id_customer)
ON UPDATE CASCADE
ON DELETE RESTRICT,
CONSTRAINT fk_orders_location
FOREIGN KEY (id_location) REFERENCES location(id_location)
ON UPDATE CASCADE
ON DELETE RESTRICT
);

-- Tabla de detalle de pedidos
create table if not exists order_detail(
id_order_detail int auto_increment primary key,
id_order_serie varchar(255) not null,
id_product int not null,
line_sales decimal(10,2) not null,
quantity int not null,
line_profit decimal(10,2) not null,
constraint fk_detail_order
FOREIGN KEY (id_order_serie) REFERENCES customer_orders(id_order_serie)
ON UPDATE CASCADE
ON DELETE RESTRICT,
constraint fk_detail_product
FOREIGN KEY (id_product) REFERENCES product(id_product)
ON UPDATE CASCADE
ON DELETE RESTRICT
);


ALTER TABLE sales_raw MODIFY COLUMN order_date varchar(255);
ALTER TABLE sales_raw MODIFY COLUMN ship_date varchar(255);

select * from sales_raw;

