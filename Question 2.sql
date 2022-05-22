-- Question 2A
-- How many orders were shipped by Speedy Express in total?
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
--What is the last name of the employee with the most orders?
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
    AS OrderByEmployee
INNER JOIN
    Employees
ON OrderByEmployee.EmployeeID = Employees.EmployeeID
ORDER BY 
    OrderByEmployee.TotalOrders DESC
    LIMIT 1
--ANSWER: Peacock


--Question 2C
--What product was ordered the most by customers in Germany?

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
    OrderDetails.ProductID, Products.ProductName
ORDER BY 
    SUM(OrderDetails.Quantity) DESC
LIMIT 1
--ANSWER: Boston Crab Meat 