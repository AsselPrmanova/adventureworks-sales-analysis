--Top 3 Employees by Revenue

WITH kpi_per_order_value AS (
SELECT
    e.first_name,
    e.last_name,
    ROUND(SUM(od.unit_price * od.quantity)::numeric / COUNT(DISTINCT od.order_id), 2) AS avg_order_value,
    ROW_NUMBER() OVER (
        ORDER BY ROUND(SUM(od.unit_price * od.quantity)::numeric / COUNT(DISTINCT od.order_id), 2) DESC
    ) AS rn
FROM order_details od
JOIN orders o ON o.order_id = od.order_id
JOIN employees e ON o.employee_id = e.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY avg_order_value DESC)
SELECT *
FROM kpi_per_order_value
WHERE rn <=3;

--Average Order Processing Time

SELECT o.employee_id, e.first_name, e.last_name,
	AVG(shipped_date - order_date) AS AVG_Processday
FROM orders o
JOIN employees e ON o.employee_id = e.employee_id
GROUP BY o.employee_id, e.first_name, e.last_name
ORDER BY AVG_Processday;


--Order Delivery Status (On-Time /Late) by Employee

SELECT e.employee_id,e.first_name, e.last_name,
COUNT(*) FILTER (WHERE o.shipped_date <= o.required_date) AS on_time,
COUNT(*) FILTER (WHERE o.shipped_date > o.required_date) AS late_orders,
( COUNT(*) FILTER (WHERE o.shipped_date <= o.required_date)::numeric ) / COUNT(*) * 100 AS on_time_rate
FROM orders o
JOIN employees e ON o.employee_id = e.employee_id
GROUP BY e.employee_id,e.first_name, e.last_name
ORDER BY on_time_rate desc;






