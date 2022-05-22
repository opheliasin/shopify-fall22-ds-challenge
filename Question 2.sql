-- Question 2A
-- How many orders were shipped by Speedy Express in total?
-- EXPLANATION: First, I selected the two columns of interest, which are the Shipper's name and the total orders for each shipper.
-- The total order for each shipper is aggregated from the Orders table using the Count(*) function. I then did an inner join between the newly created
-- table OrderCount and Shippers on the ShipperID. Finally, I used WHERE to only output when the shipper is 'Speedy Express'.

SELECT Shippers.ShipperName, OrderCount.TotalOrders
FROM (
    SELECT
        COUNT(*) TotalOrders, 
        ShipperID
    FROM 
        Orders 
    GROUP BY 
        ShipperID
) AS OrderCount
INNER JOIN
    Shippers
ON OrderCount.ShipperID = Shippers.ShipperID  
WHERE Shippers.ShipperName = 'Speedy Express'
--ANSWER: 54


-- Question 2B
-- What is the last name of the employee with the most orders?
-- EXPLANATION: First, I selected the column LastName from the Employees table. I then created a new table called OrdersByEmployee which 
-- shows the number of orders for each employee. Next, the new table is joined with the Employees table on the Employee ID. Finally, I ordered the table
-- in descending order and limited the output to return only the last name of the employee with the most orders.

SELECT 
    Employees.LastName
FROM 
    (SELECT 
        COUNT(*) TotalOrders,
        EmployeeID
    FROM 
        Orders 
    GROUP BY 
        EmployeeID)
    AS OrdersByEmployee
INNER JOIN
    Employees
ON OrdersByEmployee.EmployeeID = Employees.EmployeeID
ORDER BY 
    OrdersByEmployee.TotalOrders DESC
    LIMIT 1
--ANSWER: Peacock


-- Question 2C
-- What product was ordered the most by customers in Germany?
-- EXPLANATION: I first selected the Product's name from the Product table. Then, I joined Order Details and Products on the ProductID field. The WHERE 
-- statement consists of two nested queries, in which only orders made by customers within Germany in the Orders table will be selected in the 
-- OrderDetails table. Finally, the results are grouped by ProductName and ordered by the total number of orders made per product.

SELECT 
    Products.ProductName 
FROM 
    OrderDetails
INNER JOIN
    Products
    ON OrderDetails.ProductID = Products.ProductID
WHERE OrderDetails.OrderID IN 
    (SELECT
        OrderID 
    FROM 
        Orders
    WHERE Orders.CustomerID IN 
        (SELECT 
            CustomerID
        FROM 
            Customers
        WHERE  
            COUNTRY = 'Germany')    
    )
GROUP BY 
    Products.ProductName 
ORDER BY 
    SUM(OrderDetails.Quantity) DESC
LIMIT 1
--ANSWER: Boston Crab Meat 
