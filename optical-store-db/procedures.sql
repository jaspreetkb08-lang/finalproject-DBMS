-- ============================================
-- OPTICAL STORE - PROCEDURES, FUNCTION & TRIGGERS
-- Case Study 40
-- ============================================


-- ============================================
-- 1. STORED PROCEDURE: SELL FRAME
-- ============================================

CREATE OR REPLACE PROCEDURE sell_frame(
    p_customer_id INT,
    p_frame_id INT,
    p_quantity INT,
    p_selling_price NUMERIC(10,2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_stock INT;
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM customers
        WHERE customer_id = p_customer_id
    ) THEN
        RAISE EXCEPTION 'Customer ID % does not exist', p_customer_id;
    END IF;

    SELECT stock_quantity
    INTO v_stock
    FROM frames
    WHERE frame_id = p_frame_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Frame ID % does not exist', p_frame_id;
    END IF;

    IF p_quantity <= 0 THEN
        RAISE EXCEPTION 'Quantity must be greater than zero';
    END IF;

    IF p_selling_price <= 0 THEN
        RAISE EXCEPTION 'Selling price must be greater than zero';
    END IF;

    IF v_stock < p_quantity THEN
        RAISE EXCEPTION
            'Insufficient stock. Available: %, Requested: %',
            v_stock, p_quantity;
    END IF;

    INSERT INTO frame_sales
    (customer_id, frame_id, sale_date, quantity, selling_price)
    VALUES
    (p_customer_id, p_frame_id, CURRENT_DATE, p_quantity, p_selling_price);

    UPDATE frames
    SET stock_quantity = stock_quantity - p_quantity
    WHERE frame_id = p_frame_id;

    RAISE NOTICE 'Frame sale completed successfully';
END;
$$;


-- ============================================
-- 2. STORED PROCEDURE: CREATE LENS ORDER
-- ============================================

CREATE OR REPLACE PROCEDURE create_lens_order(
    p_prescription_id INT,
    p_lens_type VARCHAR(100),
    p_lens_price NUMERIC(10,2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_expiry_date DATE;
BEGIN
    SELECT expiry_date
    INTO v_expiry_date
    FROM prescriptions
    WHERE prescription_id = p_prescription_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Prescription ID % does not exist',
            p_prescription_id;
    END IF;

    IF v_expiry_date < CURRENT_DATE THEN
        RAISE EXCEPTION
            'Prescription ID % has expired on %',
            p_prescription_id,
            v_expiry_date;
    END IF;

    IF p_lens_type IS NULL OR TRIM(p_lens_type) = '' THEN
        RAISE EXCEPTION
            'Lens type cannot be empty';
    END IF;

    IF p_lens_price <= 0 THEN
        RAISE EXCEPTION
            'Lens price must be greater than zero';
    END IF;

    INSERT INTO lens_orders
    (prescription_id, order_date, lens_type, lens_price, order_status)
    VALUES
    (p_prescription_id, CURRENT_DATE, p_lens_type, p_lens_price, 'Pending');

    RAISE NOTICE 'Lens order created successfully';
END;
$$;


-- ============================================
-- 3. USER-DEFINED FUNCTION: CUSTOMER REVENUE
-- ============================================

CREATE OR REPLACE FUNCTION calculate_customer_revenue(
    p_customer_id INT
)
RETURNS NUMERIC(12,2)
LANGUAGE plpgsql
AS $$
DECLARE
    v_frame_revenue NUMERIC(12,2);
    v_lens_revenue NUMERIC(12,2);
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM customers
        WHERE customer_id = p_customer_id
    ) THEN
        RAISE EXCEPTION
            'Customer ID % does not exist',
            p_customer_id;
    END IF;

    SELECT COALESCE(SUM(quantity * selling_price), 0)
    INTO v_frame_revenue
    FROM frame_sales
    WHERE customer_id = p_customer_id;

    SELECT COALESCE(SUM(lo.lens_price), 0)
    INTO v_lens_revenue
    FROM lens_orders lo
    JOIN prescriptions p
        ON lo.prescription_id = p.prescription_id
    WHERE p.customer_id = p_customer_id
      AND lo.order_status <> 'Cancelled';

    RETURN v_frame_revenue + v_lens_revenue;
END;
$$;


-- ============================================
-- 4. ROW-LEVEL TRIGGER FUNCTION
-- ============================================

CREATE OR REPLACE FUNCTION validate_lens_order()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_expiry_date DATE;
BEGIN
    SELECT expiry_date
    INTO v_expiry_date
    FROM prescriptions
    WHERE prescription_id = NEW.prescription_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION
            'Cannot create lens order: Prescription ID % does not exist',
            NEW.prescription_id;
    END IF;

    IF v_expiry_date < CURRENT_DATE THEN
        RAISE EXCEPTION
            'Cannot create lens order: Prescription ID % expired on %',
            NEW.prescription_id,
            v_expiry_date;
    END IF;

    RETURN NEW;
END;
$$;


-- ROW-LEVEL TRIGGER

CREATE TRIGGER trg_validate_lens_order
BEFORE INSERT ON lens_orders
FOR EACH ROW
EXECUTE FUNCTION validate_lens_order();


-- ============================================
-- 5. STATEMENT-LEVEL TRIGGER FUNCTION
-- ============================================

CREATE OR REPLACE FUNCTION check_frame_stock()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM frames
        WHERE stock_quantity < 0
    ) THEN
        RAISE EXCEPTION
            'Frame stock cannot be negative';
    END IF;

    RAISE NOTICE
        'Statement-level trigger executed: frame stock validated';

    RETURN NULL;
END;
$$;


-- STATEMENT-LEVEL TRIGGER

CREATE TRIGGER trg_check_frame_stock
AFTER UPDATE OF stock_quantity ON frames
FOR EACH STATEMENT
EXECUTE FUNCTION check_frame_stock();