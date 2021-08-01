/*CREATING AND MODIFYING A SAMPLE DATABASE WITH DDL COMMANDS (CREATE, DROP, ALTER) */

CREATE DATABASE EXAMPLE
USE EXAMPLE
GO
CREATE TABLE INFOS (
ID INT IDENTITY(1,1) NOT NULL,
NAMES VARCHAR(100) NOT NULL,
SURNAMES VARCHAR(100) NOT NULL
CONSTRAINT PK_ID
PRIMARY KEY(ID)
)
GO
INSERT INTO INFOS (NAMES, SURNAMES) VALUES ('NAME1', 'SURNAME1')
INSERT INTO INFOS (NAMES, SURNAMES) VALUES ('NAME2', 'SURNAME2')
INSERT INTO INFOS (NAMES, SURNAMES) VALUES ('NAME3', 'SURNAME3')
INSERT INTO INFOS (NAMES, SURNAMES) VALUES ('NAME4', 'SURNAME4')
INSERT INTO INFOS (NAMES, SURNAMES) VALUES ('NAME5', 'SURNAME5')
INSERT INTO INFOS (NAMES, SURNAMES) VALUES ('NAME6', 'SURNAME6')
GO
ALTER TABLE INFOS ADD USERNAME VARCHAR(50)
UPDATE INFOS SET USERNAME = 'USERNAME1' WHERE ID = 1
UPDATE INFOS SET USERNAME = 'USERNAME2' WHERE ID = 2
UPDATE INFOS SET USERNAME = 'USERNAME3' WHERE ID = 3
UPDATE INFOS SET USERNAME = 'USERNAME4' WHERE ID = 4
UPDATE INFOS SET USERNAME = 'USERNAME5' WHERE ID = 5
UPDATE INFOS SET USERNAME = 'USERNAME6' WHERE ID = 6
GO 
ALTER TABLE INFOS ADD PASSWORDS VARCHAR(50)
GO
UPDATE INFOS SET PASSWORDS = ''
GO 
ALTER TABLE INFOS ADD LASTCOLUMN VARCHAR(50)
GO
ALTER TABLE INFOS DROP COLUMN LASTCOLUMN

/*CHECKING THE STRUCTURE OF DATABASE*/

EXEC sp_helpdb EXAMPLE

/*CHANGE SIZE OF FILE */

ALTER DATABASE EXAMPLE
MODIFY FILE
(
NAME = EXAMPLE,
SIZE = 300 MB
);

/*BASIC DML (DATA MANIPULATION LANGUAGE) OPERATIONS */

USE EXAMPLE
GO
SELECT [ID]
      ,[NAMES]
      ,[SURNAMES]
      ,[USERNAME]
      ,[PASSWORDS]
FROM [EXAMPLE].[dbo].[INFOS]

UPDATE INFOS SET PASSWORDS = 'PASSWORD1' WHERE ID = 1

DELETE FROM INFOS WHERE PASSWORDS = 'PASSWORD1'

SELECT 10
SELECT 10 * 2
SELECT 100 * (10 / 2)

SELECT 'THE SUM OF' + '1 AND ' + 'IS 3'

/*BASIC VARIABLE OPERATIONS */

DECLARE @NAME VARCHAR(50)
SET @NAME = 'NAME1'
PRINT @NAME

DECLARE @NUM1 INT 
SET @NUM1 = 1
DECLARE @NUM2 INT
SET @NUM2 = 2
PRINT @NUM1 + @NUM2

/*SELECTING DIFFERENT RESULTS */

SELECT DISTINCT EmailPromotion FROM Person.Person
SELECT DISTINCT StateProvinceID FROM Person.Address

/* EXAMPLE FOR UNION STATEMENT */

SELECT FirstName, MiddleName, LastName FROM Person.Person
WHERE BusinessEntityID BETWEEN 1 AND 100
UNION 
SELECT FirstName, MiddleName, LastName FROM Person.Person
WHERE BusinessEntityID BETWEEN 101 AND 200

