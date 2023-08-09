DROP TABLE  IF EXISTS sale;

DROP TABLE IF EXISTS office;

DROP TABLE IF EXISTS ean_product;

DROP TABLE IF EXISTS process;

DROP TABLE IF EXISTS works;

DROP TABLE IF EXISTS employee;

DROP TABLE IF EXISTS department;

DROP TABLE IF EXISTS pay;

DROP TABLE IF EXISTS delivery;

DROP TABLE IF EXISTS warehouse;

DROP TABLE IF EXISTS workplace;

DROP TABLE IF EXISTS supplier;

DROP TABLE IF EXISTS contains;

DROP TABLE IF EXISTS order_;

DROP TABLE IF EXISTS product;

DROP TABLE IF EXISTS customer;


CREATE TABLE customer
(
    cust_no VARCHAR(36) ,
    name VARCHAR(80) NOT NULL ,
    email VARCHAR(254) NOT NULL ,
    phone VARCHAR(15) NOT NULL ,
    address VARCHAR(255) NOT NULL ,
    PRIMARY KEY (cust_no),
    UNIQUE (email)
    --IC-1: Customer can only pay for the sale of an order they have placed themselves
);

CREATE TABLE  order_
(
    order_no VARCHAR(36),
    date DATE NOT NULL ,
    cust_no VARCHAR(36) NOT NULL ,
    PRIMARY KEY (order_no),
    FOREIGN KEY (cust_no)
        REFERENCES customer(cust_no)
    --IC-2: Every order must contain one or more products
);

CREATE TABLE sale
(
    order_no VARCHAR(36) NOT NULL ,
    FOREIGN KEY (order_no)
        REFERENCES order_(order_no)
);

CREATE TABLE pay
(
    order_no VARCHAR(36),
    cust_no VARCHAR(36) NOT NULL ,
    PRIMARY KEY (order_no),
    FOREIGN KEY (order_no)
        REFERENCES order_(order_no),
    FOREIGN KEY (cust_no)
        REFERENCES  customer(cust_no)
);

CREATE TABLE employee
(
    ssn CHAR(11),
    TIN CHAR(9) NOT NULL ,
    bdate DATE NOT NULL ,
    name VARCHAR(80) NOT NULL ,
    UNIQUE (TIN),
    PRIMARY KEY (ssn)
    --IC-3: An employee must work in a Department and a Workplace
);

CREATE TABLE department
(
    name VARCHAR(255),
    PRIMARY KEY (name)
);

CREATE TABLE workplace
(
    address VARCHAR(255),
    lat NUMERIC(8, 6) NOT NULL ,
    long NUMERIC(9, 6) NOT NULL ,
    UNIQUE (lat,long),
    PRIMARY KEY (address)
);

CREATE TABLE office
(
    address VARCHAR(255),
    PRIMARY KEY (address),
    FOREIGN KEY (address)
        REFERENCES workplace(address)
);

CREATE TABLE warehouse
(
    address VARCHAR(255),
    PRIMARY KEY (address),
    FOREIGN KEY (address)
        REFERENCES workplace(address)
);

CREATE TABLE  product
(
    sku CHAR(36),
    name VARCHAR(255) NOT NULL ,
    description text NOT NULL ,
    price NUMERIC(16,4) NOT NULL ,
    PRIMARY KEY (sku),
    CHECK ( price > 0 )
    --IC-4: Every sku must participate in Supplier
);

CREATE TABLE  EAN_product
(
    sku CHAR(36),
    ean CHAR(36) NOT NULL ,
    PRIMARY KEY (sku)
);

CREATE TABLE supplier
(
    TIN CHAR(9) NOT NULL ,
    name VARCHAR(80) NOT NULL ,
    address VARCHAR(255) NOT NULL ,
    sku CHAR(36),
    date date NOT NULL ,
    PRIMARY KEY (TIN),
    FOREIGN KEY (sku)
        REFERENCES product(sku)
);

CREATE TABLE contains
(
    order_no CHAR(36),
    sku CHAR(36),
    qty INTEGER NOT NULL,
    CHECK ( qty > 0 ),
    PRIMARY KEY (order_no, sku),
    FOREIGN KEY (order_no)
        REFERENCES order_(order_no),
    FOREIGN KEY  (sku)
        REFERENCES product(sku)
);

CREATE  TABLE process
(
    order_no CHAR(36),
    ssn CHAR(11),
    PRIMARY KEY (order_no, ssn),
    FOREIGN KEY (order_no)
        REFERENCES order_(order_no),
    FOREIGN KEY (ssn)
        REFERENCES employee(ssn)
);

CREATE TABLE works
(
    ssn CHAR(11) ,
    name VARCHAR(80) ,
    address VARCHAR(255) ,
    PRIMARY KEY (ssn, name, address),
    FOREIGN KEY (ssn)
        REFERENCES employee(ssn),
    FOREIGN KEY (name)
        REFERENCES  department(name),
    FOREIGN KEY (address)
        REFERENCES  workplace(address)
);

CREATE TABLE delivery
(
    address VARCHAR(255) ,
    TIN CHAR(9) ,
    PRIMARY KEY (address, TIN),
    FOREIGN KEY (address)
        REFERENCES warehouse(address),
    FOREIGN KEY (TIN)
        REFERENCES supplier(TIN)
);
