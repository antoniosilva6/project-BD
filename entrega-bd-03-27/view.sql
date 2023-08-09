/* Informações mais importantes sobre as vendas de produtos */

DROP VIEW IF EXISTS product_sales;

CREATE VIEW product_sales(
    sku, order_no, qty, total_price, year, month, day_of_month,
    day_of_week, city)
AS
SELECT c.sku, o.order_no, c.qty, (c.qty * p.price) AS total_price,
    EXTRACT(YEAR FROM o.date) AS year,
    EXTRACT(MONTH FROM o.date) AS month,
    EXTRACT(DAY FROM o.date) AS day_of_month,
    EXTRACT(DOW FROM o.date) AS day_of_week,
    SUBSTRING(cust.address, '[^,]+,[^,]+,\s*([^,]+)') AS city
FROM contains c
JOIN orders o on c.order_no = o.order_no
JOIN product p on c.sku = p.sku
JOIN pay on o.order_no = pay.order_no
JOIN customer cust on pay.cust_no = cust.cust_no;