--BASIC QUERIES

/*Task: Connect to any restored database with the command USE*/

USE ETRADE2

/*Task: Check the version and the database name */

SELECT @@VERSION
SELECT DB_NAME()

/*Task: Check the username */

SELECT ORIGINAL_LOGIN(), CURRENT_USER, SYSTEM_USER

/*Task: Retrieve data from specific tables. */

SELECT ID, CITYNAME, POPULATION, REGION FROM CITIES

/*Task: Restrict query results to a subset of rows. */

SELECT * FROM CUSTOMERS WHERE ID BETWEEN 1 AND 20

/*Task: Use aliases when selecting specific columns from a table. */

SELECT ID IDS,
CITYNAME CTNAMES,
POPULATION CTPOPULATION
FROM CITIES

/*Task: Determine some conditions and retrieve data from a table using aliases and 
WHERE clause(s) */.

SELECT C.ID IDS, C.NAMESURNAME NS, C.GENDER G,
C.BIRTHDATE BT
FROM CUSTOMERS C WHERE C.NAMESURNAME LIKE '[ABC]%'

/*Task: Determine some conditions and retrieve data from a table using NOT clause(s). */

SELECT DISTINCT BRAND, AMOUNT FROM SALES 
WHERE NOT AMOUNT < 5

SELECT CONVERT(DATE, DATE_) DATES,
ITEMNAME, BRAND, AMOUNT, PRICE, CUSTOMERNAME, CITY, REGION
FROM SALES WHERE AMOUNT > 5 AND PRICE > 10 AND NOT REGION =  'MARMARA'
ORDER BY CONVERT(DATE, DATE_)

/*Task: Find the results between two dates in a column . */

SELECT * FROM CUSTOMERS WHERE BIRTHDATE BETWEEN '19950101' 
AND '20000101'

/*Task: Check if a column or columns in a table contain NULL values. */

SELECT NAMESURNAME, GENDER, CITY FROM CUSTOMERS
WHERE NAMESURNAME IS NULL OR GENDER IS NULL OR CITY IS NULL

/*Task: Use IN clause(s) with and without NOT clause(s) */

SELECT ID, CUSTOMERNAME, CITY, DISTRICT
FROM SALES WHERE CITY IN ('İstanbul', 'izmir', 'Ankara')

SELECT ID, CUSTOMERNAME, CITY, DISTRICT
FROM SALES WHERE CITY NOT IN ('İstanbul', 'izmir', 'Ankara')

/*Task: Select some columns and sort resuls in a specific order. */

SELECT CUSTOMERNAME, CONVERT(DATE, DATE_) DATES,
CITY, DISTRICT, REGION, ITEMNAME,
AMOUNT
FROM SALES
ORDER BY CUSTOMERNAME

/*Task: Retrieve data as a represantative sampling from a table. */

SELECT *
FROM SALES
TABLESAMPLE (10 PERCENT)

 
SELECT *
FROM SALES
TABLESAMPLE (10000 ROWS)

--BASIC T-SQL SCRIPTS AND CODES

/*Task: Execute a script to create a new database, add tables and insert values into it.*/

CREATE DATABASE EXAMPLE
USE EXAMPLE
GO
CREATE TABLE INFOS (
ID INT IDENTITY(1,1) NOT NULL,
USERS VARCHAR(60) NULL,
CONSTRAINT PK_ID
PRIMARY KEY(ID)
)
GO
INSERT INTO INFOS (USERS) VALUES ('USER1')
INSERT INTO INFOS (USERS) VALUES ('USER1')
INSERT INTO INFOS (USERS) VALUES ('USER1')
INSERT INTO INFOS (USERS) VALUES ('USER1')
INSERT INTO INFOS (USERS) VALUES ('USER1')
GO
ALTER TABLE INFOS ADD PASSWORDS VARCHAR(60)
GO
UPDATE INFOS SET PASSWORDS = '123A'

/*Task: Retrieve values from a table and put them into variables. */

