use [AdventureWorks2019]

Select e.JobTitle, e.HireDate
from HumanResources.Employee e
Order by e.HireDate DESC;

---------------------------------------------------------------------------
50
Select *
from Sales.SalesOrderHeader h
join
Sales.SalesOrderDetail d
On h.SalesOrderID=d.SalesOrderID
Where d.OrderQty >5 Or d.UnitPriceDiscount < 1000 AND H.TotalDue>100;
---------------------------------------------------------------------------

--CREATE VIEW v_salesorderdetail AS

--	Select *
--	from Sales.SalesOrderHeader h
--	join
--	Sales.SalesOrderDetail d
--	On h.SalesOrderID=d.SalesOrderID
--	Where (d.OrderQty >5 Or d.UnitPriceDiscount < 1000) AND H.TotalDue>100;

-------------------------------------------------------------------------------------

51
Select *
From Sales.SalesOrderHeader h
Join
Sales.SalesOrderDetail d
On h.SalesOrderID=d.SalesOrderID
Where (d.OrderQty>5 or d.UnitPriceDiscount<1000) AND h.TotalDue>100;

--------------------------------------------------------------------------------------

52
Select p.Name,p.Color
from
Production.Product p
Where p.Name like '%red%'
----------------------------------------------------------------------------------

--53
Select p.Name,p.ListPrice
from Production.Product p
Where p.ListPrice='$80.99';

--------------------------
54
Select p.Name, p.Color
from
Production.Product p
Where p.Name like '%Mountain%' OR p.Name LIKE '%Road%'

--------------------------------

