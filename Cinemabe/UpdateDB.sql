ALTER TABLE ShowTime
DROP COLUMN DAY
--20/5
DROP TABLE [ShowTimeRoom] 
CREATE TABLE [ShowTimeRoom] (
	[ShowTimeId] uniqueidentifier NOT NULL,
	[RoomId] uniqueidentifier NOT NULL,
	CONSTRAINT PK_ShowTimeRoom PRIMARY KEY ([ShowTimeId], [RoomId]),
	CONSTRAINT FK_ShowTimeRoom_ShowTime FOREIGN KEY ([ShowTimeId]) REFERENCES [ShowTime] (Id),
	CONSTRAINT FK_ShowTimeRoom_Room FOREIGN KEY ([RoomId]) REFERENCES [Room] (Id),
)

DROP TABLE [MovieTypeDetail]
CREATE TABLE [MovieTypeDetail] (
	[MovieId] uniqueidentifier NOT NULL,
	[MovieTypeId] uniqueidentifier NOT NULL,
	CONSTRAINT PK_MovieTypeDetail PRIMARY KEY (MovieId, MovieTypeId),
	CONSTRAINT FK_MovieTypeDetail_Movie FOREIGN KEY ([MovieId]) REFERENCES [Movie] (Id),
	CONSTRAINT FK_MovieTypeDetail_MovieType FOREIGN KEY ([MovieTypeId]) REFERENCES [MovieType] (Id),
)

ALTER TABLE ShowTime
ADD ProjectionForm int NULL

ALTER TABLE Movie
DROP COLUMN Time

ALTER TABLE Movie
ADD Time2D int NULL

ALTER TABLE Movie
ADD Time3D int NULL

ALTER TABLE Seat
DROP CONSTRAINT FK_Seat_TicketType;

ALTER TABLE Seat
DROP COLUMN TicketTypeId;

IF OBJECT_ID('dbo.SeatType', 'U') IS NOT NULL
DROP TABLE dbo.SeatType;

CREATE TABLE [SeatType] (
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [Name] nvarchar(255) NOT NULL,
	[Status] bit NOT NULL,
	PRIMARY KEY (Id)
);

IF OBJECT_ID('dbo.TicketType', 'U') IS NOT NULL
DROP TABLE dbo.TicketType;

CREATE TABLE [TicketType] (
	[Id] uniqueidentifier NOT NULL,
	[Name] nvarchar(255) NOT NULL,
	[Status] bit NOT NULL,
	PRIMARY KEY (Id),
)

IF OBJECT_ID('dbo.SeatTypeTicketType', 'U') IS NOT NULL
DROP TABLE dbo.SeatTypeTicketType;

CREATE TABLE [SeatTypeTicketType] (
	[SeatTypeId] uniqueidentifier NOT NULL,
	[TicketTypeId] uniqueidentifier NOT NULL,
	[Price] float NOT NULL,
	CONSTRAINT PK_SeatTypeTicketType PRIMARY KEY ([SeatTypeId], [TicketTypeId]),
	CONSTRAINT FK_SeatTypeTicketType_SeatType FOREIGN KEY ([SeatTypeId]) REFERENCES [SeatType] (Id),
	CONSTRAINT FK_SeatTypeTicketType_TicketType FOREIGN KEY ([TicketTypeId]) REFERENCES [TicketType] (Id),
)

ALTER TABLE [Seat]
ADD [SeatTypeId] [uniqueidentifier] NULL;

ALTER TABLE [Seat]
ADD CONSTRAINT FK_Seat_SeatType
FOREIGN KEY (SeatTypeId) REFERENCES SeatType(Id);

ALTER TABLE Movie
DROP CONSTRAINT FK_Movie_ShowTimeType

ALTER TABLE Movie
DROP COLUMN ShowTimeTypeId

DROP TABLE ShowTimeType

ALTER TABLE AgeRestriction
ADD Abbreviation nvarchar(255) NULL

---------------------------------
ALTER TABLE FoodAndDrink
ADD TheaterId [uniqueidentifier] NULL,
CONSTRAINT FK_FoodAndDrink_Theater FOREIGN KEY (TheaterId) REFERENCES Theater(Id)

ALTER TABLE Theater
ADD Image nvarchar(255) NULL,
Phone nvarchar(255) NULL