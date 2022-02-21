/* 1.	Write a query to display the first name, last name, salary, and job title, for each employee. Order them by their last name.*/

SELECT E.first_name , E.last_name , E.salary , J.job_title 
FROM employees E 
Inner JOIN jobs J
ON E.job_id = J.job_id
ORDER BY last_name;


/* 2.	Write a query to display the first and last name, department, city, and state province for each employee.*/

SELECT E.first_name , E.last_name , D.department_name , L.city , L.state_province
FROM employees E
Inner JOIN departments D
ON E.department_id = D.department_id
Inner JOIN locations L
ON D.location_id = L.location_id;


/* 3.	Write a query to display the first name, last name, department number and department name, for all employees for departments 5 or 7.*/

SELECT E.first_name , E.last_name , E.department_id , D.department_name 
FROM employees E
Inner JOIN departments D
ON E.department_id = D.department_id
WHERE E.department_id IN (5, 7);


/* 4.	Write a query to display the first and last name and salary for those employees who earn less than the employee earn whose number is 193.*/

SELECT first_name , last_name , salary 
FROM employees
WHERE salary < (SELECT salary FROM employees WHERE employee_id = '193');


/* 5.	Count the number of dependents per employee. */

SELECT E.employee_id , E.first_name , E.last_name , (SELECT COUNT(*) FROM dependents WHERE employee_id = E.employee_id) as dependents 
FROM employees as E;

OR 

SELECT E.employee_id , E.first_name , E.last_name, (SELECT COUNT(*) FROM dependents WHERE employee_id = E.employee_id) as dependents 
FROM dependents D
FULL OUTER JOIN employees E
ON D.employee_id = E.employee_id
ORDER BY employee_id;



/* 6.	Write a query to display the employee id, name (first name and last name), hire date and the experience column with the values as Senior and Junior respectively for those employees whose hire date is after 1995 and before 1995. */

SELECT  employee_id,  first_name, last_name, hire_date,  
CASE 
WHEN year(hire_date) <= 1995 THEN 'Senior'  
ELSE 'Junior'  
END as Experience 
FROM employees;


/* 7.	Write a query to display the first name, last name, employee id and hire date of all employees who report to ‘Neena’.*/

SELECT first_name, last_name, employee_id, hire_date  
FROM employees  
WHERE manager_id = 
(SELECT employee_id  
FROM employees  
WHERE first_name = 'Neena');


/* 8.	Display the employee first name, last name, employee id, and job title for all employees whose department location is ‘London’.*/

SELECT E.first_name, E.last_name, E.employee_id, J.job_title
FROM employees E
INNER JOIN jobs J 
ON E.job_id = J.job_id 
WHERE department_id = (SELECT department_id FROM departments WHERE location_id = (SELECT location_id FROM locations WHERE city = 'London'));


/* 9.	Count the number of Countries in each region.*/

SELECT R.region_name, count(country_id) as number_of_Countries
FROM countries C
LEFT JOIN regions R 
ON R.region_id = C.region_id
GROUP BY region_name;


/* 10.	Write a query to display the department id, sum of salary as total_amt, and size with the values as ‘Big’ and ‘Small’ respectively for those departments whose number of employees are more than 4 and less than 4. (Hint: Use Case When and a subquery to get the sum and count of employees in each department)*/

SELECT D.department_id, SUM (salary) as Total_amount,
CASE
    WHEN COUNT(E.department_id) > 4 THEN 'Big'
    WHEN COUNT (E.department_id) <= 4 THEN 'Small'
END as Size
FROM employees E 
JOIN departments D 
ON E.department_id = D.department_id 
GROUP BY D.department_id

OR

SELECT department_id, SUM (salary) as Total_amount,
CASE
    WHEN COUNT(department_id) > 4 THEN 'Big'
    WHEN COUNT (department_id) <= 4 THEN 'Small'
END as Size
FROM employees 
GROUP BY department_id
