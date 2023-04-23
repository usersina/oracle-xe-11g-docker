-- Increase the unit price of a given product by a percentage.
CREATE OR REPLACE PROCEDURE increase_product_price (
    in_productid IN products.productid%type,
    in_percentage IN NUMBER
) IS
BEGIN
    IF (in_percentage > 20) THEN
        raise_application_error(-20001, 'Percentage is too high. Cannot increase price by more than 20%.');
    END IF;
    IF (in_percentage < 0) THEN
        raise_application_error(-20002, 'Invalid negative percentage. Cannot incease product price.');
    END IF;
    UPDATE products
    SET
        unitprice = unitprice * (
            1 + (in_percentage / 100)
        )
    WHERE
        productid = in_productid;
END increase_product_price;
/

-- Test the procedure
BEGIN
    increase_product_price(1, 20);
END;