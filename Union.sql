select * 
from Orders;

/* All prime ministers and monarchs Union Operator */

SELECT prime_minister as leader, country
FROM prime_ministers
UNION
SELECT monarch, country
FROM monarchs
ORDER BY country;

/* Another version */

SELECT monarch, country
FROM monarchs
UNION
SELECT prime_minister as leader, country
FROM prime_ministers
order by country;


/* Union All */

SELECT country
FROM prime_ministers
UNION ALL
SELECT country
FROM monarchs
ORDER BY country;


/* Intersect */

SELECT country, prime_minister
FROM prime_ministers
INTERSECT
SELECT country, monarch
FROM Monarchs;

/* Intersect continued */

SELECT country, prime_minister AS leader
FROM prime_ministers
INTERSECT
SELECT country, president
FROM presidents;

/* Except */

SELECT monarch, country
FROM monarchs
EXCEPT
SELECT prime_minister, country
FROM prime_ministers;



SELECT prime_minister
FROM prime_ministers
EXCEPT
SELECT monarch
FROM monarchs
/* Case Statements */
SELECT name, continent, indep_year,
    CASE WHEN indep_year < 1900 THEN 'before 1900'
         WHEN indep_year <= 1930 THEN 'between 1900 and 1930'
         ELSE 'after 1930' END
         AS indep_year_group
FROM states
ORDER BY indep_year_group;

/* IN */
SELECT president, country, continent
FROM presidents
WHERE country IN
    (SELECT name
     FROM states
     WHERE indep_year < 1800);


/* NOT IN */

SELECT president, country, continent
FROM presidents
WHERE continent LIKE '%America' 
    AND country NOT IN
        (SELECT name
         FROM states
         WHERE indep_year < 1800);


/* Asian countries below average fert_rate */
SELECT name, fert_rate
FROM states
WHERE continent = 'Asia' 
    AND fert_rate <
        (SELECT AVG(fert_rate)
         FROM states);


/* NUmber of countries listed in the states table for each continent is in the primeministers table */
SELECT DISTINCT continent,
    (SELECT COUNT(*)
     FROM states
     WHERE prime_ministers.continent = states.continent) AS countries_num
FROM prime_ministers;

/* Maximun % of women in parliament for each continent listed in states */

SELECT continent, MAX(women_parli_perc) AS max_perc
FROM states
GROUP BY continent
ORDER BY continent;


