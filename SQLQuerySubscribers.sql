SELECT *
FROM Subscribers

-- 1. 
SELECT StopType,				
       COUNT(CASE WHEN RatePlan = 'Bottom' THEN SubscriberId END) as RP_Bottom,				
       COUNT(CASE WHEN RatePlan = 'Middle' THEN SubscriberId END) as RP_Middle,				
       COUNT(CASE WHEN RatePlan = 'Top' THEN SubscriberId END) as RP_Top
FROM Subscribers			
WHERE YEAR(StartDate) IN (2004, 2005, 2006)			
GROUP BY StopType

-- 2. 

SELECT 50 as tenure, COUNT(*) as popatrisk,					
       SUM(CASE WHEN Tenure = 50 AND StopType IS NOT NULL					
                THEN 1 ELSE 0 END) as succumbtorisk,					
       AVG(CASE WHEN Tenure = 50 AND StopType IS NOT NULL					
                THEN 1.0 ELSE 0 END) as h_50					
FROM Subscribers					
WHERE StartDate >= '2004-01-01' AND Tenure >= 50
-- 3.
SELECT 200 as tenure, COUNT(*) as popatrisk,					
       SUM(CASE WHEN Tenure = 200 AND StopType IS NOT NULL					
                THEN 1 ELSE 0 END) as succumbtorisk,					
       AVG(CASE WHEN Tenure = 200 AND StopType IS NOT NULL					
                THEN 1.0 ELSE 0 END) as h_200					
FROM Subscribers					
WHERE StartDate >= '2004-01-01' AND Tenure >= 200

-- 4.
SELECT Tenure,
	COUNT(CASE WHEN RatePlan = 'Bottom' THEN SubscriberId END) as RP_Bottom,				
    COUNT(CASE WHEN RatePlan = 'Middle' THEN SubscriberId END) as RP_Middle,				
    COUNT(CASE WHEN RatePlan = 'Top' THEN SubscriberId END) as RP_Top
FROM Subscribers
WHERE YEAR(StartDate) IN (2004, 2005, 2006)
GROUP BY Tenure
HAVING COUNT(SubscriberId) < 10000
ORDER BY Tenure

-- 5.
SELECT MonthlyFee, COUNT(*) AS Num_of_Subs
FROM Subscribers
WHERE YEAR(StartDate) IN (2004, 2005, 2006)
GROUP BY MonthlyFee
ORDER BY MonthlyFee

-- 6.
SELECT left(datename(month, StartDate), 3) as month,
COUNT(DISTINCT SubscriberId) as num_starts
FROM Subscribers
WHERE YEAR(StartDate) IN (2004, 2005, 2006)
GROUP BY datename(month, StartDate)
ORDER BY (CASE WHEN datename(month, StartDate) = 'January' THEN 1
               WHEN datename(month, StartDate) = 'February' THEN 2
               WHEN datename(month, StartDate) = 'March' THEN 3
               WHEN datename(month, StartDate) = 'April' THEN 4
               WHEN datename(month, StartDate) = 'May' THEN 5
               WHEN datename(month, StartDate) = 'June' THEN 6
               WHEN datename(month, StartDate) = 'July' THEN 7
			   WHEN datename(month, StartDate) = 'August' THEN 8
			   WHEN datename(month, StartDate) = 'September' THEN 9
			   WHEN datename(month, StartDate) = 'October' THEN 10
			   WHEN datename(month, StartDate) = 'November' THEN 11
			   WHEN datename(month, StartDate) = 'December' THEN 12
          END)
-- 7.
SELECT left(datename(month, StopDate), 3) as month,
COUNT(DISTINCT SubscriberId) as num_stops
FROM Subscribers
WHERE YEAR(StopDate) IN (2004, 2005, 2006)
GROUP BY datename(month, StopDate)
ORDER BY (CASE WHEN datename(month, StopDate) = 'January' THEN 1
               WHEN datename(month, StopDate) = 'February' THEN 2
               WHEN datename(month, StopDate) = 'March' THEN 3
               WHEN datename(month, StopDate) = 'April' THEN 4
               WHEN datename(month, StopDate) = 'May' THEN 5
               WHEN datename(month, StopDate) = 'June' THEN 6
               WHEN datename(month, StopDate) = 'July' THEN 7
			   WHEN datename(month, StopDate) = 'August' THEN 8
			   WHEN datename(month, StopDate) = 'September' THEN 9
			   WHEN datename(month, StopDate) = 'October' THEN 10
			   WHEN datename(month, StopDate) = 'November' THEN 11
			   WHEN datename(month, StopDate) = 'December' THEN 12
          END)
