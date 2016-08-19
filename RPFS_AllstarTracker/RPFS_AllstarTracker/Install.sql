use master
go
drop database RPFS_2K16Allstar
go
create database RPFS_2K16Allstar
go

use RPFS_2K16Allstar
go


--<DATABASE INSTALATIONS>--


CREATE TABLE tbTeams
(
teamId INT PRIMARY KEY IDENTITY(0,1),
teamName VARCHAR(50),
teamLocation VARCHAR(50)
)
INSERT INTO tbTeams (teamLocation, teamName) VALUES ('Chicago','Bulls'),('Memphis','Grizzlies'),('Atlanta','Hawks'),('Miami','Heat'),('Charlotte','Hornets'),('Utah','Jazz'),('Indiana','Pacers'),('Toronto','Raptors'),('Houston','Rockets'),('Minesota','TimberWolves')

CREATE TABLE tbUsers
(
userId INT PRIMARY KEY IDENTITY(0,1),
userFirstName VARCHAR(50),
userLastName VARCHAR(50),
userEmail VARCHAR(100),
userPassword VARCHAR(50),
userTeamId INT FOREIGN KEY REFERENCES tbTeams(teamId)
)
INSERT INTO tbUsers (userFirstName,userLastName,userEmail,userPassword,userTeamId) VALUES ('Chris','Jeffrey','c.jeffrey9999@gmail.com','123',0),
																						  ('Tyler','Renwick','Tyler@RPFS.TV','123',1),
																						  ('Garth','Coutu','Garth@RPFS.TV','123',2)

CREATE TABLE tbPositions
(
positionId INT PRIMARY KEY,
positionName varchar(50)
)
INSERT INTO tbPositions (positionId, positionName) VALUES (0,'Point Gaurd'),(1,'Shooting Gaurd'),(2,'Small Forward'),(3,'Power Forward'),(4,'Center')


--Player Id,Pick #,Team Id,Player Name,Position,Overall,Original Team
CREATE TABLE tbPlayers
(
playerId INT PRIMARY KEY IDENTITY(0,1),
playerDraftPick INT,
playerTeamId INT FOREIGN KEY REFERENCES tbTeams(teamId),
playerName VARCHAR(50),
playerPosition INT FOREIGN KEY REFERENCES tbPositions(positionId),
playerOverall INT,
playerOriginalTeam VARCHAR(50),
playerOfGameCount INT DEFAULT 0
)

CREATE TABLE tbPlayerVotes
(
userId INT FOREIGN KEY REFERENCES tbUsers(userId),
playerId INT FOREIGN KEY REFERENCES tbPlayers(playerId),
vote INT
)


BULK INSERT tbPlayers
FROM 'C:\Users\Chris\Desktop\Repositories\RPFS\RPFS_AllstarTracker\RPFS_AllstarTracker\NBA2K16Teams.csv'
WITH
(
	FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'   --Use to shift the control to next row
)



go
--</DATABASE INSTALLATIONS>--
--<STORED PROCEDURES>--

CREATE PROCEDURE spVote
(
@userId INT,
@playerId INT,
@vote INT
)
AS BEGIN
	IF (12 <= (SELECT COUNT(userId) FROM tbPlayerVotes WHERE userId = @userId))
	BEGIN
		SELECT 0
	END
	ELSE
	BEGIN
		INSERT INTO tbPlayerVotes (userId,playerId,vote) VALUES (@userId,@playerId,@vote)
		SELECT 1
	END
END
GO

CREATE PROCEDURE spLogin
(
@userEmail VARCHAR(100),
@userPassword VARCHAR(50)
)
AS BEGIN
	IF EXISTS(SELECT * FROM tbUsers WHERE userEmail = @userEmail AND userPassword = @userPassword)
	BEGIN
		SELECT userId FROM tbUsers WHERE userEmail = @userEmail AND userPassword = @userPassword
	END
	ELSE
	BEGIN
		SELECT -1
	END
END
GO

CREATE PROCEDURE spGetUser
(
@userId INT
)
AS BEGIN
	SELECT * 
	FROM tbUsers
	WHERE userId = @userId
END
GO

CREATE PROCEDURE spGetPlayers
AS BEGIN
	SELECT playerId, playerName, positionName, teamName, playerOfGameCount
	FROM tbPlayers INNER JOIN 
		 tbPositions ON positionId = playerPosition inner join
		 tbTeams ON teamId = playerTeamId
END
GO
--</STORED PROCEDURES>--
--<TESTING>--

--SELECT * FROM tbPlayerVotes

--IF EXISTS(SELECT * FROM tbUsers WHERE userEmail = 'Tyler@RPFS.TV' AND userPassword = '123')
--	BEGIN
--		SELECT userId FROM tbUsers WHERE userEmail = 'Tyler@RPFS.TV' AND userPassword = '123'
--	END
--	ELSE
--	BEGIN
--		SELECT '-1'
--	END

--select * from tbPlayers
--exec spGetPlayers
--</TESTING>--
