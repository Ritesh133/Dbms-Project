Team Members:
● Asa Singh - 2022113
● Abhishek Beniwal - 2022022
● Ritesh Kumar Parihar - 2022407
 
Introduction
This document outlines the structure and relationships of the database designed for managing products, users, orders, reviews, transactions, employees, and suppliers. It serves as a guide for developers, administrators, and users to understand the database schema and its components.

Table Descriptions
1. Product Table
Stores information about products available in the system.

Prod_ID: Primary Key
name: Name of the product
Description: Description of the product
Price: Price of the product
Manufacturer: Manufacturer of the product
Expiry Date: Expiry date of the product (if applicable)
Stock Quantity: Quantity of the product in stock
category: Category of the product
supplier_id: Foreign Key referencing Supplier Table
2. User Table
Stores user information.

User_ID: Primary Key
first_Name: First name of the user
last_name: Last name of the user
Email: Unique email of the user
Password: Password for user authentication
phone number: Phone number of the user
recovery email: Recovery email for account recovery
3. Orders Table
Stores order information.

Order_ID: Primary Key
User_ID: Foreign Key referencing User Table
Order Status: Status of the order (e.g., pending, shipped, delivered)
Order Date: Date the order was placed
prescription_verified: Boolean indicating if the prescription was verified (if applicable)
return_request: Boolean indicating if a return was requested
return_status: Status of the return
transaction_id: Transaction ID associated with the order
return_transaction_id: Transaction ID associated with the return (if applicable)
delivery_id: Delivery ID associated with the order
4. Review Table
Stores reviews for products.

User_ID: Foreign Key referencing User Table
Prod_ID: Foreign Key referencing Product Table
Review: Text of the review
Rating: Rating given by the user
5. Address Table
Stores address information for users.

User_id: Foreign Key referencing User Table
Street: Street address
City: City
State: State
Country: Country
pincode: Postal code
6. Transaction Table
Stores transaction details.

Transaction_ID: Primary Key
Order_ID: Foreign Key referencing Orders Table
Transaction Date: Date of the transaction
Amount: Amount of the transaction
payment_method: Payment method used
7. Employee Table
Stores employee information.

Employee_ID: Primary Key
First_name: First name of the employee
Last_name: Last name of the employee
Role: Role of the employee
Phone_number: Phone number of the employee
Email: Email of the employee
Date_of_Birth: Date of birth of the employee
Hire_Date: Date the employee was hired
Address: Address of the employee
8. Admin Table
Stores admin-specific information.

Employee_ID: Foreign Key referencing Employee Table
Permissions: Permissions granted to the admin
9. Delivery Partner Table
Stores delivery partner-specific information.

Employee_ID: Foreign Key referencing Employee Table
Permissions: Permissions granted to the delivery partner
10. Deliveries Table
Stores delivery information.

employee_id: Foreign Key referencing Employee Table
delivery_id: Primary Key
delivery_status: Status of the delivery
order_id: Order ID associated with the delivery
11. Inventory Table
Stores inventory details.

Inventory_ID: Primary Key
Product_ID: Foreign Key referencing Product Table
Quantity: Quantity in inventory
12. Supplier Table
Stores supplier information.

Supplier_ID: Primary Key
Name: Name of the supplier
email: Email of the supplier
phone_number: Phone number of the supplier
13. Supply Table
Stores supply details.

Supplier_ID: Foreign Key referencing Supplier Table
Product_ID: Foreign Key referencing Product Table
Supply_Date: Date of supply
Quantity: Quantity supplied
transaction_id: Transaction ID associated with the supply
14. Cart Table
Stores user cart details.

user_id: Foreign Key referencing User Table
product_id: Product ID
quantity: Quantity of the product in the cart
Relationships
Each Order is associated with a User and has multiple Transactions.
Products can have multiple Reviews from different Users.
Users can have multiple Addresses.
Orders are delivered by Delivery Partners and tracked in the Deliveries table.
Products are supplied by Suppliers and managed in the Inventory table.
Employees can be either Admins or Delivery Partners with specific permissions.

