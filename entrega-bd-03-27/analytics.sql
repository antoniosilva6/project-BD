/* 1 - As quantidades e valores totais de venda de cada produto em 2022,
   globalmente, por cidade, por mês, dia do mês e dia da semana */

SELECT sku, city, year, month, day_of_month, day_of_week,
    SUM(qty) AS total_quantity, SUM(total_price) AS total_sales
FROM product_sales
WHERE year = 2022
GROUP BY ROLLUP(sku, city, year, month, day_of_month, day_of_week);


/* 2 - O valor médio diário das vendas de todos os produtos em 2022,
   globalmente, por mês e dia da semana */

SELECT year, month, day_of_month, day_of_week,
    AVG(total_price) AS average_daily_sales
FROM product_sales
WHERE year = 2022
GROUP BY ROLLUP(year, month, day_of_month, day_of_week);