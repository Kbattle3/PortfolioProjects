/* inner joins, full/left/right outer joins
*/

Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly','Flax', NULL, 'Male'),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

Insert into EmployeeSalary VALUES
(1010, NULL, 47000),
(NULL, 'Salesman', 43000)
SELECT * 
FROM EmployeeDemographics

SELECT * 
FROM EmployeeSalary

SELECT * 
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT * 
FROM EmployeeDemographics
Full OUTER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT * 
FROM EmployeeDemographics
Left OUTER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT EmployeeSalary.EmployeeID, FirstName, Lastname, JobTitle, Salary 
FROM EmployeeDemographics
Right Outer JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


SELECT EmployeeDemographics.EmployeeID, FirstName, Lastname, JobTitle, Salary 
FROM EmployeeDemographics
Right Outer JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


SELECT EmployeeDemographics.EmployeeID, FirstName, Lastname, JobTitle, Salary 
FROM EmployeeDemographics
Left Outer JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

/* find the highest paid employee to deduct pay from to meet quarterly quota. */

SELECT EmployeeDemographics.EmployeeID, FirstName, Lastname, Salary
FROM EmployeeDemographics
Inner JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC

SELECT *
FROM EmployeeDemographics
Inner JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

/* calculate avg salary for salesman*/

SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
Inner JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle
