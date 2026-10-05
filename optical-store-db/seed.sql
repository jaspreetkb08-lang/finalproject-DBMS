INSERT INTO customers
(customer_name, phone, email, date_of_birth, last_eye_test_date)
VALUES
('Aarav Sharma', '9876543210', 'aarav.sharma@gmail.com', '1998-05-14', '2026-08-10'),
('Priya Mehta', '9876543211', 'priya.mehta@gmail.com', '1995-11-22', '2025-06-15'),
('Rohan Kapoor', '9876543212', 'rohan.kapoor@gmail.com', '2000-02-18', '2026-03-20'),
('Ananya Patel', '9876543213', 'ananya.patel@gmail.com', '1997-09-09', '2025-01-10'),
('Vikram Singh', '9876543214', 'vikram.singh@gmail.com', '1992-12-05', '2026-07-01'),
('Sneha Joshi', '9876543215', 'sneha.joshi@gmail.com', '2001-04-25', '2025-08-20'),
('Karan Malhotra', '9876543216', 'karan.malhotra@gmail.com', '1996-06-30', '2026-02-12'),
('Neha Desai', '9876543217', 'neha.desai@gmail.com', '1999-10-17', '2025-05-05'),
('Aditya Rao', '9876543218', 'aditya.rao@gmail.com', '1994-03-11', '2026-04-18'),
('Isha Verma', '9876543219', 'isha.verma@gmail.com', '2002-07-28', '2025-03-12'),
('Rahul Nair', '9876543220', 'rahul.nair@gmail.com', '1990-01-19', '2026-01-25'),
('Meera Shah', '9876543221', 'meera.shah@gmail.com', '1998-08-16', '2026-09-01');

INSERT INTO prescriptions
(customer_id, prescription_date, expiry_date, sphere_left, sphere_right,
cylinder_left, cylinder_right, axis_left, axis_right)
VALUES
(1, '2026-08-10', '2027-08-10', -1.25, -1.50, -0.50, -0.25, 90, 85),
(2, '2025-06-15', '2026-06-15', -2.00, -1.75, -0.75, -0.50, 80, 85),
(3, '2026-03-20', '2027-03-20', -0.75, -1.00, 0.00, -0.25, 0, 90),
(4, '2025-01-10', '2026-01-10', -3.00, -2.75, -1.00, -0.75, 95, 100),
(5, '2026-07-01', '2027-07-01', 1.25, 1.00, -0.50, -0.25, 75, 80),
(6, '2025-08-20', '2026-08-20', -1.50, -1.25, -0.25, -0.50, 90, 85),
(7, '2026-02-12', '2027-02-12', -2.50, -2.25, -0.75, -0.50, 100, 95),
(8, '2025-05-05', '2026-05-05', -0.50, -0.75, 0.00, -0.25, 0, 90),
(9, '2026-04-18', '2027-04-18', -1.75, -2.00, -0.50, -0.75, 85, 90),
(10, '2025-03-12', '2026-03-12', -4.00, -3.75, -1.25, -1.00, 110, 105),
(11, '2026-01-25', '2027-01-25', 0.75, 1.00, -0.25, -0.50, 80, 85),
(12, '2026-09-01', '2027-09-01', -1.00, -1.25, -0.25, 0.00, 90, 0);

INSERT INTO frames
(brand, model, frame_type, price, stock_quantity)
VALUES
('Ray-Ban', 'RB5228', 'Full Rim', 8500.00, 15),
('Titan', 'Titan EyePlus 3021', 'Full Rim', 4200.00, 20),
('Oakley', 'OX8156', 'Half Rim', 9500.00, 10),
('Vogue', 'VO5276', 'Full Rim', 6800.00, 12),
('Fastrack', 'FT1045', 'Full Rim', 2800.00, 25),
('John Jacobs', 'JJ Tortoise 201', 'Full Rim', 7500.00, 8),
('Carrera', 'CA8812', 'Half Rim', 8900.00, 7),
('Lenskart Air', 'LA EPIC 101', 'Rimless', 3200.00, 18),
('Tommy Hilfiger', 'TH 1784', 'Full Rim', 7200.00, 9),
('Gucci', 'GG 0890', 'Full Rim', 18500.00, 5),
('Vogue', 'VO4143', 'Cat Eye', 6200.00, 11),
('Ray-Ban', 'RB6335', 'Metal Frame', 10500.00, 6),
('Titan', 'Titan Flex 401', 'Flexible', 5100.00, 14),
('Oakley', 'OX3217', 'Metal Frame', 11200.00, 5),
('Fastrack', 'FT1088', 'Half Rim', 3100.00, 22);

