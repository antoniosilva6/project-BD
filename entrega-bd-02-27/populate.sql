-----CUSTOMERS-----

INSERT INTO customer VALUES (1001, 'Diogo Marques', 'diogo.marques@gmail.com', 968785848, 'Rua Flores Almeida');
INSERT INTO customer VALUES (2002, 'António Silva', 'antonio.silva@gmail.com', 963456987, 'Rua das Hortensias');
INSERT INTO  customer VALUES (3003, 'Leonardo Pinheiro', 'leonardo.pinheiro@gmail.com', 924569874, 'Avenida afonso II');
INSERT INTO customer VALUES  (4004, 'Joana Soares', 'joana.soares', 924789235, ' Rua Cavaco Silva');
INSERT INTO  customer VALUES (5005, 'Rita Mestre', 'rita.mestre', 963259715, 'Praceta Luiz Camões');
INSERT INTO customer VALUES (6006, 'Claudia Isabel', 'claudio.isabel@gmail.com',921458932, ' Avenida Vasco da Gama');

-----ORDER'S-----

INSERT INTO order_ VALUES (55555, '2023-01-21', 2002 );
INSERT INTO order_ VALUES (11111, '2024-06-09', 5005);
INSERT INTO  order_ VALUES (22222, '2023-03-12', 1001);
INSERT INTO  order_ VALUES (33333, '2022-12-10', 3003);
INSERT INTO  order_ VALUES (44444, '2023-11-24', 2002);

-----PRODUCTS----

INSERT INTO product VALUES (78977875, 'Mousepad', 'color red', 40.00);
INSERT INTO product VALUES (90374962, 'PEN', '64GB', 5.00);
INSERT INTO  product VALUES  (63240352, 'HDMI cable', '1M', 2.45);
INSERT INTO product VALUES (75938285, 'HeadPhones Razer', 'Bluetooth and Microphone', 70.99);
INSERT INTO product VALUES  (98771545, 'OMEN gaming mouse', 'USB, 160g', 55.99);
INSERT INTO product VALUES (97404734, 'Apple Ipods', '2nd Generation', 159.00);
INSERT INTO  product VALUES (14554963, 'Gaming OMEN Monitor', '27 INCHES', 259.00);
INSERT INTO  product VALUES (61916814, 'USB Adapter', '4 doors', 6.00);
INSERT INTO  product VALUES (25475759, 'Monitor Cleaner', '250ml Alcohol Free', 7.99);
INSERT INTO  product VALUES (80484625, 'Computer Stickers', '8uni', 6.99);

-----EMPLOYEE'S-----

INSERT INTO employee VALUES (2931641036, 460190935, '1999-12-21', 'João Carvalho' );
INSERT INTO employee VALUES (9559344515, 303765279, '2000-03-30', 'Isabel Pires');
INSERT INTO employee VALUES (5337652344, 995640197, '1985-06-02', 'Rogério Espirito Santo');
INSERT INTO employee VALUES (2602121283, 783848241, '1980-09-15', 'Ana Rebelo');
INSERT INTO employee VALUES (1290844525, 978693839, '1978-10-26', 'Afonso Maia');

-----DEPARTMENTS----

INSERT INTO department VALUES ('Marketing');
INSERT INTO department VALUES ('Logistics');
INSERT INTO department VALUES ('Delivery');

----WORKPLACES----

INSERT INTO  workplace VALUES ('Rua da fé', 5.5, 5.0);
INSERT INTO workplace VALUES ('Avenida Bento Jesus', 8.98, 5.3);

-----WAREHOUSE-----

INSERT INTO  warehouse VALUES ('Rua da fé');

-----OFFICE-----

INSERT INTO  office VALUES  ('Avenida Bento Jesus');

-----WORKS-----

INSERT INTO  works VALUES (2931641036, 'Marketing', 'Avenida Bento Jesus' );
INSERT INTO works VALUES  (9559344515, 'Logistics', 'Avenida Bento Jesus');
INSERT INTO  works VALUES (5337652344, 'Logistics', 'Avenida Bento Jesus');
INSERT INTO  works VALUES (5337652344, 'Delivery', 'Rua da fé');
INSERT INTO works VALUES (2602121283, 'Delivery', 'Rua da fé');
INSERT INTO works VALUES (1290844525, 'Delivery', 'Rua da fé');


-----SALE-----

INSERT INTO sale VALUES (11111);
INSERT INTO sale VALUES (33333);
INSERT INTO sale VALUES (55555);


-----CONTAINS-----

INSERT INTO contains VALUES (55555,90374962, 3);
INSERT INTO contains VALUES (55555, 75938285, 1);
INSERT INTO contains VALUES (33333, 97404734, 1);
INSERT INTO contains VALUES (33333,78977875, 2);
INSERT INTO contains VALUES (44444, 80484625, 5);
INSERT INTO contains VALUES (11111,14554963, 1);
INSERT INTO contains VALUES (11111,25475759, 4);
INSERT INTO contains VALUES (22222, 75938285, 1);
INSERT INTO contains VALUES (22222,61916814, 2);

-----PROCESS-----

INSERT INTO process VALUES (11111, 5337652344 );
INSERT INTO  process VALUES (55555, 1290844525);
INSERT INTO  process VALUES (33333, 9559344515);









