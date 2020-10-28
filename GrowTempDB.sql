/*********************************************************
CAUTION:: DO NOT EVER RUN THIS IN A PRODUCTION DATABASE!
**********************************************************/

-- This script will purposly bloat tempDB causing it to grow

-- Create a TempTable to store all the data
USE [tempdb]



DBCC SHRINKFILE('tempdev',8)
DBCC SHRINKFILE('temp2',8)
DBCC SHRINKFILE('temp3',8)
DBCC SHRINKFILE('temp4',8)
DBCC SHRINKFILE('temp5',8)
DBCC SHRINKFILE('temp6',8)
DBCC SHRINKFILE('temp7',8)
DBCC SHRINKFILE('temp8',8)
DBCC SHRINKFILE('templog',8)
	

SET NOCOUNT ON;

CREATE TABLE #TmpNames
(
	FirstName VARCHAR(100),
	Lastname VARCHAR(100)
)

DECLARE @Threshold INT = 100 -- how many times it will loop


DECLARE @Counter INT = 1 -- Current iteration

WHILE  @Counter <= @Threshold
BEGIN
	INSERT INTO #TmpNames (FirstName)

	SELECT TOP 1000
	FirstName
	FROM HelloKitty.dbo.PersonNames

	UPDATE #TmpNames
	SET Lastname = p.Lastname
	FROM HelloKitty.dbo.PersonNames AS p
	WHERE p.FirstName IS NOT NULL

	RAISERROR('We are on pass number %i ',0,1,@Counter) WITH NOWAIT;

	SET @Counter = @Counter+1

END


--USE HelloKitty
--CREATE TABLE dbo.PersonNames
--(
--	PersonNameID INT IDENTITY(1,1),
--	FirstName NVARCHAR(100),
--	LastName NVARCHAR(100)
--)

--SELECT * FROM dbo.personnames

--DROP TABLE #TmpNames