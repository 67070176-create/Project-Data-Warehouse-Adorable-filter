-- 1. Create Schema
CREATE SCHEMA IF NOT EXISTS raw;

-- 2. Create Raw Tables
CREATE TABLE IF NOT EXISTS raw.orders (
    order_id INT,
    customer_id INT,
    store_id INT,
    order_date DATE,
    promotion_id INT
);

CREATE TABLE IF NOT EXISTS raw.order_items (
    order_item_id INT,
    order_id INT,
    product_id INT,
    qty INT,
    price NUMERIC(10,2)
);

CREATE TABLE IF NOT EXISTS raw.payments (
    payment_id INT,
    order_id INT,
    amount NUMERIC(10,2)
);

CREATE TABLE IF NOT EXISTS raw.shipments (
    shipment_id INT,
    order_id INT,
    status VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS raw.returns (
    return_id INT,
    order_item_id INT,
    refund NUMERIC(10,2)
);

CREATE TABLE IF NOT EXISTS raw.customers (
    customer_id INT,
    city VARCHAR(100),
    signup_date DATE
);

CREATE TABLE IF NOT EXISTS raw.products (
    product_id INT,
    category_id INT,
    supplier_id INT,
    price NUMERIC(10,2)
);

CREATE TABLE IF NOT EXISTS raw.employees (
    employee_id INT,
    store_id INT,
    salary INT
);

-- 3. Truncate for Idempotency (Re-runnable)
TRUNCATE TABLE 
    raw.orders,
    raw.order_items,
    raw.payments,
    raw.shipments,
    raw.returns,
    raw.customers,
    raw.products,
    raw.employees CASCADE;