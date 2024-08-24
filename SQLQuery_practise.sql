use [AdventureWorks2019]
Select * From HumanResources.EmployeeDepartmentHistory hre

left join
   [HumanResources].[Department] hrd
  On hre.DepartmentID=hrd.DepartmentID;

  Select * From HumanResources.EmployeeDepartmentHistory hre

right join
   [HumanResources].[Department] hrd
  On hre.DepartmentID=hrd.DepartmentID;

  Select * from HumanResources.Employee
  Order by 6 ASC;


  Select * from HumanResources.Employee HRE
  Order by 6 ASC;

  Select pp.*
  From Person.Person pp
  Order by LastName;

  Select p.FirstName, p.LastName, p.BusinessEntityID as Employee_id
  From Person.Person p
  Order by 2;

 Select ProductID, ProductNumber, Name d
  From Production.Product
  Where SellStartDate IS NOT NULL AND ProductLine ='T'
  Order by Name;
 

 Select salesorderid, customerid, orderdate, subtotal,((TaxAmt/SubTotal)*100) as 'Percentage of tax'
 From sales.SalesOrderHeader 
 Order by 'Percentage of tax ' DESC;

 Select Distinct JobTitle
 from HumanResources.Employee
 Order by JobTitle ASC;

 Select S.CustomerID, sum(Freight) AS TOTAL_FREIGHT
 from sales.SalesOrderHeader S
 Group by CustomerID 
 --Having sum(Freight) >200
 Order by customerID;

 select customerid,salespersonid, AVG(SUBTOTAL) Average, SUM(SUBTOTAL) Total
 From sales.SalesOrderHeader
 GROUP BY customerid,salespersonid
 Order by CustomerID DESC;

 Select  ProductID,Shelf, 
		Sum(Quantity) Total
 from Production.ProductInventory
 Where Shelf in ('A','C','H')
 Group BY ProductID, Shelf
 Order By ProductID ASC;

 Select LocationID*10, (sum(Quantity)) total_quantity
 from
 Production.ProductInventory
 Group by locationid, (LocationID*10);

 Select ppp.BusinessEntityID, FirstName, LastName, PhoneNumber
 From Person.PersonPhone ppp
 Join Person.Person pp
 ON PPP.BusinessEntityID=pp.BusinessEntityID
 Where LastName like 'l%'
 Order By Lastname, FirstName;

 Select sum(Quantity),LocationID, 
 From Production.ProductInventory

 -- Selecting columns for location ID, shelf, and the sum of quantity
SELECT locationid, shelf, SUM(quantity) AS TotalQuantity
-- Retrieving data from the 'productinventory' table
FROM production.productinventory
-- Grouping the results using both ROLLUP and CUBE functions
GROUP BY GROUPING SETS ( ROLLUP (locationid, shelf), CUBE (locationid, shelf) );


Select top 3*
--from Person.BusinessEntityAddress
  from Person.Address

  Select top 3*
  from Person.BusinessEntityAddress
  --from Person.Address

  -- Selecting the city and counting the number of employees in each city
SELECT *
--a.City, COUNT(b.AddressID) NoOfEmployees 
-- Retrieving data from the 'BusinessEntityAddress' table aliased as 'b'
FROM Person.BusinessEntityAddress AS b   
    -- Joining the 'BusinessEntityAddress' table with the 'Address' table aliased as 'a'
    INNER JOIN Person.Address AS a  
        ON b.AddressID = a.AddressID  
-- Grouping the results by city
--GROUP BY 
-- Ordering the results by city
--ORDER BY a.City;

Select YEAR(OrderDate)  as Year, Round(sum(TotalDue),2) as Total
from Sales.SalesOrderHeader
Group by YEAR(OrderDate)
Order by YEAR(OrderDate)

Select Year(OrderDate) as Yea, Round(sum(TotalDue),2) as Total
from Sales.SalesOrderHeader
Where Year(OrderDate) <= 2016
Group by YEAR(OrderDate)
Order by YEAR(OrderDate)

select ContactTypeID, Name
From Person.ContactType
Where Name like '%manager%'
Order by Name Desc;


Select pp.BusinessEntityID,
	   pp.LastName,
	   pp.FirstName,
	   pct.Name as job_function

From Person.Person pp
 inner Join
Person.BusinessEntityContact pbc
On pp.businessentityid=pbc.businessentityid
inner join
Person.ContactType pct
On pbc.BusinessEntityID= pct.ContactTypeID

Where name like '%manager%'

Order by Name DESC;

-- Selecting BusinessEntityID, LastName, and FirstName from multiple tables based on specified conditions
SELECT pp.BusinessEntityID, LastName, FirstName
    -- Retrieving BusinessEntityID, LastName, and FirstName columns
    FROM Person.BusinessEntityContact AS pb 
        -- Joining Person.BusinessEntityContact with Person.ContactType based on ContactTypeID
        INNER JOIN Person.ContactType AS pc
            ON pc.ContactTypeID = pb.ContactTypeID
        -- Joining Person.BusinessEntityContact with Person.Person based on BusinessEntityID
        INNER JOIN Person.Person AS pp
            ON pp.BusinessEntityID = pb.PersonID
    -- Filtering the results to include only records where the ContactType Name is 'Purchasing Manager'
    WHERE pc.Name = 'Purchasing Manager'
    -- Sorting the results by LastName and FirstName
    ORDER BY LastName, FirstName;

	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Selecting row numbers, last names, sales year-to-date, and postal codes from multiple tables with window function usage