--55
Select p.Name, p.Color
from
Production.Product p
--Where p.Name In ('Mountain','Road')
Where p.Name like '%Mountain%' OR p.Name LIKE '%Black%'
----------------------------------------------------------
--56
Select p.Name, p.Color
from
Production.Product p
--Where p.Name In ('Mountain','Road')
Where p.Name like '%chain%' 
--------
57
Select p.Name, p.Color
from
Production.Product p
--Where p.Name In ('Mountain','Road')
Where p.Name like '%chain%' OR p.Name LIKE '%full%'
-------------------------------------------
select (p.FirstName+ p.LastName +'  '+ e.EmailAddress) as [Employee's name]
from Person.person p
Join person.EmailAddress e
On p.BusinessEntityID=e.BusinessEntityID
-------------------------------------------------
--60
Select CONCAT(p.name, p.Color, p.ProductNumber)
From Production.Product p
-----------------------------------------
--61
select LEFT(p.Name,5)
From Production.Product p

--------------------------------------------
--63
use [AdventureWorks2019]
Select Len(v.FirstName) as lenght, v.FirstName,v.LastName
from Sales.vindividualcustomer v
Where v.CountryRegionName= 'Australia';
-------------------------------------------------
--64
select len(c.Name), c.FirstName, c.LastName
from Sales.vStoreWithAddresses s
Inner Join Sales.vStoreWithContacts c
On s.BusinessEntityID=c.BusinessEntityID
Where CountryRegionName='Australia';
---------------------------------------------------
----------------

65
Select Lower(p.Name)as 'lower', UPPER(p.Name) as 'upper', LOWER(Name) + UPPER(Name) AS LowerUpper
from Production.Product p
Where p.ListPrice between 1000 AND 1220.00;

-------
66
Select  EmailAddress, City
From Person.BusinessEntity b
Join Person.Address a
On a.AddressID=b.BusinessEntityID
Join Person.EmailAddress e
On e.BusinessEntityID= b.BusinessEntityID
Group by City
-----
80
Select p.Name, p.ListPrice
from Production.Product p
Where p.ListPrice like '33%'
--------------------------------------------------
-----------------------------------------------
--81
Select *
From Sales.SalesPerson s

Select CAST(Round(s.SalesYTD/s.CommissionPct,0)AS INT) as computed, s.SalesYTD,s.CommissionPct
From Sales.SalesPerson s;
--------------
Select p.FirstName, p.LastName,p.BusinessEntityID,s.SalesYTD
from Person.Person p
Join Sales.SalesPerson s
On p.BusinessEntityID=p.BusinessEntityID
WHERE CAST(CAST(s.SalesYTD as INT) as char(20)) like '2%'
------------------------------------------------------------------
--------------------------------------------------------------------
--85
Select AVG(e.VacationHours), sum(e.SickLeaveHours)
FROM
HumanResources.Employee e
WHERE JobTitle LIKE 'Vice President%';



-- Selecting the average vacation hours and the total sick leave hours
SELECT AVG(VacationHours) AS "Average vacation hours",   
    SUM(SickLeaveHours) AS "Total sick leave hours"  

-- From the HumanResources schema's Employee table
FROM HumanResources.Employee  

-- Filtering the results to include only rows where the job title starts with 'Vice President'
WHERE JobTitle LIKE 'Vice President%';

------------------
Select *
From Sales.SalesPerson

Select S.TerritoryID ,AVG(s.Bonus) as average_bonus, SUM(s.SalesYTD) as YTD_sales
From Sales.SalesPerson s
Group by S.TerritoryID;

--87
Select AVG(DISTINCT P.ListPrice)
from Production.Product P
--88
use [AdventureWorks2019]

-- Selecting various columns along with calculated fields from the SalesPerson table
SELECT BusinessEntityID, TerritoryID   
   ,--DATE_PART('year', ModifiedDate) AS SalesYear  -- Extracting the year from the ModifiedDate column
   CAST(SalesYTD AS VARCHAR(20)) AS SalesYTD  -- Converting SalesYTD to VARCHAR data type
   ,AVG(SalesYTD) OVER (PARTITION BY TerritoryID ORDER BY DATE_PART('year', ModifiedDate)) AS MovingAvg  -- Calculating moving average of SalesYTD partitioned by TerritoryID
   ,SUM(SalesYTD) OVER (PARTITION BY TerritoryID ORDER BY DATE_PART('year', ModifiedDate)) AS CumulativeTotal  -- Calculating cumulative total of SalesYTD partitioned by TerritoryID
FROM Sales.SalesPerson  -- From the SalesPerson table

-- Filtering the results to include only rows where TerritoryID is NULL or less than 5
WHERE TerritoryID IS NULL OR TerritoryID < 5  

-- Ordering the results by TerritoryID and SalesYear
ORDER BY TerritoryID, SalesYear;

--90
Select COUNT(Distinct(e.jobtitle))
from
HumanResources.Employee e
--91
Select Count(Distinct(e.NationalIDNumber)) as Number_of_employees
from
HumanResources.Employee e
--92
Select *
from
Sales.SalesPerson s


Select Count(*),AVG(Bonus)
from
Sales.SalesPerson s
Where SalesQuota> 25000;

--93
Select Name,Min(e.Rate) as Salary, Max(e.Rate) max_salary, AVG(e.Rate) average_salary, Count(*) number_of_employees
from HumanResources.EmployeePayHistory e
join HumanResources.EmployeeDepartmentHistory h
On e.BusinessEntityID=h.BusinessEntityID
join HumanResources.Department d
On d.DepartmentID=h.BusinessEntityID
Group by Name

--
Select e.JobTitle, COUNT(*)
from HumanResources.Employee e
Group by e.JobTitle
Having COUNT(*)>15;
------------------------------
Select *,
	CASE Color
		When 'Black' then 'Good'
		When 'Silver' Then 'ok'
		When 'Red' then 'fine'
		When 'White' then 'lets go'
		Else 'cant classify'
	End  as 'color class'
from Production.Product p
Where p.Color is NOT NULL;
-------
101
Select Department, 
	LastName, 
	Rate, 
	CUME_DIST()Over(Partition by Department Order by rate) as CumeDist,
	PERCENT_RANK() Over(Partition by Department Order by rate) as PctRank
from HumanResources.vEmployeeDepartmentHistory dh
Join
HumanResources.EmployeePayHistory ph
On dh.BusinessEntityID=ph.BusinessEntityID
Where Department IN ('Information Services','Document Control')
Order by Department, Rate DESC;

---
-- Selecting the Name and ListPrice columns, along with the least expensive product within the ProductSubcategoryID = 37
SELECT Name, ListPrice,
       FIRST_VALUE(Name) OVER (ORDER BY ListPrice ASC) AS LeastExpensive
-- From the Production.Product table
FROM Production.Product
-- Filtering the products based on the ProductSubcategoryID = 37
WHERE ProductSubcategoryID = 37;
--------
101
use [AdventureWorks2019]
Select FirstName,
		LastName, 
		FIRST_VALUE(LastName) OVER (PARTITION BY JobTitle  -- Partitioning the data by job title
                                   ORDER BY VacationHours ASC  -- Ordering the data by vacation hours in ascending order
                                   ROWS UNBOUNDED PRECEDING  -- Specifying the window frame to include all preceding rows within the partition
                                  ) AS FewestVacationHours  -- Calculating the last name of the employee with the fewest vacation hours
from HumanResources.Employee e
Join Person.Person p
On e.BirthDate=p.BusinessEntityID;