create database guitars

use [guitars]

-- Create Categories Table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY IDENTITY,
    name NVARCHAR(50)
);


-- Create Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY IDENTITY,
    name NVARCHAR(100),
    description NVARCHAR(255),
    price DECIMAL(10, 2),
    category_id INT FOREIGN KEY REFERENCES Categories(category_id),
    stock_quantity INT,
    image_url NVARCHAR(255)
);


-- Create Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY,
    username NVARCHAR(50),
    password NVARCHAR(255), -- hashed
    email NVARCHAR(100),
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    address NVARCHAR(255),
    phone_number NVARCHAR(15)
);

-- Create Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY,
    user_id INT FOREIGN KEY REFERENCES Users(user_id),
    status NVARCHAR(50),
    total_price DECIMAL(10, 2),
    order_date DATETIME
);

-- Create Order Details Table
CREATE TABLE Order_Details (
    order_details_id INT PRIMARY KEY IDENTITY,
    order_id INT FOREIGN KEY REFERENCES Orders(order_id),
    product_id INT FOREIGN KEY REFERENCES Products(product_id),
    quantity INT,
    price DECIMAL(10, 2)
);

-- Create Cart Table
CREATE TABLE Cart (
    cart_id INT PRIMARY KEY IDENTITY,
    user_id INT FOREIGN KEY REFERENCES Users(user_id),
    product_id INT FOREIGN KEY REFERENCES Products(product_id),
    quantity INT
);

-- Create Shipping Table
CREATE TABLE Shipping (
    shipping_id INT PRIMARY KEY IDENTITY,
    order_id INT FOREIGN KEY REFERENCES Orders(order_id),
    shipping_method NVARCHAR(50),
    tracking_number NVARCHAR(50),
    shipping_date DATETIME
);

-- Create Guitars Category
INSERT INTO Categories (name)
VALUES ('Guitars');



-- Get the ID of the Guitars Category
DECLARE @guitars_category_id INT;
SELECT @guitars_category_id = category_id FROM Categories WHERE name = 'Guitars';

-- Insert Sample Guitar Products with Image URLs
INSERT INTO Products (name, description, price, category_id, stock_quantity, image_url)
VALUES 
    ('Fender Stratocaster', 'Classic electric guitar with versatile sound.', 699.99, @guitars_category_id, 10, '/images/fender_image.jpg'),
    ('Gibson Les Paul', 'Iconic guitar known for its rich tones.', 999.99, @guitars_category_id, 5, '/images/gibson_image.jpg'),
    ('Yamaha FG800', 'Affordable and high-quality acoustic guitar.', 199.99, @guitars_category_id, 15, '/images/yamaha_image.jpg'),
    ('Ibanez RG Series', 'Electric guitar designed for heavy metal music.', 499.99, @guitars_category_id, 8, '/images/ibanez_image.jpg');
