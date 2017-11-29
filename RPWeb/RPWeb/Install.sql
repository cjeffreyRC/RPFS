use master
go
drop database RPweb
go
create database RPweb
go
use RPweb
go


-------<TABLE DEFINITIONS>--------
CREATE TABLE tbUsers
(
userId INT PRIMARY KEY IDENTITY(0,1),
userFirstName VARCHAR(25),
userLastName VARCHAR(25),
userEmailAddress VARCHAR(100),
userFavoriteSport VARCHAR(25),
userPassword VARCHAR(50)
)
INSERT INTO tbUsers (userFirstName, userLastName, userEmailAddress, userFavoriteSport, userPassword) 
			VALUES  ('RPFS','Admin','admin@rpfs.com','All Sports','123'),
					('Chris','Jeffrey','c.jeffrey9999@gmail.com','Basketball','123'),
					('Bob','Barker','b.barker@gmail.com','Soccer','123')

CREATE TABLE tbSports
(
sportId INT PRIMARY KEY IDENTITY(0,1),
sportName VARCHAR(25)
)
INSERT INTO tbSports (sportName)
			VALUES	('Hockey'	 ),
					('Basketball'),
					('Football'	 ),
					('Baseball'	 ),
					('Soccer'	 ),
					('Wrestling' )
					

CREATE TABLE tbLeagueTypes
(
leagueTypeId INT PRIMARY KEY IDENTITY(0,1),
leagueType VARCHAR(25)
)
INSERT INTO tbLeagueTypes (leagueType) VALUES ('Season')
INSERT INTO tbLeagueTypes (leagueType) VALUES ('Season(Championship)')
INSERT INTO tbLeagueTypes (leagueType) VALUES ('Tournament')
INSERT INTO tbLeagueTypes (leagueType) VALUES ('Tournament(Championship)')

CREATE TABLE tbLeagues
(
leagueId INT PRIMARY KEY IDENTITY(0,1),
leagueTitle VARCHAR(50),
leagueTypeId INT FOREIGN KEY REFERENCES tbLeagueTypes(leagueTypeId),
leagueSportId INT FOREIGN KEY REFERENCES tbSports(sportId),
leagueDraftDate DATE
)
INSERT INTO tbLeagues (leagueTitle, leagueTypeId, leagueSportId)
			VALUES	('2008 Basketball Season(Championship)',3,0)

CREATE TABLE tbTeams
(
teamId INT PRIMARY KEY IDENTITY(0,1),
teamUserId INT FOREIGN KEY REFERENCES tbUsers(userId),
teamLeagueId INT FOREIGN KEY REFERENCES tbLeagues(leagueId),
teamName VARCHAR(50) DEFAULT('NEW TEAM'),
teamLocation VARCHAR(50) DEFAULT('N/A')
)
INSERT INTO tbTeams (teamUserId,teamLeagueId, teamName, teamLocation) VALUES (0,0,'Free Agency','N/A'),(1,0,'Raptors','Toronto'),(2,0,'Patriots','New England')

CREATE TABLE tbGames
(
gameId INT PRIMARY KEY IDENTITY(0,1),
homeTeamId INT FOREIGN KEY REFERENCES tbTeams(teamId),
awayTeamId INT FOREIGN KEY REFERENCES tbTeams(teamId),
leagueId INT FOREIGN KEY REFERENCES tbLeagues(leagueId),
isCompleted BIT
)

CREATE TABLE tbSportPositions
(
sportPositionId INT PRIMARY KEY IDENTITY(0,1),
sportId INT FOREIGN KEY REFERENCES tbSports(sportId),
positionName VARCHAR(50)
)
INSERT INTO tbSportPositions (sportId, positionName) VALUES (1, 'Point Gaurd'),
															(1, 'Shooting Gaurd'),
															(1, 'Small Forward'),
															(1, 'Power Forward'),
															(1, 'Center')

