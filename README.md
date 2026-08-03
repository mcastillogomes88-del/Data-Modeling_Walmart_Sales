# <center>**Walmart Sales Data Modeling with MySQL**</center>

This project includes ETL with Python, data modeling with SQL, and data analytics and visualization with Power BI.

## **Objective**
Este proyecto de análisis de ventas de Walmart implementa un flujo completo de datos utilizando Python, MySQL y Power BI. El proceso abarca la fase ETL, el modelado relacional y la visualización final para la toma de decisiones estratégicas.

## **Dataset**

| Variable | Descripción |
| --- | --- |
| Order ID | Identificador de la orden |
| Order Date | Fecha de compra |
| Ship Date | Fecha de envío |
| Customer Name | Cliente |
| State | Estado |
| City | Ciudad |
| Category | Categoría |
| Product Name | Producto |
| Sales | Venta |
| Quantity | Cantidad |
| Profit | Ganancia |

## **Technologies used**
| Stack | Technology | Purpose |
| :---: | :--- | :--- |
| 🐍 | **Python** | Core Language |
| 🐼 | **Pandas** | Data Manipulation |
| 🔢 | **NumPy** | Mathematical Computing |
| 🛢️ | **My SQL** | Data Loading |
| 📊 | **Structured Query Language (SQL)** | Data Modeling |
| 🪐 | **Power BI** | Data Visualization |


## **Project workflow**
```mermaid
graph LR
    A[Raw CSV] --> B[Data Inspection]
    B --> C[Cleaning]
    C --> D[Validation]
    D --> E[Feature Engineering]
    E --> F[Data Modeling]
    F --> G[Data Visualization]
    G --> H[Business Insights]
```
## **ETL**
* ### **Data Inspection**
Data types <br>
Missing values <br>
Duplicate rows <br>
Statistical summary <br>
* ### **Data Cleaning**
Date conversion <br>
Standardized column names <br>
Removed inconsistencies <br>
* ### **Data Validation**
✔️ Verified that every product belongs to a single category. <br>
✔️ Verified that every city belongs to the correct state. <br>
✔️ Corrected inconsistent product categorization (Staples). <br>
✔️ Created a new Location feature to uniquely identify cities.<br>
* ## **Data Modeling in MySQL**
Once the ETL process with Python is complete, the "walmart schema.sql" file is created, which will contain all the tables proposed for our data model. These tables are:<br>

**sales_raw:** This table is created to store the data exactly as it appears in our "walmart_sales_cleaned.csv" file. <br>

**Customer:** This contains the customer's name and a unique identification ID. <br>

**Category:** This contains the product category and a unique identifier ID. <br>

**Location:** This contains the customer's country, state and city as well as a unique identifier.<br>

**Product:** This contains the product name and the ID of the category it belongs to; the latter is declared as a foreign key referencing the "category" table.<br>

**Customer_orders:** This table stores each order only once, even if the original record is repeated because a single order includes several products from different categories. The structure includes the creation date, the shipping date, the customer ID, and the location ID (both are foreign keys that connect to the "customer" and "location" tables).<br>

**Order_detail:** This table contains the order series ID, which links it to the previous table; it also contains the product ID, which links it to the "Product" table; and it contains sales, quantity, and profit.<br>

![img src="Images/ModeloDeDatosWalmartSales.png" alt=" " width="200%"](Images/ModeloDeDatosWalmartSales.png)

The code for the process of loading the data into the aforementioned tables is located in the file "**walmart_LoadData.sql**"





* ### **Business Questions**
Which category generates the highest sales?<br>
Which states contribute the most revenue?<br>
What is the monthly sales trend?<br>
Which customers generate the highest revenue?<br>
Which product category generates the highest profitability?<br>

* ### **Key Insights**
Copiers represents the highest sales category.<br>
Furniture has high revenue but lower profit margins.<br>
Sales increase significantly during the last quarter of the year.<br>
A small group of customers contributes disproportionately to total revenue.<br>

* ### **Autor**

Nombre: Monserrat Castillo

GitHub: mcastillogomes88-del

Correo: m.castillogomes88@gmail.com

