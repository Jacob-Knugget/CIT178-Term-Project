/* Final Project Procedures

-- Retrieves and displays data
IF OBJECT_ID('spCharacters') IS NOT NULL
    DROP PROC spCharacters;
GO
USE dndCharacterStorage;
GO
CREATE PROC spCharacters
AS
SELECT CONCAT(PlayerFirstName,' ',PlayerLastName) AS PlayerName, ClassName
FROM Characters JOIN Player ON Player.PlayerID = Characters.PlayerID JOIN Class ON Class.ClassID = Characters.ClassID
ORDER BY PlayerName;
GO
EXEC spCharacters;

-- Takes an input parameter

IF OBJECT_ID('spGetCharacters') IS NOT NULL
    DROP PROC spGetCharacters;
GO
USE dndCharacterStorage;
GO
CREATE PROC spGetCharacters
	@ClassLevel int
AS
BEGIN
	SELECT CONCAT(PlayerFirstName,' ',PlayerLastName) AS PlayerName, ClassName
	FROM Characters JOIN Player ON Player.PlayerID = Characters.PlayerID JOIN Class ON Class.ClassID = Characters.ClassID
	WHERE ClassLevel = @ClassLevel;
END
GO
EXEC spGetCharacters 2;

-- Takes one input parameter and returns three output parameters

IF OBJECT_ID('spCharacterBackground') IS NOT NULL
    DROP PROC spCharacterBackground;
GO
USE dndCharacterStorage;
GO
CREATE PROC spCharacterBackground
	@CharacterID int,
	@FirstName nvarchar(30) OUTPUT,
	@LastName nvarchar(50) OUTPUT,
	@Background nvarchar(30) OUTPUT
AS
SELECT @FirstName = PlayerFirstName, @LastName = PlayerLastName, @Background = BackgrdName
FROM Characters JOIN Player ON Player.PlayerID = Characters.PlayerID JOIN Background ON Background.BackgrdID = Characters.BackgrdID
WHERE CharacterID = @CharacterID;
GO
DECLARE @FirstName nvarchar(30);
DECLARE @LastName nvarchar(50);
DECLARE @Background nvarchar(30);
EXEC spCharacterBackground 3, @FirstName OUTPUT, @LastName OUTPUT, @Background OUTPUT;
SELECT @FirstName AS 'First Name', @LastName AS 'Last Name', @Background AS 'Background';

USE dndCharacterStorage;
IF OBJECT_ID('spCharacterCount') IS NOT NULL
    DROP PROC spCharacterCount;
GO
CREATE PROC spCharacterCount
AS
DECLARE @CharacterCount int;
SELECT @CharacterCount = COUNT(*)
FROM Characters
RETURN @CharacterCount;
GO
DECLARE @CharacterCount int;
EXEC @CharacterCount = spCharacterCount;
PRINT 'There are ' + CONVERT(varchar, @CharacterCount) + ' characters in your database'; */

/* Final Project User Defined Functions

-- Creates the function

USE dndCharacterStorage;
IF OBJECT_ID('fnGetClass') IS NOT NULL
    DROP FUNCTION fnGetClass;
GO
CREATE FUNCTION fnGetClass
	(@ClassName nvarchar(50) = '%')
	RETURNS int
BEGIN
	RETURN (SELECT ClassID FROM Class WHERE ClassName LIKE @ClassName);
END;

-- Uses the function
GO
SELECT PlayerFirstName, ClassName FROM Characters JOIN Player ON Player.PlayerID = Characters.PlayerID JOIN Class ON Class.ClassID = Characters.ClassID
WHERE Characters.ClassID = dbo.fnGetClass('Fighter%')

USE dndCharacterStorage;
IF OBJECT_ID('fnCharacter') IS NOT NULL
    DROP FUNCTION fnCharacter;
GO
CREATE FUNCTION fnCharacter
	(@ClassName nvarchar(50) = '%')
	RETURNS table
RETURN
	(SELECT PlayerFirstName, RaceName, ClassName FROM Characters JOIN Player ON Player.PlayerID = Characters.PlayerID JOIN Race ON Race.RaceID = Characters.RaceID JOIN Class ON Class.ClassID = Characters.ClassID WHERE ClassName LIKE @ClassName);
GO
SELECT * FROM dbo.fnCharacter('Warlock'); */

/* Final Project Triggers

-- Create archive table by copying characters table without any rows
USE dndCharacterStorage;
IF OBJECT_ID('PlayerChange') IS NOT NULL
    DROP TABLE PlayerChange;
GO
SELECT * INTO PlayerChange
FROM Player
WHERE 1=0;

-- update CharacterCreation table and add activity column for status

ALTER TABLE PlayerChange
ADD Activity varchar(50);
GO

-- Create insert trigger
USE dndCharacterStorage;
IF OBJECT_ID('PlayerChange_INSERT') IS NOT NULL
    DROP TRIGGER PlayerChange_INSERT;
GO
CREATE TRIGGER PlayerChange_INSERT ON Player
	AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @PlayerID int
		DECLARE @PlayerFirstName nvarchar(30)
		DECLARE @PlayerLastName varchar(50)
	SELECT @PlayerID = INSERTED.PlayerID, @PlayerFirstName = INSERTED.PlayerFirstName, @PlayerLastName = INSERTED.PlayerLastName FROM INSERTED
	INSERT INTO PlayerChange VALUES (@PlayerID, @PlayerFirstName, @PlayerLastName, 'Inserted')
END
GO
-- Add row into characters to test insert trigger
INSERT INTO Player VALUES(6, 'Matthew', 'Holand');
GO
-- View data in characters archive
SELECT * FROM PlayerChange;
GO
-- Create delete trigger
USE dndCharacterStorage;
IF OBJECT_ID('PlayerChange_DELETE') IS NOT NULL
    DROP TRIGGER PlayerChange_DELETE;
GO
CREATE TRIGGER PlayerChange_DELETE ON Player
	AFTER DELETE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @PlayerID int
		DECLARE @PlayerFirstName nvarchar(30)
		DECLARE @PlayerLastName varchar(50)
	SELECT @PlayerID = DELETED.PlayerID, @PlayerFirstName = DELETED.PlayerFirstName, @PlayerLastName = DELETED.PlayerLastName FROM DELETED
	INSERT INTO PlayerChange VALUES (@PlayerID, @PlayerFirstName, @PlayerLastName, 'Deleted')
END
GO
-- Delete row from characters to test delete trigger

DELETE FROM Player WHERE PlayerID = 6;
GO

-- View data in customer archive

SELECT * FROM PlayerChange;
GO
--Create update trigger
USE dndCharacterStorage;
IF OBJECT_ID('PlayerChange_UPDATE') IS NOT NULL
    DROP TRIGGER PlayerChange_UPDATE;
GO
CREATE TRIGGER PlayerChange_UPDATE ON Player
	AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @PlayerID int
		DECLARE @PlayerFirstName nvarchar(30)
		DECLARE @PlayerLastName varchar(50)
	SELECT @PlayerID = INSERTED.PlayerID, @PlayerFirstName = INSERTED.PlayerFirstName, @PlayerLastName = INSERTED.PlayerLastName FROM INSERTED
	INSERT INTO PlayerChange VALUES (@PlayerID, @PlayerFirstName, @PlayerLastName, 'Updated')
END
GO
-- Insert a new row and then update the row (this will test the insert and update triggers)

INSERT INTO Player VALUES(6, 'Hodor', 'Stalliban');
GO
UPDATE Player
SET PlayerFirstName = 'Hodi'
WHERE PlayerID = 6;
GO
-- View data in customer archive
SELECT * FROM PlayerChange; */