CREATE TABLE tbPlayers
(
playerId INT PRIMARY KEY IDENTITY(0,1),
playerName VARCHAR(50),
playerTeamId INT FOREIGN KEY REFERENCES tbTeams(teamId),
playerPositionId INT FOREIGN KEY REFERENCES tbSportPositions(sportPositionId),
playerOverall INT
)


--BULK INSERT tbPlayers
--FROM 'C:\Users\Chris\Desktop\Repositories\RPFS\RPWeb\RPWeb\Spreadsheets\test_basketball.csv'
--WITH
--(
--	FIRSTROW = 0,
--    FIELDTERMINATOR = ';',  --CSV field delimiter
--    ROWTERMINATOR = '\n'   --Use to shift the control to next row
--)

-------</TABLE DEFINITIONS>--------
GO

-------<STORED PROCEDURES>---------

---------------<USER>--------------
CREATE PROC spGetAllUsers
AS BEGIN
	SELECT userId as ID, userFirstName + ' ' + userLastName as Name
	FROM tbUsers
END
GO

CREATE PROC spGetUser
(
@userId INT
)
AS BEGIN
	IF EXISTS (SELECT userId FROM tbUsers WHERE userId = @userId)
	BEGIN
		SELECT userId as ID, userFirstName as 'First Name', userLastName as 'Last Name', userFavoriteSport as 'Favorite Sport'
		FROM tbUsers
		WHERE userId = @userId
	END
	ELSE BEGIN
		SELECT -1
	END
END
GO

CREATE PROC spAddUser
(
@userFirstName VARCHAR(25),
@userLastName VARCHAR(25),
@userEmailAddress VARCHAR(100),
@userFavoriteSport VARCHAR(25),
@userPassword VARCHAR(50)
)
AS BEGIN
	INSERT INTO tbUsers (userFirstName, userLastName, userEmailAddress, userFavoriteSport, userPassword)
				VALUES  (@userFirstName, @userLastName, @userEmailAddress, @userFavoriteSport, @userPassword)
	SELECT SCOPE_IDENTITY()
END
GO
---------------</USER>-------------
--------------<TEAMS>--------------
CREATE PROCEDURE spGetAllTeams
AS BEGIN
	SELECT teamId as 'ID', teamLocation as Location, teamName as Name, userFirstName + ' ' + userLastName as 'Owner', leagueTitle as League
	FROM tbTeams t INNER JOIN
		 tbUsers u on t.teamUserId = u.userId INNER JOIN
		 tbLeagues l on t.teamLeagueId = l.leagueId
END
GO

CREATE PROCEDURE spGetLeagueTeams
(
@leagueId INT
)
AS BEGIN
	SELECT teamId as 'ID', teamLocation as Location, teamName as Name, userFirstName + ' ' + userLastName as 'Owner', leagueTitle as League
	FROM tbTeams t INNER JOIN
		 tbUsers u on t.teamUserId = u.userId INNER JOIN
		 tbLeagues l on t.teamLeagueId = l.leagueId
	WHERE leagueId = @leagueId
END
GO

CREATE PROCEDURE spGetTeam
(
@teamId INT
)
AS BEGIN
	SELECT teamId as 'ID', teamLocation as Location, teamName as Name, userFirstName + ' ' + userLastName as 'Owner', leagueTitle as League
	FROM tbTeams t INNER JOIN
		 tbUsers u on t.teamUserId = u.userId INNER JOIN
		 tbLeagues l on t.teamLeagueId = l.leagueId
	WHERE t.teamId = @teamId
END
GO

CREATE PROCEDURE spAddTeam
(
@UserId INT,
@LeagueId INT,
@teamName VARCHAR(50) = 'New Team',
@teamLocation VARCHAR(50) = 'N/A'
)
AS BEGIN
	INSERT INTO tbTeams (teamUserId, teamLeagueId, teamLocation, teamName)
				VALUES  (@UserId, @LeagueId,@teamLocation, @teamName)
	SELECT SCOPE_IDENTITY()
