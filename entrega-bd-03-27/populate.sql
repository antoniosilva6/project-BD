--Customer's Functions

DROP SEQUENCE IF EXISTS phone_number;
DROP SEQUENCE IF EXISTS  sku_number;
DROP SEQUENCE IF EXISTS ssn_number;
DROP SEQUENCE IF EXISTS  ean_number;
DROP SEQUENCE IF EXISTS  tin_number;

-- Função para gerar nomes de rua
CREATE OR REPLACE FUNCTION generate_street()
    RETURNS VARCHAR AS
$$
BEGIN
    RETURN CASE floor(random() * 5)::int
        WHEN 0 THEN 'Rua ' || floor(random() * 1000)::int
        WHEN 1 THEN 'Avenida ' || floor(random() * 1000)::int
        WHEN 2 THEN 'Travessa ' || floor(random() * 1000)::int
        WHEN 3 THEN 'Largo ' || floor(random() * 1000)::int
        WHEN 4 THEN 'Praça ' || floor(random() * 1000)::int
    END;
END;
$$ LANGUAGE plpgsql;

-- Função para gerar códigos postais
CREATE OR REPLACE FUNCTION generate_postcode()
    RETURNS VARCHAR AS
$$
BEGIN
    RETURN to_char(floor(random() * 9999 + 1)::int, 'FM0000') || '-' || to_char(floor(random() * 999 + 1)::int, 'FM000');
END;
$$ LANGUAGE plpgsql;

-- Função para gerar nomes das cidades
CREATE OR REPLACE FUNCTION generate_city()
    RETURNS VARCHAR AS
$$
BEGIN
    RETURN CASE floor(random() * 5)::int
        WHEN 0 THEN 'Lisboa'
        WHEN 1 THEN 'Porto'
        WHEN 2 THEN 'Coimbra'
        WHEN 3 THEN 'Braga'
        WHEN 4 THEN 'Faro'
    END;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION generate_IDs( num INT, id INT)
RETURNS INT AS
$$

BEGIN
    RETURN CASE num
        WHEN 1 THEN  (id + 1000)
        WHEN 2 THEN  (id + 100000)
    END ;

end;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION generate_name(num INT, id INT)
RETURNS VARCHAR AS
$$
BEGIN
    RETURN CASE num
        WHEN 1 THEN 'Customer' || (id  + 1000)
        WHEN 2 THEN  'Employee' || (id + 1000)
        WHEN 3 THEN  'Supplier' || (id + 1000)
        WHEN 4 THEN  'Product' || (id + 1000)
    END;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION generate_email_customer(num INT)
RETURNS VARCHAR AS $$
DECLARE
    result VARCHAR;
BEGIN
    result := 'customer' || (num + 1000) || '@example.com';
    RETURN result;
END;
$$ LANGUAGE plpgsql;

CREATE SEQUENCE phone_number START 10000000;

CREATE OR REPLACE FUNCTION generate_phone()
RETURNS VARCHAR AS $$
DECLARE
    phone_num INTEGER;
BEGIN
    phone_num := nextval('phone_number')::INTEGER + floor(random() * 900000)::INTEGER;
    RETURN  '9' || phone_num::VARCHAR;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION generate_address()
RETURNS VARCHAR AS $$

BEGIN
    RETURN CONCAT_WS(
                    ', ',
                    generate_street(),
                    generate_postcode(),
                    generate_city(),
                    'Portugal');
end;
$$ LANGUAGE plpgsql;

INSERT INTO customer (cust_no, name, email, phone, address)
SELECT generate_IDs(1, id), generate_name(1, id), generate_email_customer(id), generate_phone(), generate_address()
FROM generate_series(1, 100) AS id;

-- Employee Functions

CREATE SEQUENCE ssn_number START 10000000000;

CREATE  SEQUENCE tin_number START 100000000;

INSERT INTO employee (ssn, tin, bdate, name)
VALUES ((nextval('ssn_number'))::VARCHAR, (nextval('tin_number')::VARCHAR), '10-12-2002', generate_name(2,1) );

INSERT INTO employee (ssn, tin, bdate, name)
VALUES ((nextval('ssn_number'))::VARCHAR, (nextval('tin_number')::VARCHAR), '12-11-1978', generate_name(2,2) );

INSERT INTO employee (ssn, tin, bdate, name)
VALUES ((nextval('ssn_number'))::VARCHAR, (nextval('tin_number')::VARCHAR), '16-01-1996', generate_name(2,3) );

INSERT INTO employee (ssn, tin, bdate, name)
VALUES ((nextval('ssn_number'))::VARCHAR, (nextval('tin_number')::VARCHAR), '22-06-2000', generate_name(2,4) );

INSERT INTO employee (ssn, tin, bdate, name)
VALUES ((nextval('ssn_number'))::VARCHAR, (nextval('tin_number')::VARCHAR), '11-03-1988', generate_name(2,5) );


-- Products Functions

CREATE SEQUENCE sku_number START 1000000000;

CREATE SEQUENCE ean_number START 1000000000000;

CREATE OR REPLACE FUNCTION generate_price()
RETURNS NUMERIC AS $$

BEGIN
    RETURN (random() * (200 - 1) + 1)::numeric(10, 2);
end;

$$ LANGUAGE plpgsql;

INSERT INTO product(sku, name, description, price, ean)
SELECT nextval('sku_number')::VARCHAR, generate_name(4,1), NULL, generate_price(), nextval('ean_number')
FROM generate_series(1, 20);

-- Supplier Functions

