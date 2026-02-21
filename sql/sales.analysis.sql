--Sales Analysis - Sales by month, quarter, year

--Total Sales by Year

SELECT EXTRACT(YEAR FROM o.order_date) AS year, 
		COUNT(DISTINCT o.order_id) AS total_orders,
		SUM(od.unit_price * od.quantity) AS total_sales
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY EXTRACT(YEAR FROM o.order_date)
ORDER BY year;

--Total Sales by Month
SELECT EXTRACT(YEAR FROM o.order_date) AS year, 
		TO_CHAR (o.order_date, 'Month') AS month,
		COUNT(DISTINCT o.order_id) AS total_orders, 
		SUM(od.unit_price * od.quantity) AS total_sales
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY EXTRACT(YEAR FROM o.order_date), 
		TO_CHAR (o.order_date, 'Month'),
		EXTRACT (MONTH FROM o.order_date)
ORDER BY year asc,
		EXTRACT (MONTH FROM o.order_date);

-- Total Sales by Quarter
SELECT EXTRACT(YEAR FROM o.order_date) AS year, 
		EXTRACT(QUARTER FROM o.order_date) AS Quarter, 
		COUNT(DISTINCT o.order_id) AS total_orders,
		SUM(od.unit_price * od.quantity) AS total_sales
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY EXTRACT(YEAR FROM o.order_date),
		EXTRACT(QUARTER FROM o.order_date) 
ORDER BY year asc, Quarter asc;

--- Average Revenue per Day

SELECT SUM(od.unit_price * od.quantity) / COUNT(DISTINCT CAST(o.order_date AS DATE)) AS AvgRevenuePerDay
FROM order_details od
JOIN orders o ON od.order_id = o.order_id ;
