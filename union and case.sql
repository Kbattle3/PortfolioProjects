/* union, union all
*/

SELECT * 
FROM SQLTutorial.DBO.EmployeeDemographics

SELECT *
FROM WareHouseEmployeeDemographics

SELECT * 
FROM SQLTutorial.DBO.EmployeeDemographics
FULL OUTER JOIN  WareHouseEmployeeDemographics
ON EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID


SELECT * 
FROM SQLTutorial.DBO.EmployeeDemographics
UNION
SELECT *
FROM WareHouseEmployeeDemographics


SELECT * 
FROM SQLTutorial.DBO.EmployeeDemographics
UNION ALL
SELECT *
FROM WareHouseEmployeeDemographics
ORDER BY EmployeeID



SELECT * 
FROM SQLTutorial.DBO.EmployeeDemographics
UNION 
SELECT *
FROM WareHouseEmployeeDemographics
ORDER BY EmployeeID






SELECT EmployeeID, FirstName, Age
FROM SQLTutorial.DBO.EmployeeDemographics
UNION
SELECT EmployeeID, JobTitle, Salary
FROM SQLTutorial.dbo.EmployeeSalary
ORDER BY EmployeeID



/* CASE STATEMENT 
*/
SELECT * 
FROM SQLTutorial.dbo.EmployeeDemographics

SELECT FirstName, Lastname, Age,
CASE
	WHEN AGE > 30 THEN 'Old' 
	ELSE 'Young'
END
FROM SQLTutorial.dbo.EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age

SELECT FirstName, Lastname, Age,
CASE
	WHEN AGE > 30 THEN 'Old' 
	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
	ELSE 'Baby'
END
FROM SQLTutorial.dbo.EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age


SELECT FirstName, Lastname, Age,
CASE
	WHEN Age = 38 THEN 'Stanley'
	WHEN AGE > 30 THEN 'Old' 
	ELSE 'Baby'
END
FROM SQLTutorial.dbo.EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age

/* salaries after raise */

SELECT FirstName,Lastname, JobTitle, salary,
CASE 
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
	WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001)
	ELSE Salary + (Salary * 0.03)
	END AS SalaryAfterRaise
FROM SQLTutorial.DBO.EmployeeDemographics
JOIN SQLTutorial.dbo.EmployeeSalary
	ON SQLTutorial.DBO.EmployeeDemographics.EmployeeID = SQLTutorial.dbo.EmployeeSalary.EmployeeID


	