DECLARE @DATE1 DATETIME
DECLARE @FICHENO1 VARCHAR(50)
DECLARE @CUSTOMERNAME1 VARCHAR(50)
SELECT @DATE1 = DATE_, @FICHENO1 = FICHENO,
@CUSTOMERNAME1 = CUSTOMERNAME 
FROM SALES WHERE ID = 1
SELECT @DATE1, @FICHENO1, @CUSTOMERNAME1

/*Task: Declare some variables and assign values to them. */

DECLARE @DATE1 DATETIME
DECLARE @NAME1 VARCHAR(50)
DECLARE @NAME2 VARCHAR(50)
SET @DATE1 = '20200101'
SET @NAME1 = 'Michelle'
SET @NAME2 = 'Ash'
SELECT @DATE1, @NAME1, @NAME2

/*Task: Write a simple IF-ELSE query */

DECLARE @VAR1 VARCHAR(10)= 'First'
IF @VAR1 = 'First'
BEGIN
SELECT TOP 50 PERCENT * FROM SALES
END
ELSE
BEGIN
SELECT * FROM SALES WHERE ID > 57512
END

/*Task: Check if a record exists in a subquery.*/

SELECT CITY
FROM CITIES
WHERE EXISTS (SELECT COUNTRY FROM COUNTRIES WHERE COUNTRIES.ID = CITIES.COUNTRYID
AND COUNTRY = 'FRANCE')

/*Task: Handle an error occured and ignore it. */

USE ETRADE4
GO
BEGIN TRY
ALTER TABLE COUNTRIES DROP PASSWORDS2 
END TRY
BEGIN CATCH
PRINT 'AN ERROR OCCURED'
END CATCH
GO
BEGIN TRY
SELECT * FROM USERS
END TRY
BEGIN CATCH
PRINT 'AN ERROR OCCURED'
END CATCH

/*Task: Write a simple  query.*/

SELECT ORDERID, AMOUNT,
CASE 
	WHEN AMOUNT <= 5 THEN 'Fewer rhan 5 orders.'
	ELSE 'More than 5 orders.'
END AS QUANTITYTEXT
FROM ORDERDETAILS

/*Task: Write a simple WHILE query. */

DECLARE @Counter INT 
SET @Counter=1
WHILE ( @Counter <= 10)
BEGIN
    PRINT 'The counter value is = ' + CONVERT(VARCHAR,@Counter)
    SET @Counter  = @Counter  + 1
END

/*Task: Write a WHILE loop, determine some conditions and break the loop 
when conditions are met. */

DECLARE @COUNTER INT
SET @COUNTER = 0
WHILE (@COUNTER < 10)
BEGIN
IF @COUNTER % 2 = 0
PRINT 'EVEN'
IF @COUNTER % 2 <> 0
PRINT 'ODD'
IF @COUNTER = 8
BREAK
SET @COUNTER = @COUNTER + 1
END

/*Task: Write a query that begins after 5 seconds. */

WAITFOR DELAY '00:00:05'
BEGIN
SELECT TOP 10 * FROM ITEMS
END

/*Task: Use the statement NULL with arithmetic operations */

SELECT NULL + 1
SELECT NULL - 1
SELECT NULL * 1
SELECT NULL / 1

/*Task: Create a database that contains null values. */

CREATE DATABASE NULLDB
USE NULLDB
GO
CREATE TABLE INFOS (
ID INT IDENTITY(1,1) NOT NULL,
USERS VARCHAR(60) NULL,
CONSTRAINT PK_ID
PRIMARY KEY(ID)
)
GO
INSERT INTO INFOS (USERS) VALUES ('USER1')
INSERT INTO INFOS (USERS) VALUES ('USER2')
INSERT INTO INFOS (USERS) VALUES (NULL)
INSERT INTO INFOS (USERS) VALUES ('USER4')
INSERT INTO INFOS (USERS) VALUES (NULL)
INSERT INTO INFOS (USERS) VALUES ('USER6')
INSERT INTO INFOS (USERS) VALUES ('USER7')
INSERT INTO INFOS (USERS) VALUES (NULL)
INSERT INTO INFOS (USERS) VALUES ('USER9')
INSERT INTO INFOS (USERS) VALUES (NULL)

