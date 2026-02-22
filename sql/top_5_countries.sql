--Identified top-5 countries by total sales using aggregated order data.

SELECT
    o.ship_country,
    ROUND(SUM(sub.total_sales)::numeric, 2) AS total_sales
FROM orders o
JOIN (
    SELECT
        order_id,
        SUM(unit_price * quantity) AS total_sales
    FROM order_details
    GROUP BY order_id
) sub ON o.order_id = sub.order_id
GROUP BY o.ship_country
ORDER BY total_sales DESC
LIMIT 5;

--AVG Per customer
SELECT
    ROUND(
        (SUM(od.unit_price * od.quantity)::numeric) 
        / COUNT(DISTINCT c.customer_id), 2
    ) AS avg_sales_per_customer
FROM order_details od
JOIN orders o ON o.order_id = od.order_id
JOIN customers c ON c.customer_id = o.customer_id;



