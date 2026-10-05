CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_of_birth DATE,
    last_eye_test_date DATE
);

CREATE TABLE prescriptions (
    prescription_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    prescription_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    sphere_left NUMERIC(5,2),
    sphere_right NUMERIC(5,2),
    cylinder_left NUMERIC(5,2),
    cylinder_right NUMERIC(5,2),
    axis_left INT,
    axis_right INT,

    CONSTRAINT fk_prescription_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT valid_prescription_dates
        CHECK (expiry_date > prescription_date)
);

CREATE TABLE frames (
    frame_id SERIAL PRIMARY KEY,
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    frame_type VARCHAR(50),
    price NUMERIC(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,

    CONSTRAINT valid_frame_price CHECK (price > 0),
    CONSTRAINT valid_stock CHECK (stock_quantity >= 0)
);

CREATE TABLE frame_sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    frame_id INT NOT NULL,
    sale_date DATE NOT NULL DEFAULT CURRENT_DATE,
    quantity INT NOT NULL DEFAULT 1,
    selling_price NUMERIC(10,2) NOT NULL,

    CONSTRAINT fk_sale_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_sale_frame
        FOREIGN KEY (frame_id)
        REFERENCES frames(frame_id),

    CONSTRAINT valid_sale_quantity CHECK (quantity > 0),
    CONSTRAINT valid_selling_price CHECK (selling_price > 0)
);

CREATE TABLE lens_orders (
    lens_order_id SERIAL PRIMARY KEY,
    prescription_id INT NOT NULL,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    lens_type VARCHAR(100) NOT NULL,
    lens_price NUMERIC(10,2) NOT NULL,
    order_status VARCHAR(30) NOT NULL DEFAULT 'Pending',

    CONSTRAINT fk_lens_prescription
        FOREIGN KEY (prescription_id)
        REFERENCES prescriptions(prescription_id),

    CONSTRAINT valid_lens_price CHECK (lens_price > 0),

    CONSTRAINT valid_order_status
        CHECK (
            order_status IN
            ('Pending', 'In Lab', 'Ready', 'Delivered', 'Cancelled')
        )
);

CREATE TABLE lab_fulfilment (
    fulfilment_id SERIAL PRIMARY KEY,
    lens_order_id INT NOT NULL UNIQUE,
    sent_to_lab_date DATE NOT NULL,
    completed_date DATE,
    lab_name VARCHAR(100) NOT NULL,

    CONSTRAINT fk_fulfilment_order
        FOREIGN KEY (lens_order_id)
        REFERENCES lens_orders(lens_order_id),

    CONSTRAINT valid_fulfilment_dates
        CHECK (
            completed_date IS NULL
            OR completed_date >= sent_to_lab_date
        )
);