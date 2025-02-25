-- Opprett database
CREATE DATABASE IF NOT EXISTS prodproduct_dbucts;
USE product_db;

-- Opprett tabell for produkter
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

-- Sett inn testdata
INSERT INTO products (name, brand, price, stock) VALUES
('Laptop', 'Dell', 12999.00, 50),
('Smartphone', 'Apple', 9999.00, 30),
('Headphones', 'Sony', 1499.00, 100),
('Monitor', 'LG', 2999.00, 40),
('Keyboard', 'Logitech', 799.00, 75),
('Mouse', 'Razer', 599.00, 60),
('Tablet', 'Samsung', 6999.00, 25),
('Smartwatch', 'Garmin', 2499.00, 40),
('Gaming Chair', 'Secretlab', 3999.00, 20),
('Router', 'TP-Link', 899.00, 50);

-- Opprett databasebruker for API
CREATE USER IF NOT EXISTS 'product-api'@'%' IDENTIFIED BY 'securepass';

-- Gi brukeren nødvendige rettigheter
GRANT ALL PRIVILEGES ON product.* TO 'product-api'@'%';

-- Aktiver endringer
FLUSH PRIVILEGES;