-- build database
create database KimTable
go

-- select database
use KimTable
go

-- ========================================================================================================= --
-- ========================================================================================================= --
--                                            CREATION AREA
-- ========================================================================================================= --
-- ========================================================================================================= --

-- =================================================== --
-- Author: Kevin Muñoz
-- Date: 06/02/2020
-- Description: segurity table of user permits
--
-- Last Modified: xxxx xxxx
-- Last Date Modified: xx/xx/xxxx
-- Description of Modified: xxxx
-- =================================================== --
create table dbo.SEG_Permit
(
	intIdPermit int primary key identity not null,
	bitInsert bit not null,
	bitUpdate bit not null,
	bitDelete bit not null,
	bitDrop bit not null
);

print 'the table [SEG_Permit] was created.';
go

-- =================================================== --
-- Author: Kevin Muñoz
-- Date: 06/02/2020
-- Description: segurity table of user info
--
-- Last Modidied: xxxx xxxx
-- Last Date Modified: xx/xx/xxxx
-- Description of Modified: xxxx
-- =================================================== --
create table dbo.SEG_User
(
	intIdUser int primary key identity not null,
	charName nvarchar(20) not null,
	charPassword nvarchar(20) not null,
	bitDrop bit not null
);

print 'the table [SEG_User] was created.';
go

-- =================================================== --
-- Author: Kevin Muñoz
-- Date: 06/02/2020
-- Description: arquitecture table of boards
--
-- Last Modidied: xxxx xxxx
-- Last Date Modified: xx/xx/xxxx
-- Description of Modified: xxxx
-- =================================================== --
create table dbo.ARQ_Board
(
	intIdBoard int primary key identity not null,
	charName nvarchar(20) not null,
	bitDrop bit not null,
	intIdUser int foreign key references SEG_User(intIdUser) not null,
);

print 'the table [ARQ_Board] was created.';
go

-- =================================================== --
-- Author: Kevin Muñoz
-- Date: 06/02/2020
-- Description: arquitecture table of board columns
--
-- Last Modidied: xxxx xxxx
-- Last Date Modified: xx/xx/xxxx
-- Description of Modified: xxxx
-- =================================================== --
create table dbo.ARQ_Column
(
	intIdColumn int primary key identity not null,
	charName nvarchar(20) not null,
	bitDrop bit not null,
	intIdBoard int foreign key references ARQ_Board(intIdBoard) not null
);

print 'the table [ARQ_Column] was created.';
go

-- =================================================== --
-- Author: Kevin Muñoz
-- Date: 06/02/2020
-- Description: arquitecture table of task states
--
-- Last Modidied: xxxx xxxx
-- Last Date Modified: xx/xx/xxxx
-- Description of Modified: xxxx
-- =================================================== --
create table dbo.ARQ_State
(
	intIdState int primary key identity not null,
	charValue nvarchar(20) not null,
	bitDrop bit not null
);

print 'the table [ARQ_State] was created.';
go

-- =================================================== --
-- Author: Kevin Muñoz
-- Date: 06/02/2020
-- Description: arquitecture table of task prioritys
--
-- Last Modidied: xxxx xxxx
-- Last Date Modified: xx/xx/xxxx
-- Description of Modified: xxxx
-- =================================================== --
create table dbo.ARQ_Priority
(
	intIdPriority int primary key identity not null,
	charValue nvarchar(20) not null,
	bitDrop bit not null
);

print 'the table [ARQ_Priority] was created.';
go

-- =================================================== --
-- Author: Kevin Muñoz
-- Date: 06/02/2020
-- Description: arquitecture table of tasks
--
-- Last Modidied: xxxx xxxx
-- Last Date Modified: xx/xx/xxxx
-- Description of Modified: xxxx
-- =================================================== --
create table dbo.ARQ_Task
(
	intIdTask int primary key identity not null,
	charName nvarchar(30) null,
	charDescription nvarchar(300) null,
	bitPrimaryTask bit not null,
	bitDrop bit not null,
	intIdUser int foreign key references SEG_User(intIdUser) null,
	intIdState int foreign key references ARQ_State(intIdState) not null,
	intIdPriority int foreign key references ARQ_Priority(intIdPriority) not null,
	intIdColumn int foreign key references ARQ_Column(intIdColumn) not null
);

print 'the table [ARQ_Task] was created.';
go

-- =================================================== --
-- Author: Kevin Muñoz
-- Date: 06/02/2020
-- Description: arquitecture table of task Coments
--
-- Last Modidied: xxxx xxxx
-- Last Date Modified: xx/xx/xxxx
-- Description of Modified: xxxx
-- =================================================== --
create table dbo.ARQ_Coment
(
	intIdComent int primary key identity not null,
	charDescription nvarchar(300) null,
	bitDrop bit not null,
	intIdUser int foreign key references SEG_User(intIdUser) null,
	intIdTask int foreign key references ARQ_Task(intIdTask) not null
);

