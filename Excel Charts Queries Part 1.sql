--The number of orders by payment type

SELECT PaymentType, COUNT(*) as cnt			
FROM Orders o			
GROUP BY PaymentType			
ORDER BY cnt			

--The number of orders grouped by size and the total revenue

SELECT PaymentType,
       SUM(CASE WHEN 0 <= TotalPrice AND TotalPrice < 10
                THEN 1 ELSE 0 END) as cnt_0_10,
       SUM(CASE WHEN 10 <= TotalPrice AND TotalPrice < 100
                THEN 1 ELSE 0 END) as cnt_10_100,
       SUM(CASE WHEN 100 <= TotalPrice AND TotalPrice < 1000
                THEN 1 ELSE 0 END) as cnt_100_1000,
       SUM(CASE WHEN TotalPrice >= 1000 THEN 1 ELSE 0 END) as cnt_1000,
       COUNT(*) as cnt, SUM(TotalPrice) as revenue
FROM Orders
GROUP BY PaymentType
ORDER BY PaymentType


--how the number of purchases vary by month for different payment types
SELECT PaymentType,							
       SUM(CASE WHEN MONTH(OrderDate) = 1 THEN 1 ELSE 0 END) as Jan,							
       SUM(CASE WHEN MONTH(OrderDate) = 2 THEN 1 ELSE 0 END) as Feb,							
       SUM(CASE WHEN MONTH(OrderDate) = 3 THEN 1 ELSE 0 END) as Mar,							
       SUM(CASE WHEN MONTH(OrderDate) = 4 THEN 1 ELSE 0 END) as Apr,							
       SUM(CASE WHEN MONTH(OrderDate) = 5 THEN 1 ELSE 0 END) as May,							
       SUM(CASE WHEN MONTH(OrderDate) = 6 THEN 1 ELSE 0 END) as Jun,							
       SUM(CASE WHEN MONTH(OrderDate) = 7 THEN 1 ELSE 0 END) as Jul,							
       SUM(CASE WHEN MONTH(OrderDate) = 8 THEN 1 ELSE 0 END) as Aug,							
       SUM(CASE WHEN MONTH(OrderDate) = 9 THEN 1 ELSE 0 END) as Sep,							
       SUM(CASE WHEN MONTH(OrderDate) = 10 THEN 1 ELSE 0 END) as Oct,							
       SUM(CASE WHEN MONTH(OrderDate) = 11 THEN 1 ELSE 0 END) as Nov,							
       SUM(CASE WHEN MONTH(OrderDate) = 12 THEN 1 ELSE 0 END) as Dec							
FROM  Orders o							
WHERE YEAR(OrderDate) = 2015							
GROUP BY PaymentType							
ORDER BY PaymentType							


--the average price vary by month for different payment types

SELECT PaymentType,							
       AVG(CASE WHEN MONTH(OrderDate) = 1 THEN TotalPrice END) as Jan,							
       AVG(CASE WHEN MONTH(OrderDate) = 2 THEN TotalPrice END) as Feb,							
       AVG(CASE WHEN MONTH(OrderDate) = 3 THEN TotalPrice END) as Mar,							
       AVG(CASE WHEN MONTH(OrderDate) = 4 THEN TotalPrice END) as Apr,							
       AVG(CASE WHEN MONTH(OrderDate) = 5 THEN TotalPrice END) as May,							
       AVG(CASE WHEN MONTH(OrderDate) = 6 THEN TotalPrice END) as Jun,							
       AVG(CASE WHEN MONTH(OrderDate) = 7 THEN TotalPrice END) as Jul,							
       AVG(CASE WHEN MONTH(OrderDate) = 8 THEN TotalPrice END) as Aug,							
       AVG(CASE WHEN MONTH(OrderDate) = 9 THEN TotalPrice END) as Sep,							
       AVG(CASE WHEN MONTH(OrderDate) = 10 THEN TotalPrice END) as Oct,							
       AVG(CASE WHEN MONTH(OrderDate) = 11 THEN TotalPrice END) as Nov,							
       AVG(CASE WHEN MONTH(OrderDate) = 12 THEN TotalPrice END) as Dec							
FROM  Orders o							
WHERE YEAR(OrderDate) = 2015							
GROUP BY PaymentType							
ORDER BY PaymentType							

/* What is the distribution of orders by state and how is it related to the State's population */

SELECT State, SUM(numorders) as numorders, SUM(pop) as pop						
FROM ((SELECT o.State, COUNT(*) as numorders, 0 as pop						
       FROM Orders o						
       GROUP BY o.state						
      )						
      UNION ALL						
      (SELECT zc.stab, 0 as numorders, SUM(totpop) as pop						
       FROM ZipCensus zc						
       GROUP BY zc.stab						
      )						
     ) summary						
GROUP BY State						
ORDER BY numorders DESC			


/* What is the distribution of orders among statesthat have 100 or more orders */

SELECT (CASE WHEN cnt >= 100 THEN State ELSE 'OTHER' END) as state,		
        SUM(cnt) as cnt		
FROM (SELECT o.State, COUNT(*) as cnt		
      FROM Orders o		
      GROUP BY o.State		
     ) os		
GROUP BY (CASE WHEN cnt >= 100 THEN state ELSE 'OTHER' END)		
ORDER BY cnt DESC	

--What is the distribution of the number of orders in the 20 states that have the largest number of orders?

SELECT TOP 20 o.State, COUNT(*) as numorders 		
FROM Orders o		
GROUP BY o.State		
ORDER BY COUNT(*) DESC		

