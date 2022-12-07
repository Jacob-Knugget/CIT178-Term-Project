/* Final Project Views */

/* USE dndCharacterStorage;
GO
CREATE VIEW firstPlayer (Player, Race, Class)
AS
SELECT PlayerFirstName + PlayerLastName, RaceName, ClassName
FROM Characters
JOIN Player ON Characters.PlayerID = Player.PlayerID 
JOIN Race ON Characters.RaceID = Race.RaceID
JOIN Class ON Characters.ClassID = Class.ClassID
WHERE CharacterID = 3;

CREATE VIEW sailors (Player, Background, Race, Class)
AS
SELECT PlayerFirstName + PlayerLastName, BackgrdName, RaceName, ClassName
FROM Characters
JOIN Player ON Characters.PlayerID = Player.PlayerID 
JOIN Race ON Characters.RaceID = Race.RaceID
JOIN Class ON Characters.ClassID = Class.ClassID
JOIN Background ON Characters.BackgrdID = Background.BackgrdID
WHERE BackgrdName = 'Sailor';

CREATE VIEW levelTwo (Player, [Level], Race, Class)
AS
SELECT PlayerFirstName + PlayerLastName, ClassLevel, RaceName, ClassName
FROM Characters
JOIN Player ON Characters.PlayerID = Player.PlayerID 
JOIN Race ON Characters.RaceID = Race.RaceID
JOIN Class ON Characters.ClassID = Class.ClassID
WHERE ClassLevel = 2;

CREATE VIEW fighters (Player, [Level], Race, Class)
AS
SELECT PlayerFirstName + PlayerLastName, ClassLevel, RaceName, ClassName
FROM Characters
JOIN Player ON Characters.PlayerID = Player.PlayerID 
JOIN Race ON Characters.RaceID = Race.RaceID
JOIN Class ON Characters.ClassID = Class.ClassID
WHERE ClassName = 'Fighter';

UPDATE sailors
SET Class = 'Warlock'
WHERE Player = 'RonaldMasin'; */