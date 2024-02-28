IF OBJECT_ID(N'dbo.ClientSector', N'U') IS NULL
CREATE TABLE ClientSector (
    SectorID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50)
)

IF OBJECT_ID(N'dbo.Trades', N'U') IS NULL
CREATE TABLE Trades (
    TradeID UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    Value DECIMAL(18, 2),
    SectorID INT,
	FOREIGN KEY (SectorID) REFERENCES ClientSector(SectorID)
)

IF OBJECT_ID(N'dbo.TradeCategories', N'U') IS NULL
CREATE TABLE TradeCategories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    Category VARCHAR(50),
    MinValue DECIMAL(18, 2),
	MaxValue DECIMAL(18, 2),
    SectorID INT,
    FOREIGN KEY (SectorID) REFERENCES ClientSector(SectorID)
)

IF OBJECT_ID(N'dbo.CategorizedTrades', N'U') IS NULL
CREATE TABLE CategorizedTrades (
    TradeID UNIQUEIDENTIFIER,
    CategoryID INT,
    FOREIGN KEY (TradeID) REFERENCES Trades(TradeID),
    FOREIGN KEY (CategoryID) REFERENCES TradeCategories(CategoryID)
)
GO

MERGE INTO ClientSector WITH (holdlock) t  
USING (values ('Public')) s(Name) 
ON t.[Name] = s.[Name] 
WHEN not matched THEN INSERT values (s.Name);

MERGE INTO ClientSector WITH (holdlock) t  
USING (values ('Private')) s(Name) 
ON t.[Name] = s.[Name] 
WHEN not matched THEN INSERT values (s.Name);

MERGE INTO ClientSector WITH (holdlock) t  
USING (values ('Government')) s(Name) 
ON t.[Name] = s.[Name] 
WHEN not matched THEN INSERT values (s.Name);

DELETE FROM CategorizedTrades;


DELETE FROM Trades
INSERT INTO Trades (Value, SectorID) select 2000000, SectorID from ClientSector where Name ='Private'
INSERT INTO Trades (Value, SectorID) select 400000, SectorID from ClientSector where Name ='Public'
INSERT INTO Trades (Value, SectorID) select 500000, SectorID from ClientSector where Name ='Public'
INSERT INTO Trades (Value, SectorID) select 3000000, SectorID from ClientSector where Name ='Public'
INSERT INTO Trades (Value, SectorID) select 1500000, SectorID from ClientSector where Name ='Private'
INSERT INTO Trades (Value, SectorID) select 500, SectorID from ClientSector where Name ='Private'
INSERT INTO Trades (Value, SectorID) select 20000000, SectorID from ClientSector where Name ='Government'

DELETE FROM TradeCategories 
INSERT INTO TradeCategories (Category, MinValue, MaxValue, SectorID) select 'LOWRISK',null,1000000, SectorID from ClientSector where Name = 'Public'
INSERT INTO TradeCategories (Category, MinValue, MaxValue, SectorID) select 'MEDIUMRISK',1000000, null, SectorID from ClientSector where name = 'Public'
INSERT INTO TradeCategories (Category, MinValue, MaxValue, SectorID) select 'HIGHRISK', 1000000, null,SectorID from ClientSector where name = 'Private'


go



CREATE PROCEDURE dbo.CategorizeTrades
AS
    DELETE FROM CategorizedTrades;

    INSERT INTO CategorizedTrades (TradeID, CategoryID)
    SELECT 
	t.TradeID, 
	r.CategoryID
		FROM Trades t
		INNER JOIN ClientSector c on t.SectorID = c.SectorID
		LEFT JOIN TradeCategories r ON t.SectorID= r.SectorID AND
		(t.Value BETWEEN COALESCE(r.MinValue,t.Value) AND COALESCE(r.MaxValue,t.value) )

go

/*
CREATE PROCEDURE PrintCategorizedTrades
AS
BEGIN
    SELECT 
	t.TradeID, 
	t.Value, 
	c.Name, 
	COALESCE(r.Category,'UNCATEGORIZED')
	FROM Trades t
	INNER JOIN ClientSector c on t.SectorID = c.SectorID
	LEFT JOIN TradeCategories r ON t.SectorID= r.SectorID AND
	(t.Value BETWEEN COALESCE(r.MinValue,t.Value) AND COALESCE(r.MaxValue,t.value) )

END
go
*/

EXEC CategorizeTrades

SELECT * FROM CategorizedTrades
