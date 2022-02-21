
/* order date and bill date */

SELECT DATEDIFF(day, o.OrderDate, ol.billDate) as days, COUNT(*) as
numol
FROM Orders o JOIN
OrderLines ol
ON o.OrderId = ol.OrderId
GROUP BY DATEDIFF(day, o.OrderDate, ol.billDate)
ORDER BY days

/* weekly distribution for the year 2011 for number of orders, number of customers (Distinct) and TotalPrice */

SELECT DATENAME(week, OrderDate) as WeekNumber, COUNT(DISTINCT OrderID) as TotalOrders, COUNT(DISTINCT CustomerID) as TotalCustomers, SUM(totalprice) as TotalSales FROM Orders
WHERE YEAR(OrderDate) = '2011' 
GROUP BY DATENAME(week, orderdate), DATEPART(week, orderdate)
ORDER BY DATEPART(week, orderdate)

/* daily distribution for the first six months for the year 2012 for number of orders, number of customers (Distinct) and TotalPrice */

SELECT DATEPART(DAYOFYEAR, OrderDate) as DayNumber, COUNT(DISTINCT OrderID) as TotalOrders, COUNT(DISTINCT CustomerID) as TotalCustomers, SUM(totalprice) as TotalSales FROM Orders
WHERE OrderDate BETWEEN '2012-01-01' AND '2012-06-30'
GROUP BY DATEPART(DAYOFYEAR, OrderDate)
ORDER BY DATEPART(DAYOFYEAR, OrderDate)

/* quarterly distribution of totalprice */

SELECT DATENAME(quarter, BillDate) as billdow, sum(totalprice) as TotalSales FROM OrderLines
group by DATENAME(quarter, BillDate), datepart(quarter, billdate)
order by DATepart(quarter, BillDate)
