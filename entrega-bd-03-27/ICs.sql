/* (RI-1) Nenhum empregado pode ter menos de 18 anos de idade */

CREATE OR REPLACE FUNCTION chk_age_of_an_employee()
RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.bdate < CURRENT_DATE - INTERVAL '18 years' THEN
        RAISE EXCEPTION 'The minimum age of the employee must be 18 years old.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_age_of_an_employee
BEFORE UPDATE OR INSERT ON employee
FOR EACH ROW EXECUTE PROCEDURE chk_age_of_an_employee();

/* (RI-2) Um 'Workplace' é obrigatoriamente um 'Office' ou 'Warehouse' mas não pode ser ambos */

CREATE OR REPLACE FUNCTION chk_type_of_workplace()
RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.address IN (SELECT address FROM office) THEN
        RAISE EXCEPTION 'This address has already been registered as an office.';

    ELSEIF NEW.address IN (SELECT address FROM warehouse) THEN
        RAISE EXCEPTION 'This address has already been registered as a warehouse.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_type_of_workplace
BEFORE UPDATE OR INSERT ON workplace
FOR EACH ROW EXECUTE PROCEDURE chk_type_of_workplace();

/* (RI-3) Uma 'Order' tem de figurar obrigatoriamente em 'Contains' */

CREATE OR REPLACE FUNCTION chk_order_in_contains()
RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.order_no NOT IN (SELECT order_no FROM contains) THEN
        RAISE EXCEPTION 'This order does not exist in Contains table.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_order_in_contains
AFTER INSERT ON orders
FOR EACH ROW EXECUTE PROCEDURE chk_order_in_contains();
