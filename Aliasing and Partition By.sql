/* aliasing */

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics


SELECT FirstName + ' ' + Lastname AS FullName
FROM SQLTutorial.dbo.EmployeeDemographics



SELECT AVG(Age) AS AvAge
FROM SQLTutorial.dbo.EmployeeDemographics

SELECT Demo.EmployeeID, Sal.Salary
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID

SELECT Demo.EmployeeID, Demo.FirstName, Demo.Lastname, Sal.JobTitle, Ware.Age
FROM SQLTutorial.dbo.EmployeeDemographics as Demo
LEFT JOIN SQLTutorial.dbo.EmployeeSalary as Sal
	ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN SQLTutorial.dbo.WareHouseEmployeeDemographics as Ware
	ON Demo.EmployeeID = Ware.EmployeeID


	/* partition by*/

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics

SELECT *
FROM SQLTutorial.dbo.EmployeeSalary


SELECT FirstName, Lastname, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM SQLTutorial.dbo.EmployeeDemographics AS dem
JOIN SQLTutorial.dbo.EmployeeSalary As sal
	ON dem.EmployeeID = sal.EmployeeID

	/* where as using group by would look like this and that is not what we want*/

SELECT Gender, COUNT(Gender) 
FROM SQLTutorial.dbo.EmployeeDemographics AS dem
JOIN SQLTutorial.dbo.EmployeeSalary As sal
	ON dem.EmployeeID = sal.EmployeeID
GROUP BY Gender