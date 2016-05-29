use master
go
drop database dbSurvey
go
create database dbSurvey
go
use dbSurvey
go

create table tbAutoDraft
(
value int primary key identity(0,1),
selection varchar(500)
)
insert into tbAutoDraft (selection) values ('By Highest Rated Player')
insert into tbAutoDraft (selection) values ('By Highest Rated Player At Most Picked Position This Round')
insert into tbAutoDraft (selection) values ('By Team Needs')
insert into tbAutoDraft (selection) values ('By Choice(Everyone gets to pick their own autodraft functionality - Can change it every round if you''d like')

create table tbChat
(
value int primary key identity(0,1),
selection varchar(500)
)
insert into tbChat (selection) values ('Yes')
insert into tbChat (selection) values ('No')

create table tbValues
(
firstName varchar(50),
lastName varchar(50),
pickTrades int,
playerTrades int,
playerPickTrades int,
multiTeamTrades int,
dragNDrop int,
autoDraft int foreign key references tbAutoDraft(value),
chat int foreign key references tbChat(value),
comment varchar(1000)
)

go

create procedure spGetAutoDraftRBL
as begin
	select * from tbAutoDraft
end
go

create procedure spGetChatRBL
as begin
	select * from tbChat
end
go

create procedure spSave
(
@firstName varchar(50),
@lastName varchar(50),
@pickTrades int,
@playerTrades int,
@playerPickTrades int,
@multiTeamTrades int,
@dragNDrop int,
@autoDraft int,
@chat int,
@comment varchar(1000)
)
as begin
	insert into tbValues (firstName,lastName,pickTrades,playerTrades,playerPickTrades,multiTeamTrades,dragNDrop,autoDraft,chat,comment) values 
						(@firstName,@lastName,@pickTrades,@playerTrades,@playerPickTrades,@multiTeamTrades,@dragNDrop,@autoDraft,@chat,@comment)
end
go

create procedure spGetTotalValueAVGS
as begin
	select  SUM(pickTrades)/COUNT(pickTrades) as 'Pick Trade Percentage',
			SUM(playerTrades)/COUNT(playerTrades) as 'Player Trade Percentage',
			SUM(playerPickTrades)/COUNT(playerPickTrades) as 'Player for Pick Trade Percentage',
			SUM(multiTeamTrades)/COUNT(multiTeamTrades) as 'Multi-Team Trade Percentage',
			SUM(dragNDrop)/COUNT(dragNDrop) as 'Drag and Drop Percentage',
			(select COUNT(autoDraft) from tbValues where autoDraft=0) as 'Votes By Highest Rated Player',
			(select COUNT(autoDraft) from tbValues where autoDraft=1) as 'Votes By Highest Rated Player At Most Picked Position This Round',
			(select COUNT(autoDraft) from tbValues where autoDraft=2) as 'Votes By Team Needs',
			(select COUNT(autoDraft) from tbValues where autoDraft=3) as 'Votes By Choice',
			(select COUNT(chat) from tbValues where chat=0) as 'Votes for chat',
			(select COUNT(chat) from tbValues where chat=1) as 'Votes against chat'
	from tbValues
end
go

create procedure spGetTotalValues
as begin
	Select firstName,lastName,pickTrades,playerTrades,playerPickTrades,multiTeamTrades,dragNDrop,autoDraft,chat,comment from tbValues V join
				  tbAutoDraft A on V.autoDraft = A.value join
				  tbChat C on V.chat = C.value
end
go

create procedure spGetCount
as begin
	select COUNT(firstName) as count from tbValues
end
go