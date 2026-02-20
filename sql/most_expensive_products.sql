--Identified the most expensive products in each category using ranking
SELECT p.product_name, 
	   c.category_name, MAX(p.unit_price) AS max_price,
	   ROW_NUMBER () OVER (PARTITION BY c.category_name ORDER BY MAX(p.unit_price) desc) AS rank_in_category
FROM products p
JOIN categories c ON p.category_id = c.category_id
GROUP by p.product_name, c.category_name
ORDER BY c.category_name, max_price desc