/*Task: Get all the NULL values and replace them with alternatives */

USE NULLDB
SELECT ID, USERS,
USERSNONULLS = ISNULL(USERS, 'NO USER')
FROM INFOS

/*Task: Get the first non-NULL value. */

USE NULLDB
SELECT ID, USERS,
USERSNONULLS = COALESCE(USERS, 'NO USER')
FROM INFOS
ORDER BY USERSNONULLS DESC

/*Task: Select only the NULL values in a columns. */

USE NULLDB
SELECT ID, USERS
FROM INFOS
WHERE USERS IS NULL

/*Task: Write an INNER JOIN query. */

SELECT 
U.NAMESURNAME, SUM(OD.AMOUNT) ORDERAMOUNT
FROM USERS U
INNER JOIN ORDERS O ON U.ID = O.USERID 
INNER JOIN ORDERDETAILS OD ON O.ID = OD.ORDERID
GROUP BY U.NAMESURNAME
ORDER BY U.NAMESURNAME

/*Task: Write a LEFT JOIN and RIGHT JOIN query. */

SELECT 
U.USERNAME_, CONVERT(DATE, O.DATE_) DATES
FROM ORDERS O
LEFT JOIN USERS U ON O.USERID = U.ID
ORDER BY CONVERT(DATE, O.DATE_)

SELECT 
U.USERNAME_, CONVERT(DATE, O.DATE_) DATES
FROM ORDERS O
RIGHT JOIN USERS U ON O.USERID = U.ID
ORDER BY CONVERT(DATE, O.DATE_)

/*Task: Write a FULL JOIN query. */

SELECT 
A.USERID, CT.CITY, A.ADDRESSTEXT
FROM ADDRESS A
FULL JOIN CITIES CT ON A.CITYID = CT.ID

/*Task: Add a new column using the current values in your database. */

ALTER TABLE ORDERS ADD MONTHS VARCHAR(50)
UPDATE ORDERS SET MONTHS = '01.JANUARY' WHERE DATEPART(MONTH, CONVERT(DATE, ORDERS.DATE_)) = 1
UPDATE ORDERS SET MONTHS = '02.FEBRUARY' WHERE DATEPART(MONTH, CONVERT(DATE, ORDERS.DATE_)) = 2
UPDATE ORDERS SET MONTHS = '03.MARCH' WHERE DATEPART(MONTH, CONVERT(DATE, ORDERS.DATE_)) = 3
UPDATE ORDERS SET MONTHS = '04.APRIL' WHERE DATEPART(MONTH, CONVERT(DATE, ORDERS.DATE_)) = 4
UPDATE ORDERS SET MONTHS = '05.MAY' WHERE DATEPART(MONTH, CONVERT(DATE, ORDERS.DATE_)) = 5
UPDATE ORDERS SET MONTHS = '06.JUNE' WHERE DATEPART(MONTH, CONVERT(DATE, ORDERS.DATE_)) = 6
UPDATE ORDERS SET MONTHS = '07.JULY' WHERE DATEPART(MONTH, CONVERT(DATE, ORDERS.DATE_)) = 7
UPDATE ORDERS SET MONTHS = '08.AUGUST' WHERE DATEPART(MONTH, CONVERT(DATE, ORDERS.DATE_)) = 8
UPDATE ORDERS SET MONTHS = '09.SEPTEMBER' WHERE DATEPART(MONTH, CONVERT(DATE, ORDERS.DATE_)) = 9
UPDATE ORDERS SET MONTHS = '10.OCTOBER' WHERE DATEPART(MONTH, CONVERT(DATE, ORDERS.DATE_)) = 10
UPDATE ORDERS SET MONTHS = '11.NOVEMBER' WHERE DATEPART(MONTH, CONVERT(DATE, ORDERS.DATE_)) = 11
UPDATE ORDERS SET MONTHS = '12.DECEMBER' WHERE DATEPART(MONTH, CONVERT(DATE, ORDERS.DATE_)) = 12

