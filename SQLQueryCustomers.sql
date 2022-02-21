/* 1. List the firstnames and gender of customers where gender is defined properly (M or F) and first name is not an initial.*/

SELECT FirstName, Gender, COUNT(*) as NumCusts
FROM Customers 
WHERE Gender IN ('M','F') AND LEN(FirstName) > 2				
GROUP BY FirstName, Gender
ORDER BY FirstName, Gender;

/* Write the total count of customers that meet the criterion here. */

Select COUNT(*) as TotalCusts 
FROM Customers 
WHERE Gender IN ('M','F') AND LEN(FirstName) > 2;

/* 2. Provide information on Gender by State for the top 10 states.
The total number of customers defines top 10. Gender should include the unknown gender as well.*/

SELECT State,
SUM(CASE WHEN Gender = 'M' THEN 1 ELSE 0 END) as Male,
SUM(CASE WHEN Gender = 'F' THEN 1 ELSE 0 END) as Female,
SUM(CASE WHEN Gender = ' ' THEN 1 ELSE 0 END) as Unknown,
COUNT(DISTINCT c.CustomerId) as 'Total customers'
FROM Orders o INNER JOIN
	 Customers c 
	 ON o.CustomerId = c.CustomerId
WHERE State IN (SELECT TOP 10 State 
				FROM Orders 
				GROUP BY State 
				ORDER BY COUNT(DISTINCT CustomerId) desc)
GROUP BY State
ORDER BY 'Total customers' desc;


/* 3. Prove that there is a gender difference in customer purchase patterns. 
In other words, Do Male buy more than Female (in terms of numunits and total price). */

SELECT Gender, SUM(NumUnits) as TotalUnits, SUM(TotalPrice) as TotalPrice 
FROM Orders o LEFT OUTER JOIN
	 Customers c
	 ON o.CustomerId = c.CustomerId
WHERE Gender = 'M' or Gender = 'F'
GROUP BY Gender
ORDER BY Gender desc;

SELECT Gender, SUM(NumUnits) as TotalUnits, SUM(TotalPrice) as TotalPrice 
FROM Orders o INNER JOIN
	 Customers c
	 ON o.CustomerId = c.CustomerId
WHERE Gender <> ''
GROUP BY Gender
ORDER BY Gender desc;

/* 4. Write a query to create a yearly distribution by gender (include everything), distribution in terms of Total customers. */

SELECT YEAR(OrderDate) as 'Order Year', 
SUM(CASE WHEN Gender = 'M' THEN 1 ELSE 0 END) as Male,
SUM(CASE WHEN Gender = 'F' THEN 1 ELSE 0 END) as Female,
SUM(CASE WHEN Gender = '' THEN 1 ELSE 0 END) as Unknown,
COUNT(DISTINCT o.CustomerId) as 'Total customers'
FROM Orders o INNER JOIN
	 Customers c 
	 ON o.CustomerId = c.CustomerId
WHERE YEAR(OrderDate) <> ''
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate);

/* 5. Write a query to compare monthly sales based on Number of Orders for the year 2015. */

SELECT FORMAT(OrderDate, 'MMM') as Month, 
COUNT(OrderId) as 'Number of orders'
FROM Orders
WHERE YEAR(OrderDate) = '2015'
GROUP BY FORMAT(OrderDate, 'MMM'), MONTH(OrderDate)
ORDER BY MONTH(OrderDate);

SELECT DATENAME(month, OrderDate) as Month,
COUNT(OrderId) as 'Number of orders'
FROM Orders
WHERE YEAR(OrderDate) = '2015'
GROUP BY DATENAME(month, OrderDate), MONTH(OrderDate)
ORDER BY MONTH(OrderDate);