print 'the table [ARQ_Coment] was created.';
go

-- =================================================== --
-- Author: Kevin Muñoz
-- Date: 06/02/2020
-- Description: link table of sub tasks 
--
-- Last Modidied: xxxx xxxx
-- Last Date Modified: xx/xx/xxxx
-- Description of Modified: xxxx
-- =================================================== --
create table dbo.LIN_SubTask
(
	intIdSubTask int primary key identity not null,
	intIdPrimaryTask int foreign key references ARQ_Task(intIdTask) not null,
	intIdSecondTask int foreign key references ARQ_Task(intIdTask) not null
);

print 'the table [LIN_SubTask] was created.';
go

-- =================================================== --
-- Author: Kevin Muñoz
-- Date: 06/02/2020
-- Description: link table of user and permit for task
--
-- Last Modidied: xxxx xxxx
-- Last Date Modified: xx/xx/xxxx
-- Description of Modified: xxxx
-- =================================================== --
create table dbo.LIN_UserPermitForTask
(
	intIdUserPermitForTask int primary key identity not null,
	intIdUser int foreign key references SEG_User(intIdUser) not null,
	intIdPermit int foreign key references SEG_Permit(intIdPermit) not null,
	intIdTask int foreign key references ARQ_Task(intIdTask) not null,
)

print 'the table [LIN_UserPermitForTask] was created.';
go

-- =================================================== --
-- Author: Kevin Muñoz
-- Date: 06/02/2020
-- Description: link table of user and permit for board
--
-- Last Modidied: xxxx xxxx
-- Last Date Modified: xx/xx/xxxx
-- Description of Modified: xxxx
-- =================================================== --
create table dbo.LIN_UserPermitForBoard
(
	intIdUserPermitForBoard int primary key identity not null,
	intIdUser int foreign key references SEG_User(intIdUser) not null,
	intIdPermit int foreign key references SEG_Permit(intIdPermit) not null,
	intIdBoard int foreign key references ARQ_Board(intIdBoard) not null,
)

print 'the table [LIN_UserPermitForBoard] was created.';
go

-- ========================================================================================================= --
-- ========================================================================================================= --
--                                           DEFAUL INSERTS
-- ========================================================================================================= --
-- ========================================================================================================= --

insert into dbo.SEG_User(charName, charPassword, bitDrop) values ('ADM','1234', 0);
insert into dbo.SEG_Permit (bitInsert, bitUpdate, bitDelete, bitDrop) values (1, 1, 1, 0);
insert into dbo.SEG_Permit (bitInsert, bitUpdate, bitDelete, bitDrop) values (1, 1, 0, 0);
insert into dbo.ARQ_Board (charName, intIdUser, bitDrop) values ('Default Table', 1, 0);
insert into dbo.ARQ_Column (charName, intIdBoard, bitDrop) values ('Backlog', 1, 0);
insert into dbo.ARQ_Column (charName, intIdBoard, bitDrop) values ('In Progress', 1, 0);
insert into dbo.ARQ_Column (charName, intIdBoard, bitDrop) values ('Done', 1, 0);
insert into dbo.ARQ_State (charValue, bitDrop) values ('To Do', 0);
insert into dbo.ARQ_State (charValue, bitDrop) values ('Doing', 0);
insert into dbo.ARQ_State (charValue, bitDrop) values ('Bloked', 0);
insert into dbo.ARQ_State (charValue, bitDrop) values ('Done', 0);
insert into dbo.ARQ_Priority (charValue, bitDrop) values ('Low', 0);
insert into dbo.ARQ_Priority (charValue, bitDrop) values ('Medium', 0);
insert into dbo.ARQ_Priority (charValue, bitDrop) values ('High', 0);
insert into dbo.ARQ_Task (charName, charDescription, intIdColumn, intIdPriority, intIdState, intIdUser, bitPrimaryTask,bitDrop) values ('Example Task', 'write description..',  1, 1, 1, 1, 1, 0);
insert into dbo.ARQ_Task (charName, charDescription, intIdColumn, intIdPriority, intIdState, intIdUser, bitPrimaryTask,bitDrop) values ('Example SubTask', 'write description..', 1, 1, 1, 1, 0, 0);
insert into dbo.LIN_UserPermitForBoard (intIdBoard, intIdUser, intIdPermit) values (1, 1, 1);
insert into dbo.LIN_UserPermitForTask (intIdTask,intIdUser, intIdPermit) values (1, 1, 2);
insert into dbo.LIN_SubTask (intIdPrimaryTask,intIdSecondTask) values (1, 2);
