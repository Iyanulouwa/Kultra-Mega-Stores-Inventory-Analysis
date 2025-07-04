USE DSA;

--1. Which product category had the highest sales?--
SELECT TOP 1 product_category,SUM(sales) AS total_sales
FROM dbo.kmssqlcasestudy
GROUP BY product_category
ORDER BY total_sales DESC;

--2. What are the Top 3 and Bottom 3 regions in terms of sales?--
--Top 3
SELECT TOP 3 region, SUM(sales) AS total_sales
FROM dbo.kmssqlcasestudy
GROUP BY region
ORDER BY total_sales DESC
--Bottom 3
SELECT TOP 3 region, SUM(sales) AS total_sales
FROM dbo.kmssqlcasestudy
GROUP BY region
ORDER BY total_sales ASC;

--3. What were the total sales of appliances in Ontario?--
SELECT SUM(sales) AS total_sales
FROM dbo.kmssqlcasestudy
WHERE product_subcategory = 'Appliances' AND province = 'Ontario';

--5. KMS incurred the most shipping cost using which shipping method?
SELECT ship_mode, SUM(shipping_cost) AS total_shipping_cost
FROM dbo.kmssqlcasestudy
GROUP BY ship_mode
ORDER BY total_shipping_cost DESC;

--6. Who are the most valuable customers, and what products or services do they typically purchase?
WITH CustomerSales AS(
	SELECT customer_name, SUM(sales) AS total_sales
	FROM dbo.kmssqlcasestudy
	GROUP BY customer_name),
	TopCustomer AS (
		SELECT TOP 10 *
		FROM CustomerSales
		ORDER BY total_sales DESC)
		SELECT K.customer_name, product_category, SuM(sales) AS category_sales
		FROM dbo.kmssqlcasestudy K
		JOIN
		TopCustomer t
		ON K.customer_name= t.customer_name
		GROUP BY K.customer_name, product_category
		ORDER BY K.customer_name, category_sales DESC;

--7.  Which small business customer had the highest sales?SELECT TOP 1 customer_name, SUM(sales) AS total_salesFROM dbo.kmssqlcasestudyWHERE customer_segment= 'Small Business'GROUP BY customer_nameORDER BY total_sales DESC--8. Which Corporate Customer placed the most number of orders in 2009 – 2012?SELECT TOP 1 customer_name, COUNT(order_quantity) AS order_countFROM dbo.kmssqlcasestudyWHERE customer_segment= 'Corporate' AND YEAR(order_date) BETWEEN 2009 AND 2012GROUP BY customer_nameORDER BY order_count DESC--9.  Which consumer customer was the most profitable one?SELECT TOP 1 customer_name, SUM(profit) AS total_profitFROM dbo.kmssqlcasestudyWHERE customer_segment= 'Consumer'GROUP BY customer_nameORDER BY total_profit DESC--10. Which customer returned items, and what segment do they belong to? (Negative Profit)SELECT DISTINCT customer_name, customer_segmentFROM dbo.kmssqlcasestudyWHERE profit < 0--11. If the delivery truck is the most economical but the slowest shipping method and 
	--Express Air is the fastest but the most expensive one,
	--do you think the company appropriately spent shipping costs based on the Order Priority? Explain your answer
SELECT order_priority, ship_mode,			
       AVG(shipping_cost) AS avg_shipping_cost,			
       COUNT(order_id) AS total_orders			
FROM dbo.kmssqlcasestudy		
GROUP BY order_priority, ship_mode;	