/*Task: Use WHERE EXISTS clause with multiple tables. */

SELECT U.NAMESURNAME
FROM USERS U
WHERE EXISTS (SELECT TOTALPRICE FROM ORDERS O WHERE TOTALPRICE
BETWEEN 800 AND 1000 AND U.ID = O.USERID) 

/*Task: Use a UNION ALL query. */

SELECT USERNAME_, GENDER
FROM USERS WHERE GENDER = 'E'
UNION ALL
SELECT USERNAME_, GENDER
FROM USERS WHERE GENDER = 'K'

/*Task: Use a UNION query. */

SELECT USERNAME_, GENDER
FROM USERS WHERE GENDER = 'E' OR GENDER = 'K'
UNION 
SELECT USERNAME_, GENDER
FROM USERS WHERE GENDER = 'K' OR GENDER = 'K'

/*Task: Apply GROUP BY on a relational query. */

SELECT 
U.NAMESURNAME, ITM.CATEGORY1, SUM(OD.AMOUNT) TOTALAMOUNT
FROM ORDERS O
INNER JOIN USERS U ON U.ID = O.USERID
INNER JOIN ADDRESS A ON U.ID = A.USERID
INNER JOIN ORDERDETAILS OD ON OD.ORDERID = O.ID
INNER JOIN ITEMS ITM ON ITM.ID = OD.ITEMID
GROUP BY U.NAMESURNAME, ITM.CATEGORY1
HAVING SUM(OD.AMOUNT) > 200
ORDER BY TOTALAMOUNT DESC

/*Task: Analyze your database using Aggregate Functions. */

SELECT ITM.ITEMCODE ITEMCODE,
ITM.ITEMNAME ITEMNAME,
MIN(OD.UNITPRICE) MINIMUMPRICE,
MAX(OD.UNITPRICE) MAXIMUMPRICE,
AVG(OD.UNITPRICE) AVERAGEPRICE,
SUM(OD.AMOUNT) TOTALAMOUNT
FROM ORDERS O
INNER JOIN USERS U ON U.ID = O.USERID
INNER JOIN ADDRESS A ON A.ID = O.ADDRESSID
INNER JOIN CITIES CT ON CT.ID = A.CITYID
INNER JOIN TOWNS T ON T.ID = A.TOWNID
INNER JOIN DISTRICTS D ON D.ID = A.DISTRICTID
INNER JOIN PAYMENTS P ON P.ORDERID = O.ID
INNER JOIN INVOICES I ON I.ORDERID = O.ID
INNER JOIN ORDERDETAILS OD ON OD.ORDERID = O.ID
INNER JOIN ITEMS ITM ON ITM.ID = OD.ITEMID
GROUP BY ITM.ITEMCODE, ITM.ITEMNAME

/*Task: Avoid some duplicate values in a table. */

SELECT DISTINCT CATEGORY1
FROM ITEMS
ORDER BY CATEGORY1

/*Task: Concatenate two words separating them with SPACE Function*/

SELECT 'WORD1' + SPACE(8) + 'WORD2'

/*Task: Use NULLIF function */

SELECT TOP 20
NameStyle, EmailPromotion,
NULLIF(NameStyle, EmailPromotion) AS 'NameStyle/EmailPromotion NULLIF'
FROM Person.Person

/*Task: Get cartesian product of two columns with CROSS JOIN*/ 

SELECT PP.Name, PS.StateProvinceCode FROM Production.Product PP
CROSS JOIN Person.StateProvince PS

/*Task: Retrieve some datetime typed data from multiple tables. */

DECLARE @FirstDate DATETIME
SELECT @FirstDate = MIN(ModifiedDate)
FROM Person.Password
SELECT PP.FirstName, PP.LastName, PPAS.PasswordHash, PPAS.ModifiedDate
FROM Person.Person AS PP
JOIN Person.Password AS PPAS
ON PP.BusinessEntityID = PPAS.BusinessEntityID
WHERE PPAS.ModifiedDate = @FirstDate

/*Task: Retrieve data from multiple tables and add a subquery condition for it.*/

SELECT
HE.VacationHours,
PP.BusinessEntityID,
PP.FirstName, PP.LastName 
FROM HumanResources.Employee HE
INNER JOIN Person.Person PP ON
HE.BusinessEntityID = PP.BusinessEntityID
WHERE HE.VacationHours < 
(SELECT AVG(VacationHours) FROM HumanResources.Employee)
ORDER BY HE.VacationHours

/*Task: Build a CTE table */

WITH EMPLOYEE_INFO(EMPLOYEE_NAME, EMPLOYEE_SURNAME, EMPLOYEE_AGE) AS
(
SELECT PP.FirstName, PP.LastName, DATEDIFF(YEAR, HE.BirthDate, GETDATE())
FROM HumanResources.Employee HE 
INNER JOIN Person.Person PP
ON HE.BusinessEntityID = PP.BusinessEntityID
)
SELECT * FROM EMPLOYEE_INFO

/*Task: Order some rows using ROW_NUMBER() */

SELECT ROW_NUMBER() OVER(ORDER BY CustomerID) AS ROWNO,
CustomerID, StoreID, AccountNumber
FROM Sales.Customer

/*Task: Create a temporary table. */

SELECT CustomerID, StoreID, AccountNumber
INTO #Customers2
FROM Sales.Customer
SELECT * FROM #Customers2

/*Task: Update a column in a CTE table.*/

WITH New_SalesOrderDetail(SalesOrderID2, OrderQty2, ProductID2, UnitPrice2) AS
(
SELECT TOP 100 SalesOrderID, OrderQty, ProductID, UnitPrice
FROM Sales.SalesOrderDetail
)
UPDATE New_SalesOrderDetail
SET UnitPrice2 = UnitPrice2 * 1.05;

/*Task: Update a column in a temporary table.*/

SELECT TOP 100 SalesOrderID, OrderQty, ProductID, UnitPrice
INTO #TemporaryTable
FROM Sales.SalesOrderDetail
UPDATE #TemporaryTable
SET UnitPrice = UnitPrice * 1.05
SELECT * FROM #TemporaryTable

/*Task: Get only column names from a table. */

SELECT name FROM sys.columns 
WHERE object_id = OBJECT_ID('[AdventureWorks2014].[Sales].[SalesOrderHeader]') 

/*Task: Create a simple View that retrieves data from several relational tables. */

CREATE VIEW Vw_Infos
AS
SELECT PP.Name, SUM(SSOD.OrderQty) AS TotalQty, SUM(SSOD.OrderQty *  SSOD.UnitPrice) TotalPrice
FROM Production.Product AS PP
INNER JOIN Sales.SalesOrderDetail AS SSOD ON
PP.ProductID = SSOD.ProductID
INNER JOIN Sales.SalesOrderHeader AS SSOH
ON SSOD.SalesOrderID = SSOH.SalesOrderID
GROUP BY PP.Name

SELECT * FROM Vw_Infos

/*Task: List all Views in your database. */

SELECT SS.name AS SCHEMANAME,
SV.name AS VIEWNAME
FROM sys.views AS SV
INNER JOIN sys.schemas AS SS
ON SV.schema_id = SS.schema_id
ORDER BY SS.name, SV.name

/*Task: List columns in every Views. */

SELECT
SV.name AS VIEWNAME,
SC.name AS COLUMNNAME
FROM sys.columns AS SC
INNER JOIN sys.views AS SV
ON SC.object_id = SV.object_id
ORDER BY SV.name, SC.name

/*Task: Alter a part of the View you created. */

ALTER VIEW Vw_Infos
AS
SELECT PP.Name, SUM(SSOD.OrderQty) AS TotalQty, SUM(SSOD.OrderQty *  SSOD.UnitPrice * 4) TotalPrice
FROM Production.Product AS PP
INNER JOIN Sales.SalesOrderDetail AS SSOD ON
PP.ProductID = SSOD.ProductID
INNER JOIN Sales.SalesOrderHeader AS SSOH
ON SSOD.SalesOrderID = SSOH.SalesOrderID
GROUP BY PP.Name
WITH CHECK OPTION


/*Task: Remove one of the Views you created. */

DROP VIEW dbo.Vw_SummaryInfo


/*Task: Use an IF EXISTS statement in a query. */

IF EXISTS (SELECT ProductID, ProductNumber FROM Production.Product WHERE 
Name = 'WINDOWS')
BEGIN
PRINT 'PRODUCT IS IN THE LIST'
END
ELSE
BEGIN
PRINT 'PRODUCT IS NOT IN THE LIST'
END


/*Task: List the values of two columns in a table row-wise, using Cursor. */

DECLARE @BusinessEntityID INT
DECLARE @JobTitle VARCHAR(50)
DECLARE Cursor1 CURSOR FOR
SELECT BusinessEntityID, JobTitle FROM HumanResources.Employee
OPEN Cursor1
FETCH NEXT FROM Cursor1 INTO @BusinessEntityID, @JobTitle
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT CAST(@BusinessEntityID AS VARCHAR) + ' - ' + @JobTitle
	FETCH NEXT FROM Cursor1 INTO @BusinessEntityID, @JobTitle
END
CLOSE Cursor1
DEALLOCATE Cursor1


DECLARE Cursor1 CURSOR
GLOBAL
SCROLL
KEYSET
TYPE_WARNING
FOR
SELECT BusinessEntityID, JobTitle FROM HumanResources.Employee
DECLARE @BusinessEntityID INT
DECLARE @JobTitle VARCHAR(50)
OPEN Cursor1
FETCH NEXT FROM Cursor1 INTO @BusinessEntityID, @JobTitle
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT CAST(@BusinessEntityID AS VARCHAR) + ' - ' + @JobTitle
	FETCH NEXT FROM Cursor1 INTO @BusinessEntityID, @JobTitle
END
CLOSE Cursor1
DEALLOCATE Cursor1

/*Task: Create a simple Stored Procedure that gets top 100 rows from a table and then execute it. */

CREATE PROC sp_GetTop100
AS
SELECT TOP 100 * FROM 
Production.Product

EXEC sp_GetTop100

/*Task: Alter a Stored Procedure you created before. */
ALTER PROC sp_GetTop100
AS
SELECT TOP 100 * FROM
Production.Product
WHERE Color IS NOT NULL


/*Task: Create a Stored Procedure with an input parameter. */

CREATE PROC dbo.spGetPersonInfo
(@BusinessEntityID INT)
AS
SELECT
PP.FirstName, PP.LastName, HRE.NationalIDNumber,
HRE.JobTitle,
CASE 
	WHEN HRE.MaritalStatus = 'S' THEN 'Single'
	ELSE 'Married'
	END AS Marital_Status,
CASE
	WHEN HRE.Gender = 'M' THEN 'Male'
	ELSE 'Female'
	END AS GenderInfo,
DATEDIFF(YEAR, EDH.StartDate, GETDATE()) AS YearsInCompany,
HRD.Name, HRD.GroupName
FROM Person.Person AS PP
INNER JOIN HumanResources.Employee AS HRE
ON PP.BusinessEntityID = HRE.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory AS EDH
ON EDH.BusinessEntityID = PP.BusinessEntityID
INNER JOIN HumanResources.Department AS HRD 
ON HRD.DepartmentID = EDH.DepartmentID
WHERE EDH.EndDate IS NULL AND PP.BusinessEntityID = @BusinessEntityID

EXEC dbo.spGetPersonInfo 1


/*Task: Create a Stored Procedure with an output parameter. */

