/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [SubscriberId]
      ,[RatePlan]
      ,[MonthlyFee]
      ,[Market]
      ,[Channel]
      ,[StartDate]
      ,[StopDate]
      ,[StopType]
      ,[Tenure]
      ,[IsActive]
  FROM [SQLBook].[dbo].[Subscribers]

  SELECT StopType, COUNT(*)
  --, MIN(SubscriberId), MAX(SubscriberId)					
FROM Subscribers					
GROUP BY StopType					
ORDER BY StopType					


SELECT (CASE WHEN stoptype IS NOT NULL THEN 1 ELSE 0 END) as isstop
from subscribers 


select top 1 stopdate from subscribers
order by stopdate desc


SELECT YEAR(thedate) as year, SUM(isstart) as starts, SUM(isstop) as stops						
FROM ((SELECT startdate as thedate, 1 as isstart, 0 as isstop						
       FROM Subscribers s)						
      UNION ALL						
      (SELECT stopdate, 0 as isstart, 1 as isstop						
       FROM Subscribers s)						
     ) s						
GROUP BY YEAR(thedate)						
ORDER BY year			


SELECT 100 as tenure, COUNT(*) as popatrisk,					
       SUM(CASE WHEN Tenure = 100 AND stoptype IS NOT NULL					
                THEN 1 ELSE 0 END) as succumbtorisk,					
       AVG(CASE WHEN Tenure = 100 AND stoptype IS NOT NULL					
                THEN 1.0 ELSE 0 END) as h_100					
FROM Subscribers					
WHERE startdate >= '2004-01-01' AND Tenure >= 100					


			
