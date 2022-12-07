/* Aggregate 1

Lowest Level Player

USE dndCharacterStorage;
SELECT MIN(ClassLevel) AS [Lowest Level]
FROM Characters;

USE dndCharacterStorage;
SELECT PlayerFirstName
FROM Player JOIN Characters ON Characters.PlayerID = Player.PlayerID
WHERE ClassLevel = 1;

Couldn't figure out how to get this last one to work
was trying to get all players that share the lowest level to display

USE dndCharacterStorage;
SELECT PlayerFirstName, ClassLevel
FROM Player JOIN Characters ON Characters.PlayerID = Player.PlayerID
GROUP BY PlayerFirstName, ClassLevel
HAVING ClassLevel = MIN(ClassLevel); */

/* Aggregate 2

Number of Fighters in the database

USE dndCharacterStorage;
SELECT COUNT(Characters.ClassID) AS [# of Fighters]
FROM Characters JOIN Class ON Class.ClassID = Characters.ClassID
WHERE ClassName = 'Fighter'; */

/* Aggregate 3

Highest Level Player

USE dndCharacterStorage;
SELECT MAX(ClassLevel) AS [Highest Level]
FROM Characters; */

/* Aggregate 4

Total level of all players in database

USE dndCharacterStorage;
SELECT SUM(ClassLevel) AS [Total Levels In Storage]
FROM Characters; */