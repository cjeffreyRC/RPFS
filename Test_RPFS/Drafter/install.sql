use master
go
drop database RPFS
go
create database RPFS
go
use RPFS
go
--<TABLES>
CREATE TABLE tbUsers
(
userId int primary key identity(0,1),
userFirstName varchar(50) NOT NULL,
userLastName varchar(50)NOT NULL,
userEmail varchar(100)NOT NULL,
userPassword varchar(50)NOT NULL,
isAdmin bit NOT NULL
)
INSERT INTO tbUsers (userFirstName, userLastName, userEmail, userPassword, isAdmin) VALUES 
					('','','','',0),
					('Chris','Jeffrey','chris.jeffrey@robertsoncollege.net','1234',1)

CREATE TABLE tbSports
(
sportId int primary key identity (0,1),
sportName varchar(50) NOT NULL
)
INSERT INTO tbSports (sportName) VALUES ('Hockey'),('Football'),('Basketball'),('Baseball')

CREATE TABLE tbPositions
(
positionId int primary key identity(0,1),
positionSportId int foreign key references tbSports(sportId) NOT NULL,
positionName varchar(10) NOT NULL
)
INSERT INTO tbPositions (positionSportId, positionName) VALUES (0,'C'),(0,'LW'),(0,'RW'),(0,'LD'),(0,'RD'),(0,'G'),
															   (1,'QB'),(1,'RB'),(1,'WR'),(1,'TE'),(1,'OL'),(1,'MLB'),(1,'LOLB'),(1,'ROLB'),(1,'CB'),(1,'S'),(1,'DL'),
															   (2,'PG'),(2,'SG'),(2,'SF'),(2,'PF'),(2,'C'),
															   (3,'CF'),(3,'LF'),(3,'RF'),(3,'1B'),(3,'2B'),(3,'SS'),(3,'3B'),(3,'BC'),(3,'SP'),(3,'RP')


CREATE TABLE tbLeagueTypes
(
leagueTypeId int primary key identity(0,1),
leagueType varchar(50) NOT NULL
)
INSERT INTO tbLeagueTypes (leagueType) VALUES ('Season'),('Tournament')

CREATE TABLE tbLeagues
(
leagueId int primary key identity(0,1),
leagueSport int foreign key references tbSports(sportId) NOT NULL,
leagueType int foreign key references tbLeagueTypes(leagueTypeId) NOT NULL,
isActive bit NOT NULL
)
INSERT INTO tbLeagues (leagueSport,leagueType,isActive) VALUES (0,1,1)

CREATE TABLE tbTeams
(
teamId int primary key identity(0,1),
teamName varchar(50)NOT NULL,
teamUserId int foreign key references tbUsers(userID) NOT NULL,
teamLeagueId int foreign key references tbLeagues(leagueId) NOT NULL,
isActive BIT DEFAULT 1
)
INSERT INTO tbTeams (teamName, teamUserId, teamLeagueId) VALUES ('FREE AGENCY',0,0)

CREATE TABLE tbPlayers
(
playerId int primary key,-- identity(0,1),
playerName varchar(50) NOT NULL,
playerOriginalTeam VARCHAR(50),
playerOverall int NOT NULL,
playerPosition int foreign key references tbPositions(positionId),
playerType varchar(10),
playerTeam int foreign key references tbTeams(teamId)
)

CREATE TABLE tbRooms
(
roomId INT PRIMARY KEY IDENTITY(0,1),
startDateTime DATETIME NOT NULL,
leagueId INT FOREIGN KEY REFERENCES tbLeagues(leagueId) NOT NULL,
isActive BIT DEFAULT 1
)



----REMOVING DUE TO AMBIGIOUS DATA 
-- tbTeams CONTAINS LEAGUEID AND tbRooms CONTAINS LEAGUEID 
-- tbRooms DOES NOT NEED TO BE RELATED TO tbTeams

--CREATE TABLE tbRoomTeams
--(
--teamId INT FOREIGN KEY REFERENCES tbUsers(userId) NOT NULL,
--roomId INT FOREIGN KEY REFERENCES tbRooms(roomId) NOT NULL,
--isActive BIT DEFAULT 1
--)


--COMMENTED OUT FOR CONVENIENCE 
-------DO NOT DELETE-------
--Getting all players from excel sheet and loading into players table
--BULK
--INSERT tbPlayers
--FROM 'C:\Users\robjx_000\Desktop\Repositories\RPFS\Test_RPFS\Drafter\Rosters\NHL16_PlayerList\forwards.csv' --'C:\Users\Chris\Desktop\Repositories\RPFS\Test_RPFS\Drafter\Rosters\NHL16_PlayerList\forwards.csv'
--WITH
--(
--FIELDTERMINATOR = ',',
--ROWTERMINATOR = '\n'
--)
--GO
--BULK
--INSERT tbPlayers
--FROM 'C:\Users\robjx_000\Desktop\Repositories\RPFS\Test_RPFS\Drafter\Rosters\NHL16_PlayerList\defenders.csv'--'C:\Users\Chris\Desktop\Repositories\RPFS\Test_RPFS\Drafter\Rosters\NHL16_PlayerList\defenders.csv'
--WITH
--(
--FIELDTERMINATOR = ',',
--ROWTERMINATOR = '\n'
--)
--GO
--BULK
--INSERT tbPlayers
--FROM 'C:\Users\robjx_000\Desktop\Repositories\RPFS\Test_RPFS\Drafter\Rosters\NHL16_PlayerList\goalies.csv'--'C:\Users\Chris\Desktop\Repositories\RPFS\Test_RPFS\Drafter\Rosters\NHL16_PlayerList\goalies.csv'
--WITH
--(
--FIELDTERMINATOR = ',',
--ROWTERMINATOR = '\n'
--)
GO



