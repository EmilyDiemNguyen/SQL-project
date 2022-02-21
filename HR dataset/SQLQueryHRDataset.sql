--Write a query in SQL to display the first name, last name, department number, 
--and department name for each employee.

SELECT E.first_name , E.last_name , 
       E.department_id , D.department_name 
        FROM employees E 
         Inner JOIN departments D 
          ON E.department_id = D.department_id;





--Write a query in SQL to display the first and last name, department, city, and 
--state province for each employee.
SELECT E.first_name , E.last_name , D.department_name, l.city, l.state_province 
        FROM employees E 
        inner JOIN departments D 
          ON E.department_id = D.department_id
		inner join locations l
		  on d.location_id =l.location_id

--To get the information of employees who work in the department id 1, 2 and 3, you use the following 
SELECT
    first_name,
    last_name,
    department_id
FROM
    employees
WHERE
    department_id IN (1, 2, 3)
ORDER BY
    department_id;



--Find the country name that does not have any locations in the locations table	 

SELECT
    country_name
FROM
    countries c
LEFT JOIN locations l ON l.country_id = c.country_id
WHERE
    l.location_id IS NULL
ORDER BY
    country_name;

--Join three tables: regions, countries, and locations 
--to get information on region name, country name, street address and city


SELECT
    r.region_name,
    c.country_name,
    l.street_address,
    l.city
FROM
    regions r
left JOIN countries c ON c.region_id = r.region_id
left JOIN locations l ON l.country_id = c.country_id



--find all employees with the department information who locate in the location with the id 1700.


SELECT 
    employee_id, first_name, last_name,department_id
FROM
    employees
WHERE
    department_id IN (SELECT 
            department_id
        FROM
            departments
        WHERE
            location_id = 1700)



--find all employees who do not locate at the location 1700


SELECT 
    employee_id, first_name, last_name,department_id
FROM
    employees
WHERE
    department_id NOT IN (SELECT 
            department_id
        FROM
            departments
        WHERE
            location_id = 1700)
ORDER BY first_name , last_name;






--finds the employees who have the highest salary:

SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary = (SELECT 
            MAX(salary)
        FROM
            employees)
ORDER BY first_name , last_name;



--finds all employees who salaries are greater than the average salary of all employees:



SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employees);  


--finds all departments which have at least one employee with the salary is greater than 10,000:

SELECT 
    department_name
FROM
    departments d
WHERE
    EXISTS( SELECT 
            1
        FROM
            employees e
        WHERE
            salary > 10000
                AND e.department_id = d.department_id)
ORDER BY department_name; 


--finds all departments that do not have any employee with the salary greater than 10,000:

SELECT 
    department_name
FROM
    departments d
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            employees e
        WHERE
            salary > 10000
                AND e.department_id = d.department_id)
ORDER BY department_name; 



--Write a query to display the employee name 
--( first name and last name ), employee id and salary of all employees who report to Steven

SELECT first_name, last_name, employee_id, salary  
FROM employees  
WHERE manager_id = 
(SELECT employee_id  
FROM employees  
WHERE first_name = 'Steven' 
);

--Write a query to display the employee name( first name and last name ) 
--and hiredate for all employees in the same department as David. Exclude David.

SELECT first_name, last_name, hire_date  
FROM employees  
WHERE department_id =  
( SELECT department_id  
FROM employees  
WHERE first_name = 'David')  
AND first_name <> 'David'



--Use of Case with subquery
--Write a query to display the employee id, name ( first name and last name ),
--salary and the SalaryStatus column with a title HIGH and LOW respectively 
--for those employees whose salary 
--is more than and less than the average salary of all employees.

SELECT  employee_id,  first_name, last_name, salary,  
(CASE WHEN salary >= 
(SELECT AVG(salary) 
FROM employees) THEN 'HIGH'  
ELSE 'LOW'  
END )SalaryStatus 
FROM employees;