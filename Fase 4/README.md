# Phase 4 — Database Design: Warehouse Inventory Management System

## 1. Entity Identification
Based on system requirements and use case specifications (authentication, stock intake, sales dispatch, and inventory alerts), seven core entities are established:
1. **Role:** Access profiles (Admin, Warehouse Clerk, Sales Representative).
2. **User:** Warehouse staff who authenticate and perform operations in the system.
3. **Category:** Classification for stored inventory items.
4. **Supplier:** External business vendors supplying stock.
5. **Product:** Physical goods stored in the warehouse subject to inventory tracking.
6. **Inventory_Movement:** Header transaction records for entries, sales dispatches, and inventory write-offs.
7. **Movement_Detail:** Line items per transaction including quantities and unit prices.

---

## 2. Attribute Definitions
* **Role:** `role_id`, `role_name`, `description`.
* **User:** `user_id`, `full_name`, `email`, `password_hash`, `role_id`, `is_active`, `created_at`.
* **Category:** `category_id`, `category_name`, `description`.
* **Supplier:** `supplier_id`, `tax_id`, `company_name`, `phone`, `email`, `address`.
* **Product:** `product_id`, `sku`, `product_name`, `description`, `purchase_price`, `selling_price`, `stock_quantity`, `minimum_stock`, `category_id`.
* **Inventory_Movement:** `movement_id`, `movement_type`, `movement_date`, `user_id`, `supplier_id`, `reference_number`, `notes`.
* **Movement_Detail:** `detail_id`, `movement_id`, `product_id`, `quantity`, `unit_price`.

---

## 3. Primary and Foreign Keys
* **roles:** PK (`role_id`).
* **users:** PK (`user_id`) | FK (`role_id` -> `roles.role_id`).
* **categories:** PK (`category_id`).
* **suppliers:** PK (`supplier_id`).
* **products:** PK (`product_id`) | FK (`category_id` -> `categories.category_id`).
* **inventory_movements:** PK (`movement_id`) | FK (`user_id` -> `users.user_id`), FK (`supplier_id` -> `suppliers.supplier_id`).
* **movement_details:** PK (`detail_id`) | FK (`movement_id` -> `inventory_movements.movement_id`), FK (`product_id` -> `products.product_id`).

---

## 4. Relationship Definitions
* **Role — User (1 : N):** A role can be assigned to multiple users; each user belongs to exactly one role.
* **Category — Product (1 : N):** A category classifies multiple products; each product belongs to one category.
* **User — Inventory_Movement (1 : N):** A user records multiple inventory transactions; each transaction is logged by one user.
* **Supplier — Inventory_Movement (1 : N optional):** A supplier provides multiple intake orders; sales or write-offs do not require a supplier.
* **Inventory_Movement — Product (M : N):** Decomposed into two `1 : N` relationships via the associative entity `Movement_Detail`:
  * `Inventory_Movement (1) -> Movement_Detail (N)`
  * `Product (1) -> Movement_Detail (N)`

---

## 5. Normalization Process (1NF to 3NF)
* **First Normal Form (1NF):**
  * All attributes contain atomic values.
  * No repeating groups exist (transaction item lists are isolated into `movement_details`).
  * Unique primary keys are assigned to each table.
* **Second Normal Form (2NF):**
  * Complies with 1NF.
  * All non-key attributes depend fully on the complete primary key (no partial dependencies on composite keys).
* **Third Normal Form (3NF):**
  * Complies with 2NF.
  * Eliminates transitive dependencies: non-key attributes depend exclusively on the primary key (e.g., supplier metadata is not duplicated in inventory movement headers).

---

## 6. Logical Relational Schema
* **ROLES** (<ins>role_id</ins>, role_name, description)
* **USERS** (<ins>user_id</ins>, full_name, email, password_hash, <dfn>role_id</dfn>, is_active, created_at)
* **CATEGORIES** (<ins>category_id</ins>, category_name, description)
* **SUPPLIERS** (<ins>supplier_id</ins>, tax_id, company_name, phone, email, address)
* **PRODUCTS** (<ins>product_id</ins>, sku, product_name, description, purchase_price, selling_price, stock_quantity, minimum_stock, <dfn>category_id</dfn>)
* **INVENTORY_MOVEMENTS** (<ins>movement_id</ins>, movement_type, movement_date, <dfn>user_id</dfn>, <dfn>supplier_id</dfn>, reference_number, notes)
* **MOVEMENT_DETAILS** (<ins>detail_id</ins>, <dfn>movement_id</dfn>, <dfn>product_id</dfn>, quantity, unit_price)