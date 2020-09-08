--Question1
SELECT COUNT(*) AS NumOrders
FROM Orders o
INNER JOIN Shippers s
	ON o.ShipperID = s.ShipperId
WHERE s.ShipperName = 'Speedy Express'

--Question2
SELECT e.LastName
FROM Employees e
INNER JOIN Orders o
	ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.LastName
HAVING COUNT(*) = (	SELECT MAX(numberOrders)
					FROM (	SELECT EmployeeID, COUNT(OrderID) AS numberOrders
							FROM Orders
							GROUP BY EmployeeID) maxOrders)

--Question3
SELECT p.ProductName
FROM Products p
INNER JOIN (
            SELECT ProductID, MAX(Quantity)
            FROM (
                  SELECT ProductID, SUM(Quantity) as Quantity
                  FROM Orders o
                  INNER JOIN (--Get German Customers
                    SELECT CustomerID
                    FROM Customers
                    WHERE Country = 'Germany') germanCustomer 
                  ON o.CustomerID = germanCustomer.CustomerID
                  INNER JOIN OrderDetails od
                  ON od.OrderID = o.OrderID
                  GROUP BY ProductID )
                  ) mP
ON mP.ProductID = p.ProductID

