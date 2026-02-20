--Identified top-priced products based on average selling price.
SELECT p.product_name,
    c.category_name,
    SUM(o.unit_price * o.quantity) / SUM(o.quantity) AS avg_selling_price
FROM order_details o
JOIN products p ON o.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY p.product_name, c.category_name
ORDER BY c.category_name, avg_selling_price DESC;

--Identified top-10 products by total sales using aggregated order data.
SELECT p.product_name, ROUND(SUM(od.unit_price * od.quantity):: numeric,2) AS total_sales
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_sales desc
LIMIT 10;