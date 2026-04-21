-- =====================================
-- STEP 1: Explore raw orders
-- =====================================
-- SELECT * 
-- FROM `alert-groove-494023-m0.raw.orders`
-- LIMIT 10;


-- =====================================
-- STEP 2: Count total orders
-- =====================================
-- SELECT COUNT(*) AS total_orders
-- FROM `alert-groove-494023-m0.raw.orders`;


-- =====================================
-- STEP 3: Join orders + customers
-- =====================================
-- SELECT 
--   o.order_id,
--   o.customer_id,
--   c.customer_city
-- FROM `alert-groove-494023-m0.raw.orders` o
-- JOIN `alert-groove-494023-m0.raw.customers` c
-- ON o.customer_id = c.customer_id
-- LIMIT 10;


-- =====================================
-- STEP 4: Create enriched table
-- =====================================
-- CREATE OR REPLACE TABLE `alert-groove-494023-m0.staging.orders_enriched` AS
-- SELECT 
--   o.order_id,
--   o.customer_id,
--   c.customer_city,
--   c.customer_state,
--   o.order_status,
--   DATE(o.order_purchase_timestamp) AS order_date
-- FROM `alert-groove-494023-m0.raw.orders` o
-- JOIN `alert-groove-494023-m0.raw.customers` c
-- ON o.customer_id = c.customer_id;


-- =====================================
-- STEP 5: Revenue aggregation (RUN THIS NOW)
-- =====================================
SELECT 
  o.order_id,
  COUNT(oi.order_item_id) AS total_items,
  SUM(oi.price) AS total_revenue
FROM `alert-groove-494023-m0.raw.orders` o
JOIN `alert-groove-494023-m0.raw.order_items` oi
ON o.order_id = oi.order_id
GROUP BY o.order_id
LIMIT 10;