CREATE OR REPLACE FUNCTION choose_sku()
    RETURNS VARCHAR AS $$
DECLARE
    random_sku VARCHAR;
BEGIN
    SELECT sku INTO random_sku FROM product ORDER BY RANDOM() LIMIT 1;
    RETURN random_sku;
END;
$$ LANGUAGE plpgsql;
 /* o sku na tabela dos suppliers pode ser repetido??? */


INSERT INTO supplier(tin, name, address, sku, date)
VALUES ((nextval('tin_number')::VARCHAR), generate_name(3,1), generate_address(), choose_sku(), '02-02-2000');

INSERT INTO supplier(tin, name, address, sku, date)
VALUES ((nextval('tin_number')::VARCHAR), generate_name(3,2), generate_address(), choose_sku(), '16-05-1998');

INSERT INTO supplier(tin, name, address, sku, date)
VALUES ((nextval('tin_number')::VARCHAR), generate_name(3,3), generate_address(), choose_sku(), '20-11-1982');

INSERT INTO supplier(tin, name, address, sku, date)
VALUES ((nextval('tin_number')::VARCHAR), generate_name(3,4), generate_address(), choose_sku(), '26-02-1970');

INSERT INTO supplier(tin, name, address, sku, date)
VALUES ((nextval('tin_number')::VARCHAR), generate_name(3,5), generate_address(), choose_sku(), '10-12-1992');

INSERT INTO supplier(tin, name, address, sku, date)
VALUES ((nextval('tin_number')::VARCHAR), generate_name(3,6), generate_address(), choose_sku(), '03-04-2001');

INSERT INTO supplier(tin, name, address, sku, date)
VALUES ((nextval('tin_number')::VARCHAR), generate_name(3,7), generate_address(), choose_sku(), '20-10-1985');

INSERT INTO supplier(tin, name, address, sku, date)
VALUES ((nextval('tin_number')::VARCHAR), generate_name(3,8), generate_address(), choose_sku(), '09-11-1968');

-- Orders Functions

CREATE OR REPLACE FUNCTION get_random_customer()
    RETURNS INTEGER AS
$$
DECLARE
    random_customer INTEGER;
BEGIN
    SELECT cust_no INTO random_customer
    FROM customer
    ORDER BY random()
    LIMIT 1;

    RETURN random_customer;
END;
$$ LANGUAGE plpgsql;

INSERT INTO orders (order_no, cust_no, date)
SELECT generate_IDs(2, id), get_random_customer(), 
    CASE WHEN id <= 5 THEN date_trunc('day', '2022-01-01'::timestamp + random() * ('2022-12-31'::timestamp - '2022-01-01'::timestamp))
         ELSE date_trunc('day', '2019-01-01'::timestamp + random() * ('2021-12-31'::timestamp - '2019-01-01'::timestamp))
    END
FROM generate_series(1, 300) AS id;

-- Contains Functions
INSERT INTO contains(order_no, sku, qty)
SELECT generate_IDs(2, id), choose_sku(), floor(random() * 100) + 1
FROM generate_series(1, 300) AS id;

-- Pay Functions

INSERT INTO pay VALUES (100007, 1001);

INSERT INTO pay VALUES (100008, 1001);

INSERT INTO pay VALUES (100005, 1002);

INSERT INTO  pay VALUES (100003, 1004);

INSERT INTO pay VALUES (100012, 1001);

INSERT INTO pay VALUES (100013, 1002);

INSERT INTO pay VALUES (100014, 1004);

INSERT INTO pay VALUES (100010, 1005);


-- Process Functions

CREATE OR REPLACE FUNCTION choose_ssn()
    RETURNS VARCHAR AS $$
DECLARE
    random_ssn VARCHAR;
BEGIN
    SELECT ssn INTO random_ssn FROM employee ORDER BY RANDOM() LIMIT 1;
    RETURN random_ssn;
END;
$$ LANGUAGE plpgsql;

INSERT INTO process(ssn, order_no)
VALUES ( choose_ssn(), 100001);

INSERT INTO process(ssn, order_no)
VALUES ( choose_ssn(), 100002);

INSERT INTO process(ssn, order_no)
VALUES ( choose_ssn(), 100003);

INSERT INTO process(ssn, order_no)
VALUES ( choose_ssn(), 100004);

INSERT INTO process(ssn, order_no)
VALUES ( choose_ssn(), 100005);

INSERT INTO process(ssn, order_no)
VALUES ( choose_ssn(), 100006);

INSERT INTO process(ssn, order_no)
VALUES ( choose_ssn(), 100007);

INSERT INTO process(ssn, order_no)
VALUES ( choose_ssn(), 100008);

INSERT INTO process(ssn, order_no)
VALUES ( choose_ssn(), 100009);

INSERT INTO process(ssn, order_no)
VALUES ( choose_ssn(), 100010);

INSERT INTO process(ssn, order_no)
VALUES ( choose_ssn(), 100011);

INSERT INTO process(ssn, order_no)
VALUES ( choose_ssn(), 100012);

INSERT INTO process(ssn, order_no)
VALUES ( choose_ssn(), 100013);

INSERT INTO process(ssn, order_no)
VALUES ( choose_ssn(), 100014);

UPDATE process SET ssn = '10000000001' WHERE order_no = 100002;
UPDATE process SET ssn = '10000000001' WHERE order_no = 100003;
UPDATE process SET ssn = '10000000001' WHERE order_no = 100001;
UPDATE process SET ssn = '10000000001' WHERE order_no = 100004;
UPDATE process SET ssn = '10000000001' WHERE order_no = 100005;
