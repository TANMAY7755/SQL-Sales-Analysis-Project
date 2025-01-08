Beginner Level
Basic SELECT Queries:


Fetch all sales records.
SELECT * FROM sales;
SELECT * FROM Customers;
SELECT * FROM Products;

Retrieve all customers from a specific region.
SELECT * FROM Customers WHERE region='West'; 

Display all products under a specific category (e.g., Electronics).
SELECT * FROM Products WHERE category = 'Electronics';


WHERE Clause:
Find sales made after a specific date (e.g., 2023-01-01).
SELECT * FROM Sales WHERE saledate > '2023-01-01';

List customers with a specific customer type (e.g., Business).
SELECT * FROM Customers WHERE customertype =  'Business';


Sorting & Filtering:
Sort sales data by SaleDate in descending order.
SELECT * FROM Sales ORDER BY saledate DESC;

Filter products with a price greater than $500 and sort it in descending order.
SELECT * FROM Products WHERE price > 500 ORDER BY price DESC;

Aggregations:
Count the total number of sales.
SELECT COUNT(*) FROM Sales;

Calculate the total price for each category
SELECT category, SUM(price) AS TOTAL_PRICE FROM Products GROUP BY category;

Intermediate Level
Joins:

Join Sales with Products to get product names for each sale.
SELECT * FROM Products P  RIGHT JOIN sales S ON P.productid = S.productid;

Join Sales with Customers to retrieve customer names for each sale.
SELECT * FROM Customers C RIGHT JOIN Sales S ON  C.customerid = S.customerid;


Combine all three tables to get detailed sales reports (CustomerName, ProductName, Quantity).
SELECT customername, productname, quantity 
FROM sales S 
JOIN Customers C 
ON S.customerid = C.customerid  
JOIN products P 
ON S.productid = P.productid;

Add new column Total Revenue and update to the sales table  
-for total revenue we need to multiply quantity from sales and price from product
AlTER TABLE Sales ADD COLUMN Totalrevenue NUMERIC;

UPDATE Sales S
SET Totalrevenue = S.quantity*P.price
FROM Products P
WHERE S.ProductID = P.ProductID;


Group By & Aggregations:
Calculate total revenue generated per product.
SELECT P.productname, SUM(S.totalrevenue)
FROM Sales S 
JOIN Products P
ON S.productid = P.productid
GROUP BY P.productname;

Find the total number of products sold per customer.
SELECT C.customername, SUM(S.quantity) AS totalQuantity 
FROM sales S
JOIN Customers C
ON S.Customerid = C.Customerid
JOIN Products P 
ON S.productid = P.productid
GROUP BY C.customername;


Calculate the average sale amount by region.
SELECT AVG(S.totalrevenue) AS Averagesale, C.region
FROM sales S
JOIN Customers C
ON S.customerid = C.customerid
GROUP BY C.region;

Subqueries:

Find the top 3 most expensive products without subquery
SELECT productname,Price 
FROM products 
ORDER BY Price DESC 
LIMIT 3;

Retrieve customers who have made purchases totaling more than $10,000.
SELECT C.customername, SUM(S.totalrevenue) AS totalrevenue
FROM sales S 
JOIN Customers C
ON S.customerid = C.customerid
WHERE C.customerid IN (SELECT C.customerid FROM sales S JOIN Customers C
ON S.customerid = C.customerid
GROUP BY C.customerid
HAVING SUM(S.totalrevenue) > 10000 )
GROUP BY C.customername;


CTEs (Common Table Expressions):
Create a CTE to calculate total sales per customer and filter customers with sales greater than $5,000.
WITH CTE AS (
SELECT C.customername, SUM(S.totalrevenue) AS totalRevenue
FROM Sales S 
JOIN Customers C 
ON S.customerid = C.customerid
GROUP BY C.customername
HAVING SUM(S.totalRevenue) > 5000)

SELECT customername, totalRevenue 
FROM CTE 
ORDER BY totalRevenue;
