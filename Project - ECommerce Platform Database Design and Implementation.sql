-- 1. Database schema
-- query to create the DB
CREATE DATABASE ECommercePlatform;
-- query to use the DB
USE ECommercePlatform;

-- queries to create tables and define the data types, primary keys and foreign keys
CREATE TABLE Users (
user_id INT PRIMARY KEY,
user_name VARCHAR(50) NOT NULL,
user_email VARCHAR(100) NOT NULL UNIQUE,
user_password VARCHAR(50) NOT NULL,
user_role VARCHAR(50)
);

CREATE TABLE Products (
product_id INT PRIMARY KEY,
product_name VARCHAR(50) UNIQUE,
category VARCHAR(20),
price DECIMAL(10,2),
stock_quantity INT
);

CREATE TABLE Orders (
order_id INT PRIMARY KEY,
user_id INT,
order_date DATETIME,
total_amount DECIMAL(19,2),
order_status VARCHAR(50),
FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE OrderDetails (
order_detail_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
unit_price DECIMAL(10,2),
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
payment_id INT PRIMARY KEY,
order_id INT,
payment_date DATETIME,
payment_method VARCHAR(20),
amount DECIMAL(19,2),
FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Reviews (
review_id INT PRIMARY KEY,
product_id INT,
user_id INT,
review_text VARCHAR(150),
rating DECIMAL(2,1),
review_date DATETIME,
FOREIGN KEY (product_id) REFERENCES Products(product_id),
FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 2. Insert sample data
-- query to insert values in tables
INSERT INTO Users (user_id, user_name, user_email, user_password, user_role) VALUES
(1,'Alan','alan@example.com','alan123','client'),
(2,'Adam','adam@example.com','adam123','administrator'),
(3,'Omar','omar@example.com','omar123','client');

INSERT INTO Products (product_id, product_name, category, price, stock_quantity) VALUES
(1,'Samsung Smart TV','Smart TVs',13391.25,10),
(2,'Samsung Galaxy S25','Smart phones',27999.00,12),
(3,'Honor Magic7','Smart phones',9999.00,15);

INSERT INTO Orders (order_id, user_id, order_date, total_amount, order_status) VALUES
(1,1,'2025-06-11',13391.25,'Processing'),
(2,1,'2025-06-10',23390.25,'Delivered');

INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, unit_price) VALUES
(1,1,1,1,13391.25),
(2,2,1,1,13391.25),
(3,2,3,1,9999.00);

INSERT INTO Payments (payment_id, order_id, payment_date, payment_method, amount) VALUES
(1,1,'2025-06-11','gift card',13391.25),
(2,2,'2025-06-09','credit card',23390.25);

INSERT INTO Reviews (review_id, product_id, user_id, review_text, rating, review_date) VALUES
(1,1,1,'It is an excellent TV, good graphics',5,'2025-06-11'),
(2,3,1,'It is an great phone with many functionalities but I disliked the color',4.5,'2025-06-11');

-- 3. Queries
-- query to retrieve the list of all products in a specific category.
SELECT * FROM Products WHERE category = 'Smart phones';

-- query to retrieve the details of a specific user by providing their user_id.
SELECT * FROM Users WHERE user_id = 1;

-- query to retrieve the order history for a particular user.
SELECT order_date, total_amount, order_status FROM Orders WHERE user_id = 1;

-- query to Retrieve the products in an order along with their quantities and prices.
SELECT Products.product_name, OrderDetails.quantity, OrderDetails.unit_price 
FROM OrderDetails 
INNER JOIN Products ON OrderDetails.product_id = Products.product_id
WHERE order_id = 2;

-- query to retrieve the average rating of a product.
SELECT Products.product_id, AVG(Reviews.rating) AS average_rating
FROM Reviews
INNER JOIN Products ON Reviews.product_id = Products.product_id
WHERE Reviews.product_id = 1;

-- query to retrieve the total revenue for a given month.
SELECT SUM(amount) AS total_revenue
FROM Payments
WHERE payment_date >= '2025-06-01' AND payment_date < '2025-07-01';
-- WHERE MONTH(payment_date) = 6 AND YEAR(payment_date) = 2025;

-- 4. Data modification
-- query to add a new product to the inventory.
INSERT INTO Products (product_id, product_name, category, price, stock_quantity) VALUES
(4,'Huawei Smartwatch GT 5 Pro','Smart watches',7999.35,12);

-- queries to place a new order for a user.
-- first add the order
INSERT INTO Orders (order_id, user_id, order_date, total_amount, order_status) VALUES
(3,3,'2025-06-11',35998.35,'Delivered');

-- second add the order details
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, unit_price) VALUES
(4,3,2,1,27999.00),
(5,3,4,1,7999.35);

-- third add the payment
INSERT INTO Payments (payment_id, order_id, payment_date, payment_method, amount) VALUES
(3,3,'2025-06-10','credit card',35998.35);

-- finally add the reviews
INSERT INTO Reviews (review_id, product_id, user_id, review_text, rating, review_date) VALUES
(3,2,3,'It is an great phone and really useful',5,'2025-06-11'),
(4,4,3,'It is an great smart watch and so comfortable',5,'2025-06-11');

-- query to update the stock quantity of a product.
UPDATE Products SET stock_quantity = 11
WHERE product_id = 4;

-- query to remove a user's review
DELETE FROM Reviews WHERE review_id = 4;

-- 5. Complex queries
-- query to Identify the top-selling products
SELECT p.product_name, COUNT(od.product_id) AS total_sold
FROM OrderDetails od
INNER JOIN Products p ON od.product_id = p.product_id
GROUP BY od.product_id
ORDER BY total_sold DESC
LIMIT 10;

-- query to find users who have placed orders exceeding a certain amount
SELECT u.user_name, o.total_amount
FROM Users u
INNER JOIN Orders o ON u.user_id = o.user_id
WHERE o.total_amount > 20000;

-- query to calculate the overall average rating for each product category
SELECT p.category, AVG(r.rating) AS average_rating
FROM Reviews r
INNER JOIN Products p ON r.product_id = p.product_id
GROUP BY p.category;

-- store procedure to update automatically the order status based on order processing
DELIMITER //
CREATE PROCEDURE UpdateOrderStatus
(IN processed_order_id INT)
BEGIN
	DECLARE current_order_status VARCHAR(20);

    SELECT order_status INTO current_order_status
    FROM Orders
    WHERE order_id = processed_order_id;

    IF current_order_status = 'Pending' THEN
        UPDATE Orders
        SET order_status = 'Processing'
        WHERE order_id = processed_order_id;
    ELSEIF current_order_status = 'Processing' THEN
        UPDATE Orders
        SET order_status = 'Shipped'
        WHERE order_id = processed_order_id;
	ELSEIF current_order_status = 'Shipped' THEN
        UPDATE Orders
        SET order_status = 'Delivered'
        WHERE order_id = processed_order_id;
    END IF;
END //
DELIMITER ;

-- call the store procedure
CALL UpdateOrderStatus(1);

-- store procedure to generate a report on the most active users, the users that have done most orders
DELIMITER //
CREATE PROCEDURE MostActiveUsers()
BEGIN
    SELECT u.user_name, COUNT(o.user_id) AS total_orders
    FROM Orders o
    INNER JOIN Users u ON o.user_id = u.user_id
    GROUP BY o.user_id
    ORDER BY total_orders DESC
    LIMIT 10;
END //
DELIMITER ;

CALL MostActiveUsers();