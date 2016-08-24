use master
go
drop database RPFS_2K16Allstar
go
create database RPFS_2K16Allstar
go

use RPFS_2K16Allstar
go


--<DATABASE INSTALATIONS>--
CREATE TABLE tbConferences
(
conferenceId INT PRIMARY KEY IDENTITY(0,1),
conferenceName VARCHAR(20)
)
INSERT INTO tbConferences (conferenceName) VALUES ('East'),('West')

CREATE TABLE tbTeams
(
teamId INT PRIMARY KEY IDENTITY(0,1),
teamName VARCHAR(50),
teamLocation VARCHAR(50),
teamConferenceId INT FOREIGN KEY REFERENCES tbConferences(conferenceId)
)
INSERT INTO tbTeams (teamLocation, teamName, teamConferenceId) VALUES ('Chicago','Bulls',0),('Memphis','Grizzlies',1),('Atlanta','Hawks',0),('Miami','Heat',0),('Charlotte','Hornets',0),('Utah','Jazz',1),('Indiana','Pacers',0),('Toronto','Raptors',0),('Houston','Rockets',1),('Minesota','TimberWolves',1),('Golden State','Warriors',1)

CREATE TABLE tbUsers
(
userId INT PRIMARY KEY IDENTITY(0,1),
userFirstName VARCHAR(50),
userLastName VARCHAR(50),
userEmail VARCHAR(100),
userPassword VARCHAR(50),
userTeamId INT FOREIGN KEY REFERENCES tbTeams(teamId)
)
INSERT INTO tbUsers (userFirstName,userLastName,userEmail,userPassword,userTeamId) VALUES ('Chris','Jeffrey','chris','123',6),
																						  ('Tyler','Renwick','Tyler','123',8),
																						  ('Garth','Coutu','Garth','123',1),
																						  ('Rob','Walluk','RobW','123',3),
																						  ('Rob','Jeffrey','RobJ','123',9),
																						  ('Trevor','Phaneuf','Trevor','123',0),
																						  ('Scott','Baxter','Scott','123',2),
																						  ('Kevin','Wittig','Kevin','123',5),
																						  ('Josh','Phillion','Josh','123',4),
																						  ('Ivan','Gagnon','Ivan','123',7),
																						  ('Alex','Harms','Alex','123',10)


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
FROM 'C:\Users\robjx_000\Desktop\Repositories\RPFS\RPFS_AllstarTracker\RPFS_AllstarTracker\NBA2K16Teams.csv'
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
	IF (24 <= (SELECT COUNT(userId) FROM tbPlayerVotes WHERE userId = @userId))
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
	SELECT pl.playerId, playerName, positionName, teamName, SUM(pv.vote) as points
	FROM tbPlayers pl INNER JOIN 
		 tbPositions po ON positionId = playerPosition inner join
		 tbTeams t ON teamId = playerTeamId full outer join
		 tbPlayerVotes pv on  pv.playerId = pl.playerId
	GROUP BY pl.playerId, pl.playerName, positionName, teamName
END
GO

CREATE PROCEDURE spGetPlayersByConferenceId
(
@conferenceId INT
)
AS BEGIN
	SELECT p.playerId, p.playerName, pos.positionName, t.teamName, SUM(pv.vote) as points
	FROM tbPlayers p INNER JOIN	
		 tbTeams t ON playerTeamId = teamId INNER JOIN
		 tbPositions pos ON positionId = p.playerPosition LEFT OUTER JOIN 
		 tbPlayerVotes pv ON pv.playerId = P.playerId
	WHERE teamConferenceId = @conferenceId
	GROUP BY  p.playerId, p.playerName, pos.positionName, t.teamName
END
GO


CREATE PROCEDURE spGetTeamName
(
@teamId INT
)
AS BEGIN
	SELECT teamName 
	FROM tbTeams
	WHERE teamId = @teamId
END
GO
--</STORED PROCEDURES>--
--<TESTING>--

--SELECT * FROM tbPlayerVotes
--SELECT * FROM tbPlayers
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
