
SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
FROM [SQL Tutorial]..[EmployeeDemographics1] dem
JOIN  [SQL Tutorial]..[EmployeeSalary] sal
    ON dem.EmployeeID = sal.EmployeeID

SELECT Gender,COUNT(Gender)
FROM [SQL Tutorial]..[EmployeeDemographics1] dem
JOIN  [SQL Tutorial]..[EmployeeSalary] sal
    ON dem.EmployeeID = sal.EmployeeID
GROUP BY Gender
	