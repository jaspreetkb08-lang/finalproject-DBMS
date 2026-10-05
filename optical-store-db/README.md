# Optical Store Prescription and Frame Sales Database

## Case Study 40

### Subject
DBMS - SQL & NoSQL

### Database
PostgreSQL

---

## 1. Project Overview

This project implements an Optical Store Prescription and Frame Sales Management System using PostgreSQL.

The system manages customers, eye-test prescriptions, optical frames, frame sales, lens orders and laboratory fulfilment.

The database also implements stored procedures, a user-defined function and triggers to enforce business rules at the database level.

---

## 2. Problem Statement

An optical store records eye-test prescriptions, sells frames and lenses against them, and tracks order fulfilment from the laboratory.

The database must support business questions related to pending lens orders, frame sales, customer eye-test dates, revenue and expired prescriptions.

A lens order must always be associated with a valid and unexpired prescription.

---

## 3. Objectives

- Model customers, prescriptions, frames, lens orders and laboratory fulfilment.
- Maintain relationships using primary and foreign keys.
- Implement stored procedures for complete business operations.
- Implement a user-defined function for reusable revenue calculation.
- Implement a row-level trigger for prescription validation.
- Implement a statement-level trigger for frame-stock validation.
- Use filtering, sorting, aggregation, GROUP BY, HAVING, joins and subqueries.
- Test valid and invalid inputs.
- Maintain realistic sample data.

---

## 4. Database Tables

The database contains the following tables:

1. customers
2. prescriptions
3. frames
4. frame_sales
5. lens_orders
6. lab_fulfilment

---

## 5. Stored Procedures

### 5.1 sell_frame

The `sell_frame` procedure performs the complete frame-selling operation.

It:

- validates the customer
- validates the frame
- validates quantity
- validates selling price
- checks available stock
- inserts the frame sale
- updates frame stock

Invalid inputs generate meaningful error messages.

### 5.2 create_lens_order

The `create_lens_order` procedure creates a lens order against a prescription.

It:

- checks whether the prescription exists
- checks whether the prescription is expired
- validates the lens type
- validates the lens price
- creates the lens order with Pending status

Expired prescriptions are rejected.

---

## 6. User-Defined Function

### calculate_customer_revenue

The `calculate_customer_revenue` function calculates the total revenue generated from a customer.

It combines:

- frame sales revenue
- lens order revenue

The function also validates the customer ID.

---

## 7. Triggers

### 7.1 Row-Level Trigger

`trg_validate_lens_order` is a row-level trigger on the `lens_orders` table.

It checks every new lens order and ensures that its prescription exists and has not expired.

### 7.2 Statement-Level Trigger

`trg_check_frame_stock` is a statement-level trigger on the `frames` table.

It ensures that frame stock does not become negative after a stock update statement.

---

## 8. Row-Level vs Statement-Level Trigger

A row-level trigger executes once for every affected row.

A statement-level trigger executes once for the complete SQL statement, regardless of the number of rows affected.

In this project, the lens-order validation trigger is row-level because every lens order needs individual prescription validation.

The frame-stock validation trigger is statement-level because the resulting stock state is checked after the complete update statement.

---

## 9. Business Queries

The project implements queries for:

1. Pending lens orders at the laboratory for more than seven days.
2. Number of frames sold per brand.
3. Customers due for a fresh eye test.
4. Revenue from frames compared with lenses.
5. Expired prescriptions.
6. Brands with more than two frames sold using GROUP BY and HAVING.

---

## 10. Design Decisions

### Separate Prescription Table

Prescriptions are stored separately from customers because a customer can have multiple prescriptions over time.

### Separate Frame Sales Table

Frame inventory and frame sales are separated so that current stock and sales history can be maintained independently.

### Separate Laboratory Fulfilment Table

Laboratory processing information is maintained separately from lens orders because fulfilment contains operational information such as laboratory name, sent date and completion date.

### Database-Level Validation

Stored procedures and triggers were used to enforce important business rules at the database level.

---

## 11. Testing

Both valid and invalid inputs were tested for:

- Stored procedures
- User-defined function
- Row-level trigger
- Statement-level trigger

Invalid operations were rejected with meaningful error messages.

---

## 12. Project Files

- `schema.sql` — database tables and constraints
- `seed.sql` — realistic sample data
- `queries.sql` — business queries
- `procedures.sql` — procedures, function and triggers
- `README.md` — project documentation and design decisions

---

## 13. Conclusion

The Optical Store Prescription and Frame Sales Database successfully models the main operations of an optical store using PostgreSQL.

The project demonstrates relational database design, constraints, joins, aggregation, stored procedures, user-defined functions and triggers.

The implemented database rules ensure data integrity and prevent invalid operations such as creating lens orders against expired prescriptions or allowing negative frame stock.