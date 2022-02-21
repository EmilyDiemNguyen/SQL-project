/* DAB 203 MID TERM PROJECT WEEK 5 
* THI NGOC DIEM NGUYEN
* Student ID: 0778061 */


Select *
from trips

/* Simple Select Statement */

SELECT starttime, bikeid FROM trips;

/* Use of Top Keyword */

SELECT  top 10 starttime, bikeid FROM trips;

/* Add order by clause */

SELECT  top 10 starttime, bikeid FROM trips
order by tripduration asc;


/* 1.	What was the duration of the longest trip? */

SELECT MAX(tripduration) as Max_tripduration
FROM trips;

/* 2.	How many trips were taken by 'subscriber' users? */

SELECT usertype, COUNT(*) as cnt			
FROM trips 			
GROUP BY usertype			
ORDER BY cnt;
				
/* 3.	What was the average trip duration? */

SELECT AVG(tripduration) as AVG_tripduration
FROM trips;

/* 4.	Do subscriber or customers usertype take longer trips? */

SELECT usertype, SUM(tripduration) AS Sum_tripduration
FROM trips
GROUP BY usertype 
ORDER BY Sum_tripduration;

/* 5.	Which bike was used for the most trips? */

SELECT top 1 bikeid, count(*) Total_trip
FROM trips
GROUP BY bikeid
ORDER BY Total_trip desc;

/* 6.	What is the average duration of trips by users over the age of 30? */

SELECT AVG(tripduration) Avg_over30
FROM trips
WHERE birthyear < 1991;

/* 7.	Which station is the most frequent starting point? */

SELECT top 10 startstationname,count(*) Top_station
FROM trips
GROUP BY startstationname
ORDER BY Top_station desc;

/* 8.	Which bike was used for the longest total time? */

SELECT bikeid, SUM(tripduration) as Total_tripduarion
FROM trips
GROUP BY bikeid
ORDER BY Total_tripduarion desc;
