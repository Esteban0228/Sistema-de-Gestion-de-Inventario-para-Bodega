
DROP DATABASE IF EXISTS warehouse_inventory_db;
CREATE DATABASE warehouse_inventory_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE warehouse_inventory_db;

CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
) ENGINE=InnoDB;


CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_users_roles 
        FOREIGN KEY (role_id) REFERENCES roles(role_id) 
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
) ENGINE=InnoDB;


CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    tax_id VARCHAR(30) NOT NULL UNIQUE,
    company_name VARCHAR(150) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    email VARCHAR(100),
    address VARCHAR(200)
) ENGINE=InnoDB;


CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(50) NOT NULL UNIQUE,
    product_name VARCHAR(150) NOT NULL,
    description TEXT,
    purchase_price DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    selling_price DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    stock_quantity INT NOT NULL DEFAULT 0,
    minimum_stock INT NOT NULL DEFAULT 5,
    category_id INT NOT NULL,
    CONSTRAINT chk_positive_prices CHECK (purchase_price >= 0 AND selling_price >= 0),
    CONSTRAINT chk_positive_stock CHECK (stock_quantity >= 0 AND minimum_stock >= 0),
    CONSTRAINT fk_products_categories 
        FOREIGN KEY (category_id) REFERENCES categories(category_id) 
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


CREATE TABLE inventory_movements (
    movement_id INT AUTO_INCREMENT PRIMARY KEY,
    movement_type ENUM('INBOUND_PURCHASE', 'OUTBOUND_SALE', 'INVENTORY_ADJUSTMENT') NOT NULL,
    movement_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL,
    supplier_id INT NULL,
    reference_number VARCHAR(50),
    notes VARCHAR(255),
    CONSTRAINT fk_movements_users 
        FOREIGN KEY (user_id) REFERENCES users(user_id) 
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_movements_suppliers 
        FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) 
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;


CREATE TABLE movement_details (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    movement_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    CONSTRAINT chk_valid_quantity CHECK (quantity > 0),
    CONSTRAINT chk_valid_unit_price CHECK (unit_price >= 0),
    CONSTRAINT fk_details_movements 
        FOREIGN KEY (movement_id) REFERENCES inventory_movements(movement_id) 
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_details_products 
        FOREIGN KEY (product_id) REFERENCES products(product_id) 
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;


CREATE INDEX idx_products_sku ON products(sku);
CREATE INDEX idx_movements_date ON inventory_movements(movement_date);



INSERT INTO roles (role_name, description) VALUES
('ADMINISTRATOR', 'Full system configuration, user, and inventory management privileges'),
('WAREHOUSE_CLERK', 'Manages physical inbound receiving and inventory dispatches'),
('SALES_REP', 'Checks current availability and records sales dispatch operations');

-- Users
INSERT INTO users (full_name, email, password_hash, role_id, is_active) VALUES
('Cristian Bastidas', 'admin@warehouse.com', '$2a$12$e8y10z8fK9x1qO3vXyz0123456789abcdef', 1, TRUE),
('Carlos Mendoza', 'clerk@warehouse.com', '$2a$12$9q10x3vL0z8fK7yXyz0123456789abcdef', 2, TRUE),
('Laura Gomez', 'sales@warehouse.com', '$2a$12$1a2b3c4d5e6f7g8hXyz0123456789abcdef', 3, TRUE);

-- Categories
INSERT INTO categories (category_name, description) VALUES
('Hand Tools', 'Hammers, screwdrivers, wrenches, and pliers'),
('Fasteners', 'Industrial screws, bolts, nuts, and anchors'),
('Safety Equipment', 'Gloves, protective goggles, helmets, and harnesses');

-- Suppliers
INSERT INTO suppliers (tax_id, company_name, phone, email, address) VALUES
('900123456-1', 'Industrial Supply Co.', '+57 3101234567', 'sales@industrialsupply.com', 'Industrial Park Ave, Suite 101'),
('890987654-2', 'Andina Distribution Ltd.', '+57 3157891234', 'contact@andinadist.com', '5th Avenue # 12-40');

-- Products
INSERT INTO products (sku, product_name, description, purchase_price, selling_price, stock_quantity, minimum_stock, category_id) VALUES
('HT-HAM-01', '16oz Claw Hammer', 'Ergonomic fiberglass handle', 18000.00, 26000.00, 45, 10, 1),
('FS-SCW-02', 'Drywall Screws 6x1 Box (1000pcs)', 'Black phosphate bugle head', 22000.00, 31000.00, 12, 5, 2),
('SE-GLV-03', 'Nitrile Work Gloves Size L', 'Abrasion and oil resistant', 7500.00, 12500.00, 4, 15, 3); -- Low stock alert triggered


INSERT INTO inventory_movements (movement_type, user_id, supplier_id, reference_number, notes) VALUES
('INBOUND_PURCHASE', 2, 1, 'PO-2026-001', 'Initial restock batch for manual tools');

INSERT INTO movement_details (movement_id, product_id, quantity, unit_price) VALUES
(1, 1, 20, 18000.00),
(1, 2, 10, 22000.00);

INSERT INTO inventory_movements (movement_type, user_id, supplier_id, reference_number, notes) VALUES
('OUTBOUND_SALE', 3, NULL, 'INV-2026-089', 'Retail counter customer dispatch');

INSERT INTO movement_details (movement_id, product_id, quantity, unit_price) VALUES
(2, 1, 3, 26000.00);