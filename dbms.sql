DROP DATABASE IF EXISTS FarmaQuik;
CREATE DATABASE IF NOT EXISTS FarmaQuik;
USE FarmaQuik;

CREATE TABLE IF NOT EXISTS Supplier (
    supplier_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS User (
    user_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    phone_number VARCHAR(20),
    recovery_email VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Orders (
    Orders_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_id INT,
    Orders_status VARCHAR(255),
    Orders_date DATE,
    prescription_verified BOOLEAN,
    return_request BOOLEAN,
    return_status VARCHAR(255),
    transaction_id INT,
    return_transaction_id INT,
    delivery_id INT,
    FOREIGN KEY (user_id) REFERENCES  User(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    role VARCHAR(255),
    phone_number VARCHAR(20),
    email VARCHAR(255),
    dob DATE,
    hire_date DATE
);

CREATE TABLE IF NOT EXISTS Delivery_Partner (
    employee_id INT PRIMARY KEY,
    permissions VARCHAR(255),
    FOREIGN KEY (employee_id) REFERENCES  Employee(employee_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Admin (
    employee_id INT PRIMARY KEY,
    permissions VARCHAR(255),
    FOREIGN KEY (employee_id) REFERENCES  Employee(employee_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Deliveries (
    employee_id INT,
    delivery_status VARCHAR(255),
    Orders_id INT,
    FOREIGN KEY (employee_id) REFERENCES  Delivery_Partner(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (Orders_id) REFERENCES  Orders(Orders_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Product (
    product_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    description TEXT,
    price DECIMAL(10, 2),
    manufacturer VARCHAR(255),
    expiry_date DATE,
    stock_quantity INT,
    category VARCHAR(255),
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES  Supplier(supplier_id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS review (
    user_id INT,
    product_id INT,
    review TEXT,
    rating INT,
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES  User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES  Product(product_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS address (
    user_id INT,
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    pincode VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES  User(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Transaction (
    transaction_id INT PRIMARY KEY auto_increment,
    Orders_id INT,
    transaction_date DATE,
    amount DECIMAL(10, 2),
    payment_method VARCHAR(255),
    FOREIGN KEY (Orders_id) REFERENCES  Orders(Orders_id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS Inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES  Product(product_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Supply (
    supplier_id INT,
    product_id INT,
    Supply_Date DATE,
    quantity INT,
    transaction_id INT,
    PRIMARY KEY (supplier_id, product_id),
    FOREIGN KEY (supplier_id) REFERENCES  Supplier(supplier_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES  Product(product_id) ON DELETE CASCADE,
    FOREIGN KEY (transaction_id) REFERENCES  Transaction(transaction_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Cart (
    user_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES  User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES  Product(product_id) ON DELETE CASCADE
);

INSERT INTO Supplier (name, email, phone_number) VALUES
('ABC Pharma', 'abc@example.com', '123-456-7890'),
('XYZ Suppliers', 'xyz@example.com', '987-654-3210'),
('MediCo', 'medico@example.com', '456-789-0123'),
('HealthCare Distributors', 'healthcare@example.com', '789-012-3456'),
('PharmaDirect', 'pharmadirect@example.com', '321-654-0987'),
('MediSupply', 'medisupply@example.com', '654-321-9870'),
('MediLife', 'medilife@example.com', '987-321-4560'),
('Wellness Pharma', 'wellness@example.com', '654-987-0123'),
('Healthy Choice', 'healthychoice@example.com', '789-654-2013'),
('CareMeds', 'caremeds@example.com', '012-345-6789');

INSERT INTO User (first_name, last_name, email, password, phone_number, recovery_email) VALUES
('John', 'Doe', 'john@example.com', 'password123', '987-654-3210', 'john.recovery@example.com'),
('Alice', 'Smith', 'alice@example.com', 'alicepass', '123-456-7890', 'alice.recovery@example.com'),
('Bob', 'Johnson', 'bob@example.com', 'bobpassword', '456-789-0123', 'bob.recovery@example.com'),
('Emma', 'Brown', 'emma@example.com', 'emmapass', '789-012-3456', 'emma.recovery@example.com'),
('Michael', 'Taylor', 'michael@example.com', 'michaelpass', '321-654-0987', 'michael.recovery@example.com'),
('Sophia', 'Lee', 'sophia@example.com', 'sophiapass', '654-321-9870', 'sophia.recovery@example.com'),
('Olivia', 'White', 'olivia@example.com', 'oliviapass', '987-321-4560', 'olivia.recovery@example.com'),
('William', 'Martinez', 'william@example.com', 'williampass', '654-987-0123', 'william.recovery@example.com'),
('James', 'Garcia', 'james@example.com', 'jamespass', '789-654-2013', 'james.recovery@example.com'),
('Emily', 'Lopez', 'emily@example.com', 'emilypass', '012-345-6789', 'emily.recovery@example.com');

INSERT INTO Orders (user_id, Orders_status, Orders_date, prescription_verified, return_request, return_status, transaction_id, return_transaction_id, delivery_id) VALUES
(1, 'Pending', '2024-03-06', true, false, NULL, 1234, NULL, 5678),
(2, 'Delivered', '2024-03-05', true, true, 'Pending', 5678, 9012, 3456),
(3, 'Processing', '2024-03-04', false, false, NULL, 9012, NULL, 7890),
(4, 'Shipped', '2024-03-03', true, false, NULL, 2345, NULL, 8901),
(5, 'Cancelled', '2024-03-02', false, true, 'Processing', 3456, 6789, 1234),
(6, 'Pending', '2024-03-01', true, false, NULL, 4567, NULL, 2345),
(7, 'Delivered', '2024-02-29', true, true, 'Delivered', 5678, 9012, 3456),
(8, 'Processing', '2024-02-28', false, false, NULL, 6789, NULL, 7890),
(9, 'Shipped', '2024-02-27', true, false, NULL, 7890, NULL, 8901),
(10, 'Pending', '2024-02-26', true, false, NULL, 8901, NULL, 2345);

INSERT INTO Employee (employee_id, first_name, last_name, role, phone_number, email, dob, hire_date) VALUES
(1, 'John', 'Smith', 'Manager', '987-654-3210', 'john.smith@example.com', '1980-05-15', '2010-02-15'),
(2, 'Alice', 'Johnson', 'Sales Associate', '123-456-7890', 'alice.johnson@example.com', '1990-08-20', '2015-06-10'),
(3, 'Michael', 'Brown', 'Delivery Driver', '456-789-0123', 'michael.brown@example.com', '1985-03-10', '2018-04-25'),
(4, 'Emma', 'Garcia', 'Pharmacist', '789-012-3456', 'emma.garcia@example.com', '1988-12-02', '2017-09-30'),
(5, 'Sophia', 'Martinez', 'Store Clerk', '321-654-0987', 'sophia.martinez@example.com', '1992-10-18', '2019-11-15'),
(6, 'Olivia', 'Lee', 'Customer Support', '654-321-9870', 'olivia.lee@example.com', '1994-07-25', '2020-08-20'),
(7, 'William', 'Lopez', 'Pharmacy Technician', '987-321-4560', 'william.lopez@example.com', '1982-02-28', '2016-03-05'),
(8, 'James', 'Gonzalez', 'Warehouse Manager', '654-987-0123', 'james.gonzalez@example.com', '1975-11-12', '2014-12-10'),
(9, 'Emily', 'Hernandez', 'Inventory Clerk', '789-654-2013', 'emily.hernandez@example.com', '1987-09-07', '2013-07-20'),
(10, 'Daniel', 'Perez', 'IT Specialist', '012-345-6789', 'daniel.perez@example.com', '1983-04-30', '2012-01-15');

INSERT INTO Delivery_Partner (employee_id, permissions) VALUES
(1, 'Driver'),
(2, 'Driver'),
(3, 'Driver'),
(4, 'Driver'),
(5, 'Driver');

INSERT INTO Admin (employee_id, permissions) VALUES
(6, 'Admin'),
(7, 'Admin'),
(8, 'Admin'),
(9, 'Admin'),
(10, 'Admin');

INSERT INTO Deliveries (employee_id, delivery_status, Orders_id) VALUES
(3, 'Delivered', 1),
(5, 'In Transit', 2),
(4, 'Delivered', 3),
(5, 'In Transit', 4),
(1, 'Pending', 5),
(2, 'Delivered', 6),
(3, 'In Transit', 7),
(4, 'Pending', 8),
(3, 'Delivered', 9),
(1, 'In Transit', 10);


INSERT INTO Product (name, description, price, manufacturer, expiry_date, stock_quantity, category, supplier_id) VALUES
('Paracetamol', 'Pain reliever', 5.99, 'Generic Pharma', '2022-12-31', 100, 'Medicine', 1),
('Amoxicillin', 'Antibiotic', 10.50, 'Global Pharmaceuticals', '2024-10-31', 0, 'Medicine', 2),
('Bandages', 'Sterile bandages', 3.25, 'MediSupply Inc.', '2025-06-30', 200, 'Medical Supplies', 3),
('Multivitamin', 'Daily nutritional supplement', 8.99, 'VitaLife Labs', '2024-09-30', 150, 'Healthcare', 4),
('Insulin', 'Diabetes medication', 25.75, 'Diabetes Care Inc.', '2024-08-31', 30, 'Medicine', 5),
('Inhaler', 'Asthma inhaler', 15.49, 'RespiTech', '2025-03-31', 40, 'Medicine', 6),
('Thermometer', 'Digital thermometer', 9.99, 'MediTools', '2025-12-31', 100, 'Medical Equipment', 7),
('Face Masks', 'Disposable face masks', 1.99, 'Safety Gear Inc.', '2024-06-30', 500, 'Medical Supplies', 8),
('Blood Pressure Monitor', 'Electronic BP monitor', 29.99, 'HealthTech Solutions', '2025-04-30', 20, 'Medical Equipment', 9),
('Allergy Medication', 'Antihistamine tablets', 12.75, 'Allergy Relief Inc.', '2024-11-30', 80, 'Medicine', 10);


INSERT INTO review (user_id, product_id, review, rating) VALUES
(1, 1, 'Works well for headaches', 4),
(2, 2, 'Effective antibiotic', 5),
(3, 3, 'Good quality bandages', 4),
(4, 4, 'Great multivitamin, highly recommend', 5),
(5, 5, 'Essential for diabetes management', 4),
(6, 6, 'Relieves asthma symptoms quickly', 5),
(7, 7, 'Accurate readings, easy to use', 4),
(8, 8, 'Comfortable and breathable masks', 5),
(9, 9, 'Helps monitor BP accurately', 4),
(10, 10, 'Relieves allergy symptoms effectively', 5);


INSERT INTO address (user_id, street, city, state, country, pincode) VALUES
(1, '123 Main St', 'New York', 'NY', 'USA', '10001'),
(2, '456 Oak Ave', 'Los Angeles', 'CA', 'USA', '90001'),
(3, '789 Maple Blvd', 'Chicago', 'IL', 'USA', '60001'),
(4, '101 Pine St', 'Houston', 'TX', 'USA', '77001'),
(5, '222 Elm St', 'Philadelphia', 'PA', 'USA', '19019'),
(6, '333 Cedar Ave', 'Phoenix', 'AZ', 'USA', '85001'),
(7, '444 Birch St', 'San Antonio', 'TX', 'USA', '78201'),
(8, '555 Walnut Ave', 'San Diego', 'CA', 'USA', '92101'),
(9, '666 Willow Blvd', 'Dallas', 'TX', 'USA', '75201'),
(10, '777 Spruce St', 'San Jose', 'CA', 'USA', '95101');


INSERT INTO Transaction (transaction_id, Orders_id, transaction_date, amount, payment_method) VALUES
(1234, 1, '2024-03-06', 35.97, 'Credit Card'),
(5678, 2, '2024-03-05', 42.00, 'PayPal'),
(9012, 3, '2024-03-04', 30.75, 'Credit Card'),
(2345, 4, '2024-03-03', 128.75, 'Credit Card'),
(3456, 5, '2024-03-02', 19.90, 'PayPal'),
(4567, 6, '2024-03-01', 46.47, 'Credit Card'),
(6789, 7, '2024-02-29', 37.98, 'Credit Card'),
(7890, 8, '2024-02-28', 25.75, 'PayPal'),
(8901, 9, '2024-02-27', 43.97, 'Credit Card'),
(9101, 10, '2024-02-26', 19.90, 'Credit Card');


INSERT INTO Inventory (inventory_id, product_id, quantity) VALUES
(1, 1, 100),
(2, 2, 50),
(3, 3, 200),
(4, 4, 150),
(5, 5, 30),
(6, 6, 40),
(7, 7, 100),
(8, 8, 500),
(9, 9, 20),
(10, 10, 80);


INSERT INTO Supply (supplier_id, product_id, Supply_Date, quantity, transaction_id) VALUES
(1, 1, '2024-03-06', 100, 1234),
(2, 2, '2024-03-05', 50, 5678),
(3, 3, '2024-03-04', 200, 9012),
(4, 4, '2024-03-03', 150, 2345),
(5, 5, '2024-03-02', 30, 3456),
(6, 6, '2024-03-01', 40, 4567),
(7, 7, '2024-02-29', 100, 6789),
(8, 8, '2024-02-28', 500, 7890),
(9, 9, '2024-02-27', 20, 8901),
(10, 10, '2024-02-26', 80, 9101);


INSERT INTO Cart (user_id, product_id, quantity) VALUES
(1, 1, 2),
(2, 3, 1),
(3, 5, 3),
(4, 7, 2),
(5, 9, 1),
(6, 2, 2),
(7, 4, 1),
(8, 6, 3),
(9, 8, 2),
(10, 10, 1);



SELECT p.product_id, p.name AS product_name, p.price, s.name AS supplier_name, s.email AS supplier_email
FROM Product p
JOIN Supplier s ON p.supplier_id = s.supplier_id;


SELECT SUM(t.amount) AS total_revenue
FROM Transaction t
JOIN Orders o ON t.Orders_id = o.Orders_id
WHERE o.Orders_status = 'Delivered';


UPDATE Orders
SET Orders_status = 'Cancelled'
WHERE Orders_id IN (
    SELECT * FROM (
        SELECT Orders_id 
        FROM Orders 
        WHERE Orders_date < '2024-03-01' AND Orders_status = 'Pending'
    ) AS subquery
);

SELECT DISTINCT u.user_id, u.first_name, u.last_name
FROM User u
JOIN Orders o ON u.user_id = o.user_id;

SELECT name AS product_name, stock_quantity
FROM Product
WHERE stock_quantity = 0;

SELECT p.name AS product_name, COUNT(r.review) AS num_reviews
FROM Product p
LEFT JOIN review r ON p.product_id = r.product_id
GROUP BY p.product_id;

SELECT p.name AS product_name, AVG(r.rating) AS avg_rating
FROM Product p
JOIN review r ON p.product_id = r.product_id
GROUP BY p.product_id
ORDER BY avg_rating DESC
LIMIT 5;

SELECT s.name AS supplier_name, SUM(p.price * i.quantity) AS total_sales
FROM Supplier s
JOIN Product p ON s.supplier_id = p.supplier_id
JOIN Inventory i ON p.product_id = i.product_id
GROUP BY s.supplier_id;

SELECT e.employee_id, e.first_name, e.last_name
FROM Employee e
JOIN Admin a ON e.employee_id = a.employee_id;

DELETE FROM Inventory
WHERE product_id IN (
    SELECT product_id
    FROM Product
    WHERE expiry_date < CURDATE()
);


