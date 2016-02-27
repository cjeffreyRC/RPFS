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
positionSportId int foreign key references tbSports(sportId),
positionName varchar(10)
)
INSERT INTO tbPositions (positionSportId, positionName) VALUES (0,'C'),(0,'LW'),(0,'RW'),(0,'LD'),(0,'RD'),(0,'G'),
															   (1,'QB'),(1,'RB'),(1,'WR'),(1,'TE'),(1,'OL'),(1,'MLB'),(1,'LOLB'),(1,'ROLB'),(1,'CB'),(1,'S'),(1,'DL'),
															   (2,'PG'),(2,'SG'),(2,'SF'),(2,'PF'),(2,'C'),
															   (3,'CF'),(3,'LF'),(3,'RF'),(3,'1B'),(3,'2B'),(3,'SS'),(3,'3B'),(3,'BC'),(3,'SP'),(3,'RP')


CREATE TABLE tbLeagueTypes
(
leagueTypeId int primary key identity(0,1),
leagueType varchar(50)
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
teamLeagueId int foreign key references tbLeagues(leagueId) NOT NULL
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
--Getting all players from excel sheet and loading into players table
BULK
INSERT tbPlayers
FROM '~\Rosters\NHL16_PlayerList\forwards.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO
BULK
INSERT tbPlayers
FROM '~\Rosters\NHL16_PlayerList\defenders.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO
BULK
INSERT tbPlayers
FROM '~\Rosters\NHL16_PlayerList\goalies.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO



--</TABLES>
--<PROCEDURES>
CREATE PROCEDURE spGetAvailablePlayers
as begin
	select playerName,playerOriginalTeam,playerOverall,positionName,playerType,teamName
	from tbPlayers join
		 tbPositions on playerPosition = positionId join
		 tbTeams on teamId = playerTeam
	where playerTeam = 0
end
go

--</PROCEDURES>


select * from tbPlayers