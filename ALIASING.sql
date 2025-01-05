SELECT dem.EmployeeID, sal.Salary
FROM [SQL Tutorial].[dbo].[EmployeeDemographics1] AS dem
JOIN [SQL Tutorial].[dbo].[EmployeeSalary]  AS sal
     ON dem.EmployeeID = sal.EmployeeID
 