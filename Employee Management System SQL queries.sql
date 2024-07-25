/* Here is Table Script*/

CREATE TABLE EmployeeDetails (
EmployeeID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Department VARCHAR(50),
Salary DECIMAL(10,2),
HireDate DATE);

/* Inserting data into EmployeesTable */

INSERT INTO EmployeeDetails (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
(1, 'Amit'   , 'Sharma'   , 'HR'       , 50000.00, '2015-05-20'),
(2, 'Anjali' , 'Singh'    , 'IT'       , 60000.00, '2017-08-15'),
(3, 'Rahul'  , 'Verma'    , 'Marketing', 55000.00, '2020-01-10'),
(4, 'Priya'  , 'Reddy'    , 'Finance'  , 65000.00, '2017-04-25'),
(5, 'Vikram' , 'Patel'    , 'HR'       , 52000.00, '2017-09-30'),
(6, 'Amit'   , 'Mishra'   , 'IT'       , 62000.00, '2021-11-18'),
(7, 'Suresh' , 'Iyer'     , 'Marketing', 58000.00, '2024-02-26'),
(8, 'Lakshmi', 'Menon'    , 'Finance'  , 70000.00, '2022-07-12'),
(9, 'Arjun'  , 'Menon'    , 'HR'       , 53000.00, '2023-10-05'),
(10, 'Nisha' , 'Mehta'    , 'IT'       , 64000.00, '2016-03-08');


/* Employee Management System Project */

--Question 1: Retrieve only the FirstName and LastName of all employees.

Select FirstName, LastName from Employeedetails

--Question 2: Retrieve distinct departments from the employeeDetails table.

Select distinct Department from EmployeeDetails

--Question 3: Retrieve employees whose salary is greater than 55000.

Select * From EmployeeDetails where Salary > 55000

--Question 4: Retrieve employees hired after 2019.

Select * From EmployeeDetails where YEAR(HireDate) > 2019

--Question 5: Retrieve employees whose first name starts with ‘A’.

Select * From EmployeeDetails where FirstName Like 'A%'

--Question 6 :Retrieve employees whose last name ends with ‘non’.

Select * from EmployeeDetails where LastName Like '%non'

--Question 7: Retrieve employees whose First name do not have ‘a’.

Select * From EmployeeDetails where FirstName Not Like '%A%'

--Question 8: Retrieve employees sorted by their salary in descending order.

Select * From EmployeeDetails Order by Salary desc

--Question 9: Retrieve the count of employees in each department.

Select COUNT(*) AS EmpCount, Department From EmployeeDetails Group by Department

--Question 10: Retrieve the average salary of employees in the Finance department.

Select Avg(Salary) AS AvgSalaryFinance From EmployeeDetails where Department='Finance'

--Question 11: Retrieve the maximum salary among all employees.

Select Max(Salary) From EmployeeDetails

--Question 12 :Retrieve the total salary expense for the company.

Select Sum(Salary) AS TotalSalaryExpense From EmployeeDetails

--Question 13: Retrieve the oldest and newest hire date among all employees.

Select MIn(hireDate) AS oldestHireDate, Max(hireDate) AS newestHireDate From EmployeeDetails

--Question 14: Retrieve employees with a salary between 50000 and 60000.

Select * From EmployeeDetails where Salary between 50000 and 60000

--Question 15: Retrieve employees who are in the HR department and were hired before 2019.

Select * From EmployeeDetails where Department= 'HR' and Year(HireDate) <2019

--Question 16: Retrieve employees with a salary less than the average salary of all employees.

Select * From EmployeeDetails where Salary < (Select Avg (Salary) From EmployeeDetails)

--Question 17: Retrieve the top 3 highest paid employees.

Select Top(3) * From EmployeeDetails Order by Salary DESc

--Question 18 : Retrieve employees whose hire date is not in 2017.

Select * From EmployeeDetails where Year(HireDate) <> 2017

--Question 19 : Retrieve the nth highest salary (you can choose the value of n).

Select Distinct Salary From EmployeeDetails Order by Salary Desc Offset 3-1 ROWS FETCH NEXT 1 ROWS ONLY

--Question 20 : Retrieve employees who were hired in the same year as ‘Priya Reddy’.

Select * From EmployeeDetails where Year(HireDate) = (Select Year(HireDate) From EmployeeDetails where FirstName = 'Priya' AND LastName = 'Reddy')

--Question 21 : Retrieve employees who have been hired on weekends (Saturday or Sunday).

Select  * From EmployeeDetails where DATEPART(Weekday, HireDate) IN (1,7)

--Question 22 : Retrieve employees who have been hired in the last 6 years.

Select  * From EmployeeDetails Where HireDate >= DATEADD(Year,-6, GETDATE())

--Question 23 : Retrieve the department with the highest average salary.

Select Department From EmployeeDetails Group by Department Having AVg(Salary) =
(Select Max(AvgSalary) From 
(Select Avg(Salary) AS AvgSalary From EmployeeDetails Group by Department) As AvgSalaries )

--Question 24 : Retrieve the top 2 highest paid employees in each department.

With CTE AS(
Select *, DENSE_RANK() Over(Partition by Department Order by Salary Desc) As Rank from EmployeeDetails)
Select * From CTE where Rank<= 2

--Question 25 : Retrieve the cumulative salary expense for each department sorted by department and hire date.

Select *, SUM(Salary) Over(Partition by Department Order by HireDate) AS CumulativeSalary From EmployeeDetails Order by Department, HireDate

--Question 26 : Retrieve the employee ID, salary, and the next highest salary for each employee.

Select EmployeeID, Salary, LEAD(Salary) Over(Order by Salary) AS NxtHighestSalary From EmployeeDetails

--Question 27 : Retrieve the employee ID, salary, and the difference between the current salary and the next highest salary for each employee.

Select EmployeeID, Salary,LEAD(Salary) Over(Order by Salary)-Salary AS DiffBtwSalary From EmployeeDetails

--Question 28 : Retrieve the employee(s) with the highest salary in each department.

With CTE AS(
Select *, DENSE_RANK() Over(Partition by Department Order by Salary Desc) As Rank from EmployeeDetails)
Select * From CTE where Rank = 1

--Question 29 : Retrieve the department(s) where the total salary expense is greater than the average total salary expense across all departments.

Select Department From EmployeeDetails group by Department Having SUM(Salary) > 
(Select AVG(TotalSalaryExpense) From (
Select SUM(Salary) AS TotalSalaryExpense From EmployeeDetails Group by Department) As AvgTotalsalaryExp)

--Question 30 : Retrieve the employee(s) who have the same first name and last name as any other employee.

Select * From EmployeeDetails e1 Inner Join EmployeeDetails e2 On e1.EmployeeID<>e2.EmployeeID
where e1.FirstName=e2.FirstName and e1.LastName=e2.LastName

--Question 31 : Retrieve the employee(s) who have been with the company for more then 7 Years.

Select FirstName, LastName, DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsWithCompany
From employeeDetails
where DATEDIFF(YEAR, HireDate, GETDATE()) > 7;

--Question 32 : Retrieve the department with the highest salary range (Difference b/w highest and lowest).

Select Department, MAX(Salary) - MIN(Salary) AS Range
From employeeDetails
Group by Department
Order by Range DESC