CREATE PROC spCalculator
(
@NUMBER1 INT,
@NUMBER2 INT,
@OPERATION SMALLINT,
@RESULT INT OUTPUT
)
AS
IF @OPERATION IS NOT NULL
IF(@OPERATION = 0)
SELECT @RESULT = (@NUMBER1 + @NUMBER2)
ELSE IF(@OPERATION = 1)
SELECT @RESULT = (@NUMBER1 - @NUMBER2)
ELSE IF(@OPERATION = 2)
SELECT @RESULT = (@NUMBER1 * @NUMBER2)
ELSE IF(@OPERATION = 3)
SELECT @RESULT = (@NUMBER1 / @NUMBER2)
ELSE
SELECT @RESULT = (0);


DECLARE @RESULT INT
EXEC spCalculator 20,10,0,@RESULT OUT
SELECT @RESULT

/*Task: Create a function that shows the names of months. */

CREATE FUNCTION DBO.MONTHNAME_(@DATE AS DATETIME)
RETURNS VARCHAR(10)
AS
BEGIN
DECLARE @RESULT AS VARCHAR(10)
IF DATEPART(MONTH, @DATE) ) = 1 SET @RESULT = '01.JANUARY'
IF DATEPART(MONTH, @DATE) )  = 2 SET @RESULT = '02.FEBRUARY'
IF DATEPART(MONTH, @DATE) ) = 3 SET @RESULT = '03.MARCH'
IF DATEPART(MONTH, @DATE) ) = 4 SET @RESULT = '04.APRIL'
IF DATEPART(MONTH, @DATE) ) = 5 SET @RESULT = '05.MAY'
IF DATEPART(MONTH, @DATE) ) = 6 SET @RESULT = '06.JUNE'
IF DATEPART(MONTH, @DATE) ) = 7 SET @RESULT = '07.JULY'
IF DATEPART(MONTH, @DATE) ) = 8 SET @RESULT = '08.AUGUST'
IF DATEPART(MONTH, @DATE) ) = 9 SET @RESULT = '09.SEPTEMBER'
IF DATEPART(MONTH, @DATE) ) = 10 SET @RESULT = '10.OCTOBER'
IF DATEPART(MONTH, @DATE) ) = 11 SET @RESULT = '11.NOVEMBER'
IF DATEPART(MONTH, @DATE) ) = 12 SET @RESULT = '12.DECEMBER'
RETURN @RESULT
END

/*Task: Create a simple transaction. */

BEGIN TRAN 

SELECT C.CUSTOMERNAME, A.ACCOUNTNO,
A.CURRENCY, B.BALANCE
FROM ACCOUNTBALANCE B
INNER JOIN ACCOUNTS A ON A.ID = B.ACCOUNTID
INNER JOIN CUSTOMERS C ON C.ID = A.CUSTOMERID

INSERT INTO MONEYTRANSACTIONS 
(ACCOUNTID, TRANTYPE, AMOUNT, DATE_, CURRENCY, EFTCODE1, EFTCODE2)
VALUES
(1, 2, 1000, '2020-04-14 14:21:36', 'USD', '12345678', '')

IF @@ERROR <> 0
BEGIN
	ROLLBACK TRAN
	RETURN
END

/*Task: Insert values into a table that has relations with other tables (so, create a trigger to do it)*/

CREATE TRIGGER trg_GetProduct
ON Production.Product
AFTER INSERT
AS
BEGIN
SELECT PL.ProductID, PL.Name, PL.ProductNumber
FROM Production.Product AS PL
INNER JOIN INSERTED AS I
ON PL.ProductID = I.ProductID;
END

INSERT INTO Production.Product
(Name, ProductNumber, MakeFlag, FinishedGoodsFlag, SafetyStockLevel, ReorderPoint, 
StandardCost,ListPrice,DaysToManufacture,SellStartDate,
rowguid, ModifiedDate)
VALUES(‘Test Product’,’SK-3334’, 1, 0, 500, 700, 0.00, 0.00, 3,
GETDATE(), NEWID(), GETDATE())
 

