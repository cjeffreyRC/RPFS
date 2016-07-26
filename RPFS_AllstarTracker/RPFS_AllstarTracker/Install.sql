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
INSERT INTO tbTeams (teamLocation, teamName) VALUES ('Indiana', 'Pacers'),('Houston', 'Rockets'),('Memphis','Grizlies')

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



go
--</DATABASE INSTALLATIONS>--
--<STORED PROCEDURES>--

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
		SELECT '-1'
	END
END
GO