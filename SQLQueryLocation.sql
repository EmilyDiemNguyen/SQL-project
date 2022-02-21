
--Which zip codes have any household with solar power? 
SELECT zcta5, longitude,				
       (CASE WHEN hhfsolar = 0 THEN latitude END) as nosolarlat,				
       (CASE WHEN hhfsolar > 0 THEN latitude END) as solarlat				
FROM ZipCensus				
WHERE latitude BETWEEN 20 and 50 AND
Longitude Between -135 and -65				


select zcta5, hhfsolar, tothhs from ZipCensus

--What proportion of zip codes in each state have at least one solar powered residence? 

SELECT TOP 10 stab, COUNT(*) as numzips, SUM(tothhs) as NumHHs,						
       SUM(CASE WHEN hhfsolar > 0 THEN 1.0 END)/COUNT(*) as propzips,						
       SUM(hhfsolar * 1.0) / SUM(tothhs)as prophhu						
FROM ZipCensus zc						
GROUP BY stab						
ORDER BY prophhu DESC

--Where are the Customers?

SELECT zc.zcta5, longitude, latitude, numords									
FROM ZipCensus zc JOIN					
     (SELECT ZipCode, COUNT(*) as numords					
      FROM Orders					
      GROUP BY ZipCode) o					
     ON zc.zcta5 = o.zipcode					
WHERE latitude BETWEEN 20 and 50 AND					
      longitude BETWEEN -135 AND -65	

--Find the zip code with the highest median household income is

	  SELECT TOP 1 zcta5, medianhhinc			
FROM ZipCensus			
ORDER BY medianhhinc DESC		

--Find the zip code with the lowest  median household income is
 
SELECT TOP 1 zcta5, medianhhinc			
FROM ZipCensus			
ORDER BY medianhhinc ASC		



--Information About the Wealthiest and Poorest ZipCodes

SELECT zcta5, stab, medianhhinc, medianfaminc, totpop, tothhs				
FROM ZipCensus zc CROSS JOIN				
     (SELECT MAX(famhhinc200) as richest, MAX(famhhinc0) as poorest				
      FROM zipcensus				
      WHERE tothhs >= 1000) minmax				
WHERE (zc.famhhinc200 = richest OR zc.famhhinc0 = poorest) AND				
      zc.tothhs >= 1000				

	





								
					

	

	


						
