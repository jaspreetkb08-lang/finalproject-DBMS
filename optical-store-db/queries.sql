-- Q1. Pending lens orders at lab for more than 7 days

SELECT
    lo.lens_order_id,
    c.customer_name,
    lo.lens_type,
    lo.order_date,
    lf.sent_to_lab_date,
    CURRENT_DATE - lf.sent_to_lab_date AS days_at_lab
FROM lens_orders lo
JOIN prescriptions p
    ON lo.prescription_id = p.prescription_id
JOIN customers c
    ON p.customer_id = c.customer_id
JOIN lab_fulfilment lf
    ON lo.lens_order_id = lf.lens_order_id
WHERE lo.order_status IN ('Pending', 'In Lab')
  AND lf.completed_date IS NULL
  AND CURRENT_DATE - lf.sent_to_lab_date > 7
ORDER BY days_at_lab DESC;


-- Q2. How many frames were sold per brand?

SELECT
    f.brand,
    SUM(fs.quantity) AS total_frames_sold
FROM frames f
JOIN frame_sales fs
    ON f.frame_id = fs.frame_id
GROUP BY f.brand
ORDER BY total_frames_sold DESC;


-- Q3. Customers due for a fresh eye test

SELECT
    customer_id,
    customer_name,
    last_eye_test_date,
    last_eye_test_date + INTERVAL '1 year' AS next_eye_test_due
FROM customers
WHERE last_eye_test_date + INTERVAL '1 year' <= CURRENT_DATE
ORDER BY next_eye_test_due;


-- Q4. Revenue from frames compared with lenses

SELECT
    'Frames' AS product_category,
    SUM(quantity * selling_price) AS total_revenue
FROM frame_sales

UNION ALL

SELECT
    'Lenses' AS product_category,
    SUM(lens_price) AS total_revenue
FROM lens_orders
WHERE order_status <> 'Cancelled';


-- Q5. Which prescriptions have expired?

SELECT
    p.prescription_id,
    c.customer_name,
    p.prescription_date,
    p.expiry_date
FROM prescriptions p
JOIN customers c
    ON p.customer_id = c.customer_id
WHERE p.expiry_date < CURRENT_DATE
ORDER BY p.expiry_date;


-- Q6. Brands with more than 2 frames sold

SELECT
    f.brand,
    SUM(fs.quantity) AS total_frames_sold
FROM frames f
JOIN frame_sales fs
    ON f.frame_id = fs.frame_id
GROUP BY f.brand
HAVING SUM(fs.quantity) > 2
ORDER BY total_frames_sold DESC;