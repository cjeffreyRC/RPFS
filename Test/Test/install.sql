use master
go
drop database test
go
create database test
go
use test
go

CREATE TABLE tbUsers
(
username VARCHAR(50) PRIMARY KEY,
timeCreated DATETIME,
dateCreated DATETIME
)


CREATE TABLE tbMessages
(
username VARCHAR(50) FOREIGN KEY REFERENCES tbUsers(username),
message VARCHAR(500),
timeSent DATETIME
)

go
--Procedures

CREATE PROCEDURE spGetMessages
AS BEGIN
	SELECT M.username, message, timeSent
	FROM tbMessages M
END
GO

CREATE PROCEDURE spSaveMessage
(
@username VARCHAR(50),
@message VARCHAR(500)
)
AS BEGIN
	INSERT INTO tbMessages (username,message,timeSent) VALUES (@username,@message,CONVERT(TIME,GETDATE()))
END
GO

CREATE PROCEDURE spSaveUser
(
@username VARCHAR(50)
)
AS BEGIN
	INSERT INTO tbUsers (username, timeCreated, dateCreated) VALUES (@username,CONVERT(TIME,GETDATE()),CONVERT(DATE,GETDATE(),101))
END
GO

select * from tbUsers
exec spGetMessages