--1.
SELECT customer.name
FROM customer
    JOIN order_ ON customer.cust_no = order_.cust_no
    JOIN contains ON order_.order_no = contains.order_no
    JOIN product ON contains.sku = product.sku
WHERE product.price > 50
    AND date >= '2023-01-01' AND date <= '2023-12-31';

--2.
SELECT warehouseEmployees.name
FROM (
    SELECT employee.name
    FROM employee
    JOIN works ON employee.ssn = works.ssn
    JOIN warehouse ON works.address = warehouse.address
) AS warehouseEmployees
LEFT JOIN (
    SELECT employee.name
    FROM employee
    JOIN works ON employee.ssn = works.ssn
    JOIN office ON works.address = office.address
) AS officeEmployees
ON warehouseEmployees.name = officeEmployees.name
WHERE officeEmployees.name IS NULL
AND warehouseEmployees.name IN (
    SELECT employee.name
    FROM order_
    JOIN process ON order_.order_no = process.order_no
    JOIN employee ON process.ssn = employee.ssn
    WHERE date >= '2023-01-01' AND date <= '2023-01-31');

--3.
SELECT name
FROM (
    SELECT name, SUM(qty) AS total_qty
    FROM order_
    JOIN sale ON order_.order_no = sale.order_no
    JOIN contains ON sale.order_no = contains.order_no
    JOIN product ON contains.sku = product.sku
    GROUP BY name
) AS sales
WHERE total_qty = (
    SELECT MAX(total_qty)
    FROM (
        SELECT name, SUM(qty) AS total_qty
        FROM order_
        JOIN sale ON order_.order_no = sale.order_no
        JOIN contains ON sale.order_no = contains.order_no
        JOIN product ON contains.sku = product.sku
        GROUP BY name
    ) AS numSales
);

--4.
SELECT s.order_no, SUM(c.qty * p.price) AS total_sale_value
FROM sale s
    JOIN contains c ON s.order_no = c.order_no
    JOIN product p ON c.sku = p.sku
GROUP BY s.order_no;