SELECT 
    -- Using the ROW_NUMBER() window function to assign a unique row number to each row within a partition
    ROW_NUMBER() OVER win AS "Row Number",
    -- Selecting the last names of salespersons
    pp.LastName, 
    -- Selecting the year-to-date sales amount
    sp.SalesYTD, 
    -- Selecting the postal codes associated with the addresses
    pa.PostalCode
-- Joining Sales.SalesPerson table with Person.Person and Person.Address tables based on specific conditions
FROM Sales.SalesPerson AS sp
    INNER JOIN Person.Person AS pp
        ON sp.BusinessEntityID = pp.BusinessEntityID
    INNER JOIN Person.Address AS pa
        ON pa.AddressID = pp.BusinessEntityID
-- Filtering the rows based on certain conditions
WHERE TerritoryID IS NOT NULL
    AND SalesYTD <> 0
-- Defining a window for the window function
WINDOW win AS (PARTITION BY PostalCode ORDER BY SalesYTD DESC)
-- Sorting the result set by postal code
ORDER BY PostalCode;
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 24
SELECT  ratechangedate, CONCAT(Firstname,' ', MiddleName,' ', LastName) as 'Full_Name', Concat('$',(40*Rate)) as Weekly_Salary
From
Person.Person p
Join
HumanResources.EmployeePayHistory h
On p.BusinessEntityID=h.BusinessEntityID

--------------------------------------------------------------------------

--25

Select SalesOrderID, ProductID, OrderQty,Sum(orderqty) Total_orders, AVG(orderqty)Average_orders, Count(orderqty)Number_of_orders, Max(orderqty)Max_orders, Min(orderqty)Min_orders
From
Sales.SalesOrderDetail
Where SalesOrderID in (43659,43664)
Group by SalesOrderID, ProductID, OrderQty;

-------------------------------------------------------------------------------

--31
Select FirstName, LastName
from
Person.Person
Where lastname like 'R%'
Order by FirstName ASC , Lastname DESC

--------------------------------------------------------------------------------

--32
Select BusinessEntityID, SalariedFlag
From
HumanResources.Employee
Order by case SalariedFlag WHEN 'true' then BusinessEntityID END DESC,
		 case When SalariedFlag ='False' Then BusinessEntityID END;

---------------------------------------------------------------------------------
--33
-- Selecting specific columns from the vSalesPerson view
SELECT BusinessEntityID, LastName, TerritoryName, CountryRegionName  

-- From the Sales schema's vSalesPerson view
FROM Sales.vSalesPerson  

-- Filtering the results to include only rows where TerritoryName is not NULL
WHERE TerritoryName IS NOT NULL  

-- Ordering the results using a conditional CASE statement
-- If CountryRegionName is 'United States', order by TerritoryName
-- Otherwise, order by CountryRegionName
ORDER BY CASE CountryRegionName WHEN 'United States' THEN TerritoryName  
         ELSE CountryRegionName END ; 

---------------------------------------------------------------------------------------
--34
-- Selecting specific columns and calculated values
SELECT p.FirstName, p.LastName  
    -- Calculating row number for each row based on PostalCode order
    ,ROW_NUMBER() OVER (ORDER BY a.PostalCode) AS "Row Number"  
    -- Calculating rank for each row based on PostalCode order
    ,RANK() OVER (ORDER BY a.PostalCode) AS "Rank"  
    -- Calculating dense rank for each row based on PostalCode order
    ,DENSE_RANK() OVER (ORDER BY a.PostalCode) AS "Dense Rank"  
    -- Dividing the result set into quartiles based on PostalCode order
    ,NTILE(4) OVER (ORDER BY a.PostalCode) AS "Quartile"  
    -- Including sales YTD and PostalCode columns
    ,s.SalesYTD, a.PostalCode  
-- From the SalesPerson table alias s, joining with Person table alias p
FROM Sales.SalesPerson AS s   
     Inner JOIN Person.Person AS p   
        ON s.BusinessEntityID = p.BusinessEntityID  
    -- Joining with Address table alias a
     Inner JOIN Person.Address AS a   
        ON a.AddressID = p.BusinessEntityID  
-- Filtering the results to include only rows where TerritoryID is not NULL 
-- and SalesYTD is not equal to 0
WHERE TerritoryID IS NOT NULL AND SalesYTD <> 0;

---------------------------------------------------------------------------------------------

--35
Select *
From HumanResources.Department d
Order by name Offset 10 ROWS;
-----------------------------------------------------------------------------------------
--36
Select *
From HumanResources.Department d
Order by name 
	Offset 10 ROWS
	FETCH NEXT 5 ROWS ONLY;

--------------------------------------------------------------------------------------------
--37
Select p.Name, p.Color, p.ListPrice
From Production.Product p
--Where Color in ('red', 'blue')
Where Color = 'RED' OR Color = 'Blue'
Order by ListPrice DESC;


--------------------------------------------------------------------------------------------
--38
Select p.Name, s.SalesOrderID
From Production.Product p
Join Sales.SalesOrderDetail s 
on p.ProductID=s.SalesOrderID;

---------------------------------------------------------------------------------------------
--39









