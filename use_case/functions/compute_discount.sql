-- Calculate and return the discount amount for a given order
CREATE OR REPLACE FUNCTION compute_discount (
    in_order_id IN orders.orderid%type,
    in_product_id IN order_details.productid%type
) RETURN order_details.discount%type IS
    discount_amount  order_details.discount%type := 0;
    customer_country customers.country%type;
    supplier_country suppliers.country%type;
BEGIN
 -- Get the customer country
    SELECT
        country INTO customer_country
    FROM
        customers
    WHERE
        customerid = (
            SELECT
                customerid
            FROM
                orders
            WHERE
                orderid = in_order_id
        );
 -- Get the supplier country
    SELECT
        country INTO supplier_country
    FROM
        suppliers
    WHERE
        supplierid = (
            SELECT
                supplierid
            FROM
                products
            WHERE
                productid = in_product_id
        );
 -- Calculate the discount amount
    IF customer_country = supplier_country THEN
        discount_amount := 0.25;
    END IF;
    RETURN discount_amount;
END compute_discount;
/

-- Test the function
BEGIN
    dbms_output.put_line( 'Discount for order 10248 is '
        || compute_discount(10248, 38) );
END;
/