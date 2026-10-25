/*
   Stored procedures used by the PowerBuilder Code Examples, for the EASDEMO database on SQL Server.

   The SQL Anywhere demo database ships with these procedures; a SQL Server copy of EASDEMO may not.
   Each procedure returns exactly the columns its DataWindow expects:

     sp_customer_list          d_sp_dddw_customers   (Stored Procedure Source DWs)
     sp_customer_products      d_cust_products       (Stored Procedure Source DWs)
     sp_sales_order            d_sp_orders           (Stored Procedure Source DWs)
     sp_sales_order_items      d_sp_order_items      (Stored Procedure Source DWs)
     sp_product_info           d_product_info        (Stored Procedure Source DWs)
     sp_retrieve_contacts      d_sp_contacts         (Stored Procedure Update)
     dba.sp_full_sales_orders  p_create_full_sales_orders_sp (Stored Procedure Source Data Pipeline)

   Safe to run more than once: a procedure that already exists is left unchanged.
   Run against EASDEMO, for example:
     sqlcmd -S 127.0.0.1 -U sa -d EASDEMO -C -i easdemo_example_procedures.sql
*/
SET NOCOUNT ON;
GO

IF OBJECT_ID(N'dbo.sp_customer_list', N'P') IS NULL
    EXEC(N'CREATE PROCEDURE dbo.sp_customer_list
AS
    SELECT id, company_name
      FROM customer
     ORDER BY company_name;');
GO

IF OBJECT_ID(N'dbo.sp_customer_products', N'P') IS NULL
    EXEC(N'CREATE PROCEDURE dbo.sp_customer_products @customer_id int
AS
    SELECT i.prod_id AS product_id, SUM(i.quantity) AS quantity_ordered
      FROM sales_order o
      JOIN sales_order_items i ON i.id = o.id
     WHERE o.cust_id = @customer_id
     GROUP BY i.prod_id
     ORDER BY i.prod_id;');
GO

IF OBJECT_ID(N'dbo.sp_sales_order', N'P') IS NULL
    EXEC(N'CREATE PROCEDURE dbo.sp_sales_order @customer_id int, @product_id int
AS
    SELECT DISTINCT o.id, o.order_date, o.fin_code_id, o.region, o.sales_rep
      FROM sales_order o
      JOIN sales_order_items i ON i.id = o.id
     WHERE o.cust_id = @customer_id
       AND i.prod_id = @product_id
     ORDER BY o.id;');
GO

IF OBJECT_ID(N'dbo.sp_sales_order_items', N'P') IS NULL
    EXEC(N'CREATE PROCEDURE dbo.sp_sales_order_items @ord_id int, @product int
AS
    SELECT line_id, prod_id, quantity, ship_date
      FROM sales_order_items
     WHERE id = @ord_id
       AND (@product IS NULL OR prod_id = @product)
     ORDER BY line_id;');
GO

IF OBJECT_ID(N'dbo.sp_product_info', N'P') IS NULL
    EXEC(N'CREATE PROCEDURE dbo.sp_product_info @prod_id int
AS
    SELECT id AS product_id, name, description, prod_size AS size, color, quantity, unit_price, picture_name
      FROM product
     WHERE id = @prod_id;');
GO

IF OBJECT_ID(N'dbo.sp_retrieve_contacts', N'P') IS NULL
    EXEC(N'CREATE PROCEDURE dbo.sp_retrieve_contacts
AS
    SELECT id, last_name, first_name, title, street, city, state, zip, phone, fax
      FROM contact
     ORDER BY last_name, first_name;');
GO

-- The pipeline example calls this one with the SQL Anywhere owner name, dba.
IF SCHEMA_ID(N'dba') IS NULL
    EXEC(N'CREATE SCHEMA dba;');
GO

IF OBJECT_ID(N'dba.sp_full_sales_orders', N'P') IS NULL
    EXEC(N'CREATE PROCEDURE dba.sp_full_sales_orders
AS
    SELECT o.id, o.cust_id, c.company_name, o.order_date, o.fin_code_id, o.region,
           i.line_id, i.prod_id, p.name, p.description, p.prod_size, p.color, p.unit_price,
           i.quantity, i.ship_date
      FROM sales_order o
      JOIN customer c          ON c.id = o.cust_id
      JOIN sales_order_items i ON i.id = o.id
      JOIN product p           ON p.id = i.prod_id
     ORDER BY o.id, i.line_id;');
GO

SELECT s.name + N'.' + o.name AS procedure_name, o.create_date
  FROM sys.procedures o JOIN sys.schemas s ON s.schema_id = o.schema_id
 WHERE o.name IN (N'sp_customer_list', N'sp_customer_products', N'sp_sales_order', N'sp_sales_order_items',
                  N'sp_product_info', N'sp_retrieve_contacts', N'sp_full_sales_orders')
 ORDER BY 1;
GO
