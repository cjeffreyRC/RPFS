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
userId INT PRIMARY KEY IDENTITY(0,1),
username VARCHAR(50),
timeCreated DATETIME,
dateCreated DATETIME
)


CREATE TABLE tbMessages
(
userId INT FOREIGN KEY REFERENCES tbUsers(userId),
message VARCHAR(500),
timeSent DATETIME
)

go
--Procedures

CREATE PROCEDURE spGetUsernameAndSaveMessage
(
@userId INT,
@message VARCHAR(500)
)
AS BEGIN
	BEGIN TRANSACTION 
		BEGIN TRY
			INSERT INTO tbMessages (userId,message,timeSent) VALUES (@userId,@message,CONVERT(TIME,GETDATE()))

			SELECT username
			FROM tbUsers
			WHERE userId = @userId

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION 
			SELECT 0
		END CATCH
END
GO

CREATE PROCEDURE spGetMessages
AS BEGIN
	SELECT U.username, message, timeSent
	FROM tbMessages M join
		 tbUsers U on M.userId = U.userId
END
GO

CREATE PROCEDURE spSaveUser
(
@username VARCHAR(50)
)
AS BEGIN
	INSERT INTO tbUsers (username, timeCreated, dateCreated) VALUES (@username,CONVERT(TIME,GETDATE()),CONVERT(DATE,GETDATE(),101))
	SELECT SCOPE_IDENTITY()
END
GO

--DELETE FROM tbMessages
--DELETE FROM tbUsers
--select * from tbUsers
--exec spGetMessages
--select * from tbMessages
--exec spGetUsernameAndSaveMessage 0, 'hello'