--</TABLES>
--<PROCEDURES>
CREATE PROCEDURE spGetLeagueTypes
AS BEGIN
	SELECT * FROM tbLeagueTypes
END
GO

CREATE PROCEDURE spCreateLeague
(
@leagueSportId INT,
@leagueTypeId INT
)
AS BEGIN
	INSERT INTO tbLeagues (leagueSport, leagueType, isActive) VALUES (@leagueSportId, @leagueTypeId,1)
END
GO

CREATE PROCEDURE spCreateTeam
(
@userId INT,
@leagueId INT
)
AS BEGIN
	INSERT INTO tbTeams (teamName, teamUserId, teamLeagueId) VALUES ((SELECT userFirstName FROM tbUsers WHERE userId = @userId)+ '''s team',@userId,@leagueId)
END
GO

CREATE PROCEDURE spCreateFreeAgency
(
@leagueId INT
)
AS BEGIN
	EXEC spCreateTeam 0, @leagueId
	UPDATE tbTeams SET 
			teamName = 'FREE AGENCY'+@leagueId
	WHERE teamId = SCOPE_IDENTITY()
END
GO

CREATE PROCEDURE spAddUserToLeague
(
@userId INT,
@roomId INT
)
AS BEGIN
	DECLARE @leagueId INT = (SELECT leagueId
						   FROM tbRooms
						   WHERE roomId = @roomId)
	EXEC spCreateTeam @userId, @leagueId
	--DECLARE @teamId INT = @@IDENTITY
	--INSERT INTO tbRoomTeams (teamId, roomId) VALUES (@teamId, @roomId)
END
GO

CREATE PROCEDURE spRemoveUserFromLeague
(
@userId INT,
@leagueId INT
)
AS BEGIN
	UPDATE tbTeams SET
			isActive = 0
		WHERE teamUserId = @userId
		AND teamLeagueId = @leagueId
END
GO

CREATE PROCEDURE spAddRoom
(
@startDateTime DATETIME,
@sportId INT,
@leagueTypeId INT
)
AS BEGIN
SET XACT_ABORT ON
	EXEC spCreateLeague @sportId, @leagueTypeId
	DECLARE @leagueId INT = @@IDENTITY
	EXEC spCreateFreeAgency @leagueId
	INSERT INTO tbRooms (startDateTime, leagueId, isActive) VALUES (@startDateTime, @leagueId, 1)
	SELECT SCOPE_IDENTITY()
END
GO

CREATE PROCEDURE spUpdateRoom
(
@roomId INT,
@sportId INT,
@leagueTypeId INT,
@startDateTime DATETIME
)
AS BEGIN
SET XACT_ABORT ON
	UPDATE tbRooms SET
			startDateTime = @startDateTime
	WHERE roomId = @roomId

	UPDATE tbLeagues SET
			leagueSport = @sportId,
			leagueType = @leagueTypeId
END
GO

CREATE PROCEDURE spCloseRoom
(
@roomId INT
)
AS BEGIN
	UPDATE tbRooms SET
			isActive = 0
	WHERE roomId = @roomId
END
GO

CREATE PROCEDURE spGetAvailablePlayers
as begin
	select playerName,
		   playerOriginalTeam,
		   playerOverall,
		   positionName,
		   playerType,
		   teamName
	from tbPlayers join
		 tbPositions on playerPosition = positionId join
		 tbTeams on teamId = playerTeam
	where playerTeam = 0
end
go

CREATE PROCEDURE spGetSports
AS BEGIN
	SELECT * FROM tbSports
END
GO

CREATE PROCEDURE spGetAllUsers
AS BEGIN
	SELECT userId,
		   userFirstName + ' ' + userLastName as username
	FROM   tbUsers
	WHERE  userId != 0
END
GO

CREATE PROCEDURE spGetLeagueUsers
(
@leagueId INT
)
AS BEGIN
	SELECT * 
	FROM tbTeams T JOIN
	tbUsers U ON T.teamUserId = U.userId
	WHERE teamLeagueId = @leagueId
END
GO

CREATE PROCEDURE spGetRooms
AS BEGIN
	SELECT R.roomId,
		   R.leagueId,
		   R.startDateTime,
		   S.sportName,
		   LT.leagueType
	FROM tbRooms R join 
		 tbLeagues L ON R.leagueId = L.leagueId JOIN
		 tbSports S ON L.leagueSport = S.sportId JOIN
		 tbLeagueTypes LT ON L.leagueType = LT.leagueTypeId
	WHERE R.isActive = 1
END
GO

CREATE PROCEDURE spGetLeagueAndRoom
(
@roomId INT 
)
AS BEGIN
	SELECT roomId,
		   startDateTime,
		   leagueSport as sportId,
		   leagueType as leagueTypeId
	FROM tbRooms R join
		 tbLeagues L on R.leagueId = L.leagueId
	WHERE roomId = @roomId
END
GO

CREATE PROCEDURE spGetLeagueUserIds
(
@roomId INT
)
AS BEGIN
	SELECT teamUserId as userId
	FROM tbTeams
	WHERE teamLeagueId = (SELECT leagueId
						  FROM tbRooms
						  WHERE roomId = @roomId)
END
GO

CREATE PROCEDURE spGetUsername
(
@userId INT
)
AS BEGIN
	SELECT userFirstName + ' ' + userLastname AS username
	FROM tbUsers
	WHERE userId = @userId
END
GO

--</PROCEDURES>

--<TESTING>
exec spGetAvailablePlayers
select * from tbPlayers
select * from tbTeams
select * from tbRooms
select * from tbLeagues
--select * from tbRoomTeams
--</TESTING>