END
GO
--------------</TEAMS>-------------
--------------<Leagues>------------
CREATE PROCEDURE spGetAllLeagues
AS BEGIN
	SELECT leagueId as ID, leagueTitle as Title, sportName as Sport, leagueType, leagueDraftDate as 'Draft Date'
	FROM tbLeagues l INNER JOIN
		 tbLeagueTypes lt on l.leagueId = lt.leagueTypeId INNER JOIN
		 tbSports s on l.leagueSportId = s.sportId
END
GO

CREATE PROCEDURE spAddLeague
(
@leagueTitle VARCHAR(50),
@leagueTypeId INT,
@leagueSportId INT,
@leagueDraftDate DATE
)
AS BEGIN
	INSERT INTO tbLeagues (leagueTitle, leagueTypeId, leagueSportId, leagueDraftDate)
				VALUES (@leagueTitle, @leagueTypeId, @leagueSportId, @leagueDraftDate)
	SELECT SCOPE_IDENTITY()
END
GO
--------------</Leagues>-----------
---------------<SPORTS>------------
CREATE PROCEDURE spGetAllSports
AS BEGIN
	SELECT sportId AS ID, sportName AS Name
	FROM tbSports
END
GO
---------------</SPORTS>-----------
----------------<TYPES>------------
CREATE PROCEDURE spGetAllLeagueTypes
AS BEGIN
	SELECT leagueTypeId as ID, leagueType as 'Type'
	FROM tbLeagueTypes
END
GO
----------------</TYPES>-----------
----------------<GAMES>------------
CREATE PROCEDURE spAddGame
(
@awayTeamId INT,
@homeTeamId INT,
@leagueId INT
)
AS BEGIN
	INSERT INTO tbGames (awayTeamId, homeTeamId, leagueId, isCompleted) VALUES (@awayTeamId, @homeTeamId, @leagueId, 0)
	SELECT SCOPE_IDENTITY()
END
GO
---------------</GAMES>------------
--------------<PLAYERS>------------
CREATE PROCEDURE spAddPlayer
(
@playerName VARCHAR(50),
@playerTeamId INT,
@playerPositionId INT,
@playerOverall INT
)
AS BEGIN
	INSERT INTO tbPlayers (playerName, playerTeamId, playerPositionId, playerOverall) VALUES
						 (@playerName,@playerTeamId,@playerPositionId, @playeroverall)
END
GO

CREATE PROCEDURE spGetTeamPlayers
(
@teamId INT 
)
AS BEGIN
	SELECT playerId as ID, playerName as Name, pos.positionName as Position, playerOverall as Overall
	FROM tbPlayers p INNER JOIN
		 tbTeams t on t.teamId = p.playerTeamId INNER JOIN
		 tbSportPositions pos on pos.sportPositionId = p.playerPositionId
	WHERE t.teamId = @teamId
END
GO

CREATE PROCEDURE spGetLeagueFreeAgencyId
(
@leagueId INT
)
AS BEGIN
	select MAX(teamId) as freeAgencyTeamId
	from tbTeams
	where teamLeagueId = @leagueId
END
GO
--------------</PLAYERS>-----------
-------</STORED PROCEDURES>--------

-----------<TESTING>---------------

--select * from tbUsers
--select * from tbSports
--select * from tbLeagues
--select * from tbLeagueTypes
--select * from tbTeams
--select * from tbGames
--select * from tbSportPositions
select pl.playerId, pl.playerName, po.positionName, t.teamName from tbPlayers pl inner join
			tbSportPositions po on pl.playerPositionId = po.sportPositionId inner join
			tbTeams t on pl.playerTeamId = t.teamId


/*
select teamName as Name, teamLocation as Location
from tbTeams inner join
	 tbUsers on tbTeams.teamUserId = tbUsers.userId
where teamLeagueId = 0
*/

-----------</TESTING>----------