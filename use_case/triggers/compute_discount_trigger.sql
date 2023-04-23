-- Create a trigger to calculate the discount amount
CREATE OR REPLACE TRIGGER compute_discount_trigger BEFORE
    INSERT OR UPDATE OF unitprice, quantity, discount ON order_details FOR EACH ROW
BEGIN
    IF :new.discount IS NULL THEN
        :new.discount := compute_discount(:new.orderid, :new.productid);
    END IF;
END compute_discount_trigger;
/

-- Insert dummy
INSERT INTO order_details (
    orderid,
    productid,
    unitprice,
    quantity
) VALUES (
    10248,
    38,
    260.00,
    25
);

-- Check the discount
SELECT
    *
FROM
    order_details
WHERE
    orderid = 10248
    AND productid = 38;

-- Delete dummy
DELETE FROM order_details
WHERE
    orderid = 10248
    AND productid = 38;