INSERT INTO frame_sales
(customer_id, frame_id, sale_date, quantity, selling_price)
VALUES
(1, 1, '2026-08-15', 1, 8500.00),
(2, 2, '2026-08-20', 1, 4200.00),
(3, 3, '2026-09-01', 1, 9500.00),
(5, 4, '2026-08-05', 1, 6800.00),
(7, 5, '2026-09-10', 2, 2800.00),
(9, 6, '2026-09-12', 1, 7500.00),
(11, 7, '2026-08-28', 1, 8900.00),
(4, 8, '2026-07-15', 1, 3200.00),
(6, 9, '2026-09-05', 1, 7200.00),
(8, 10, '2026-09-18', 1, 18500.00),
(10, 11, '2026-08-25', 2, 6200.00),
(12, 12, '2026-09-20', 1, 10500.00),
(1, 13, '2026-09-22', 1, 5100.00),
(3, 14, '2026-09-25', 1, 11200.00),
(5, 15, '2026-09-27', 1, 3100.00),
(7, 1, '2026-09-28', 1, 8500.00),
(9, 2, '2026-09-29', 1, 4200.00),
(11, 4, '2026-09-30', 1, 6800.00);

INSERT INTO lens_orders
(prescription_id, order_date, lens_type, lens_price, order_status)
VALUES
(1, '2026-08-16', 'Anti-Glare', 3500.00, 'Delivered'),
(2, '2026-05-01', 'Blue Cut', 4200.00, 'Pending'),
(3, '2026-09-02', 'Photochromic', 5500.00, 'In Lab'),
(4, '2025-12-20', 'Anti-Glare', 3800.00, 'Delivered'),
(5, '2026-08-01', 'Progressive', 8500.00, 'Ready'),
(6, '2026-07-15', 'Blue Cut', 4500.00, 'Pending'),
(7, '2026-09-05', 'Anti-Glare', 3500.00, 'In Lab'),
(8, '2025-10-10', 'Photochromic', 5800.00, 'Delivered'),
(9, '2026-09-15', 'Blue Cut', 4200.00, 'Pending'),
(10, '2025-11-05', 'Progressive', 9000.00, 'Delivered'),
(11, '2026-08-10', 'Anti-Glare', 3600.00, 'Ready'),
(12, '2026-09-10', 'Photochromic', 5600.00, 'In Lab');

INSERT INTO lab_fulfilment
(lens_order_id, sent_to_lab_date, completed_date, lab_name)
VALUES
(1, '2026-08-17', '2026-08-21', 'Vision Lab'),
(2, '2026-05-02', NULL, 'ClearView Labs'),
(3, '2026-09-03', NULL, 'Vision Lab'),
(4, '2025-12-21', '2025-12-27', 'OptiLab Solutions'),
(5, '2026-08-02', '2026-08-07', 'ClearView Labs'),
(6, '2026-07-16', NULL, 'Vision Lab'),
(7, '2026-09-06', NULL, 'OptiLab Solutions'),
(8, '2025-10-11', '2025-10-17', 'Vision Lab'),
(9, '2026-09-16', NULL, 'ClearView Labs'),
(10, '2025-11-06', '2025-11-12', 'OptiLab Solutions'),
(11, '2026-08-11', '2026-08-15', 'Vision Lab'),
(12, '2026-09-11', NULL, 'ClearView Labs');