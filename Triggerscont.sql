
--create table

CREATE TABLE dbo.Colors (
    ColorID int IDENTITY PRIMARY KEY,
    ColorName nvarchar(20)
);
GO

--create trigger to select everything from inserted, deleted table

CREATE TRIGGER dbo.TriggerTables
ON dbo.Colors
AFTER INSERT, UPDATE, DELETE
AS
SET NOCOUNT ON;
SELECT * FROM Inserted;
SELECT * FROM Deleted;
;
GO

--

INSERT INTO dbo.Colors (ColorName)
VALUES
    ('Red'), ('Green'), ('Blue')
;

--run update statement to see results--will show results

UPDATE dbo.Colors
SET ColorName = 'Yellow'
WHERE ColorID = 3;

DELETE FROM dbo.Colors
WHERE ColorID = 2;

SELECT * FROM dbo.Colors;

--create new table
CREATE TABLE dbo.NumberParity (
    RowID int IDENTITY PRIMARY KEY,
    MyNumber int,
    Parity nvarchar(20)
);
GO

--create new trigger to find if number is even or odd--won't find extra messages after insert
--

CREATE TRIGGER dbo.ParityTest
ON dbo.NumberParity
AFTER INSERT
AS
SET NOCOUNT ON;
UPDATE dbo.NumberParity
        SET Parity = 'Even Number'
        FROM inserted
        WHERE dbo.NumberParity.RowID = inserted.RowID AND
            inserted.MyNumber % 2 = 0;
UPDATE dbo.NumberParity
        SET Parity = 'Odd Number'
        FROM inserted
        WHERE dbo.NumberParity.RowID = inserted.RowID AND
            inserted.MyNumber % 2 <> 0;
;
GO



INSERT INTO dbo.NumberParity (MyNumber)
VALUES
    (12), (23), (16), (22), (43)
;

SELECT * FROM dbo.NumberParity;

INSERT INTO dbo.NumberParity (MyNumber, Parity)
VALUES
    (99, 'Even Number')
;

SELECT * FROM dbo.NumberParity;


