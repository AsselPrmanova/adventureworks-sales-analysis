--Top 3 Best-Selling Products by Category Based on Total Sales
WITH top_three_by_product AS 

	(SELECT 
			p.product_name, 
			ROUND(SUM(od.unit_price * od.quantity)::numeric,2) AS total_sales,
			c.category_name, 
			ROW_NUMBER() OVER (PARTITION BY c.category_name ORDER BY ROUND(SUM(od.unit_price * od.quantity)::numeric,2) DESC)
			AS sales_rank_in_category
	FROM products p
	JOIN order_details od ON p.product_id = od.product_id
	JOIN categories c ON p.category_id = c.category_id
	GROUP BY p.product_name, c.category_name)
	
SELECT *
FROM top_three_by_product
WHERE sales_rank_in_category <=3;
