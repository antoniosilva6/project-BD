/* 1 - Qual o número e nome do(s) cliente(s) com maior valor total de encomendas pagas? */

SELECT c.name, c.cust_no
FROM customer c
JOIN orders o ON c.cust_no = o.cust_no
JOIN contains ct ON o.order_no = ct.order_no
JOIN product p ON ct.sku = p.sku
JOIN pay py ON o.order_no = py.order_no
GROUP BY c.name, c.cust_no
HAVING SUM(ct.qty * p.price) = (
    SELECT MAX(total_orders_paid)
    FROM (
        SELECT SUM(ct.qty * p.price) AS total_orders_paid
        FROM customer c
        JOIN orders o ON c.cust_no = o.cust_no
        JOIN contains ct ON o.order_no = ct.order_no
        JOIN product p ON ct.sku = p.sku
        JOIN pay py ON o.order_no = py.order_no
        GROUP BY c.cust_no
    ) AS subquery
);

/* 2 - Qual o nome dos empregados que processaram encomendas em todos os dias de 2022 em que
houve encomendas? */

SELECT e.name
FROM employee e
WHERE NOT EXISTS (
    SELECT o.date
    FROM orders o
    WHERE EXTRACT(YEAR FROM o.date) = 2022
    EXCEPT
    SELECT o2.date
    FROM orders o2
    JOIN process p on o2.order_no = p.order_no
    WHERE EXTRACT(YEAR FROM o2.date) = 2022 AND
          p.ssn = e.ssn);

/* 3 - Quantas encomendas foram realizadas mas não pagas em cada mês de 2022? */

SELECT EXTRACT(MONTH FROM date) AS month, COUNT(*) AS num_orders
FROM orders
WHERE EXTRACT(YEAR FROM date) = 2022
    AND order_no NOT IN (SELECT order_no FROM pay)
GROUP BY EXTRACT(MONTH FROM date)
ORDER BY EXTRACT(MONTH FROM date);

