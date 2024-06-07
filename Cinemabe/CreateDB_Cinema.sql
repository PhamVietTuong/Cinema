Use [Cinema];

IF OBJECT_ID('dbo.MovieTypeDetail', 'U') IS NOT NULL
DROP TABLE dbo.MovieTypeDetail;

IF OBJECT_ID('dbo.InvoiceTicket', 'U') IS NOT NULL
DROP TABLE dbo.InvoiceTicket;

IF OBJECT_ID('dbo.InvoiceFoodAndDrink', 'U') IS NOT NULL
DROP TABLE dbo.InvoiceFoodAndDrink;

IF OBJECT_ID('dbo.Invoice', 'U') IS NOT NULL
DROP TABLE dbo.Invoice;

IF OBJECT_ID('dbo.ShowTimeRoom', 'U') IS NOT NULL
DROP TABLE dbo.ShowTimeRoom;

IF OBJECT_ID('dbo.ShowTime', 'U') IS NOT NULL
DROP TABLE dbo.ShowTime;

IF OBJECT_ID('dbo.Seat', 'U') IS NOT NULL
DROP TABLE dbo.Seat;

IF OBJECT_ID('dbo.Movie', 'U') IS NOT NULL
DROP TABLE dbo.Movie;

IF OBJECT_ID('dbo.User', 'U') IS NOT NULL
DROP TABLE dbo.[User];

IF OBJECT_ID('dbo.UserType', 'U') IS NOT NULL
DROP TABLE [dbo].[UserType];

IF OBJECT_ID('dbo.AgeRestriction', 'U') IS NOT NULL
DROP TABLE dbo.AgeRestriction;

IF OBJECT_ID('dbo.Room', 'U') IS NOT NULL
DROP TABLE dbo.Room;

IF OBJECT_ID('dbo.SeatTypeTicketType', 'U') IS NOT NULL
DROP TABLE dbo.SeatTypeTicketType;

IF OBJECT_ID('dbo.TicketType', 'U') IS NOT NULL
DROP TABLE dbo.TicketType;

IF OBJECT_ID('dbo.SeatType', 'U') IS NOT NULL
DROP TABLE dbo.SeatType;

IF OBJECT_ID('dbo.FoodAndDrinkTheater', 'U') IS NOT NULL
DROP TABLE dbo.FoodAndDrinkTheater;

IF OBJECT_ID('dbo.Theater', 'U') IS NOT NULL
DROP TABLE dbo.Theater;

IF OBJECT_ID('dbo.FoodAndDrink', 'U') IS NOT NULL
DROP TABLE dbo.FoodAndDrink;

IF OBJECT_ID('dbo.MovieType', 'U') IS NOT NULL
DROP TABLE dbo.MovieType;


CREATE TABLE [UserType] (
    [Id] uniqueidentifier NOT NULL,
    [Name] varchar(255) NOT NULL,
    PRIMARY KEY (Id)
)

CREATE TABLE [User] (
    [Id] uniqueidentifier NOT NULL,
	[UserTypeId] uniqueidentifier NOT NULL,
    [UserName] varchar(255) NOT NULL,
    [FullName] varchar(255) NOT NULL,
    [Email] varchar(255),
    [Phone] varchar(255),
	[BirthDay] datetime,
	[Gender] bit,
    [PasswordHash] varchar(512) NOT NULL,
    [PasswordSalt] varchar(128) NOT NULL,
    [Status] bit NOT NULL,
    PRIMARY KEY (Id),
	FOREIGN KEY (UserTypeId) REFERENCES UserType(Id)
);

CREATE TABLE [AgeRestriction] (
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [Name] nvarchar(255) NOT NULL,
	[Description] nvarchar(255) NOT NULL,
	[Abbreviation] nvarchar(255) NOT NULL,
	[Status] bit NOT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE [Movie] (
	[Id] uniqueidentifier NOT NULL,
	[AgeRestrictionId] uniqueidentifier NOT NULL,
	[Name] nvarchar(255) NOT NULL,
	[Image] nvarchar(255) NOT NULL,
	[Time2D] int NULL,
	[Time3D] int NULL,
	[ReleaseDate] datetime NOT NULL,
	[Description] nvarchar(max) NOT NULL,
	[Director] nvarchar(max) NOT NULL,
	[Actor] nvarchar(max) NOT NULL,
	[Trailer] nvarchar(255) NOT NULL,
	[Languages] nvarchar(255) NOT NULL,
	[Status] bit NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_Movie_AgeRestriction FOREIGN KEY ([AgeRestrictionId]) REFERENCES [AgeRestriction] (Id),
)

CREATE TABLE [Theater] (
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [Name] nvarchar(255) NOT NULL,
	[Address] nvarchar(255) NOT NULL,
	[Image] nvarchar(255) NOT NULL,
	[Phone] nvarchar(255)NOT NULL,
	[Status] bit NOT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE [Room] (
    [Id] UNIQUEIDENTIFIER NOT NULL,
	[TheaterId] uniqueidentifier NOT NULL,
    [Name] nvarchar(255) NOT NULL,
	[Status] bit NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_Room_Theater FOREIGN KEY ([TheaterId]) REFERENCES [Theater] (Id),
);

CREATE TABLE [SeatType] (
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [Name] nvarchar(255) NOT NULL,
	[Status] bit NOT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE [TicketType] (
	[Id] uniqueidentifier NOT NULL,
	[Name] nvarchar(255) NOT NULL,
	[Status] bit NOT NULL,
	PRIMARY KEY (Id),
)

CREATE TABLE [SeatTypeTicketType] (
	[SeatTypeId] uniqueidentifier NOT NULL,
	[TicketTypeId] uniqueidentifier NOT NULL,
	[Price] float NOT NULL,
	CONSTRAINT PK_SeatTypeTicketType PRIMARY KEY ([SeatTypeId], [TicketTypeId]),
	CONSTRAINT FK_SeatTypeTicketType_SeatType FOREIGN KEY ([SeatTypeId]) REFERENCES [SeatType] (Id),
	CONSTRAINT FK_SeatTypeTicketType_TicketType FOREIGN KEY ([TicketTypeId]) REFERENCES [TicketType] (Id),
)

CREATE TABLE [Seat] (
	[Id] uniqueidentifier NOT NULL,
	[RoomId] uniqueidentifier NOT NULL,
	[SeatTypeId] uniqueidentifier NULL,
	[Name] nvarchar(255) NULL,
	[ColIndex] int NOT NULL UNIQUE,
	[RowName] nvarchar(255) NOT NULL,
	[IsSeat] bit NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_Seat_Room FOREIGN KEY ([RoomId]) REFERENCES [Room] (Id),
	CONSTRAINT FK_Seat_SeatType FOREIGN KEY ([SeatTypeId]) REFERENCES SeatType(Id),
	CONSTRAINT UQ_Seat_RoomId_ColIndex_RowName UNIQUE (RoomId, ColIndex, RowName)
)

CREATE TABLE [ShowTime] (
	[Id] uniqueidentifier NOT NULL,
	[MovieId] uniqueidentifier NOT NULL,
	[ProjectionForm] int NOT NULL,
	[StartTime] datetime NOT NULL,
	[EndTime] datetime NOT NULL,
	[Status] bit NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_ShowTime_Movie FOREIGN KEY ([MovieId]) REFERENCES [Movie] (Id),
	CONSTRAINT UQ_ShowTime_MovieId_StartTime UNIQUE (MovieId, StartTime)
)

CREATE TABLE [ShowTimeRoom] (
	[ShowTimeId] uniqueidentifier NOT NULL,
	[RoomId] uniqueidentifier NOT NULL,
	CONSTRAINT PK_ShowTimeRoom PRIMARY KEY ([ShowTimeId], [RoomId]),
	CONSTRAINT FK_ShowTimeRoom_ShowTime FOREIGN KEY ([ShowTimeId]) REFERENCES [ShowTime] (Id),
	CONSTRAINT FK_ShowTimeRoom_Room FOREIGN KEY ([RoomId]) REFERENCES [Room] (Id),
)

CREATE TABLE [FoodAndDrink] (
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [Name] nvarchar(255) NOT NULL,
	[Description] nvarchar(255) NOT NULL,
	[Image] nvarchar(255) NOT NULL,
	[Status] bit NOT NULL,
	PRIMARY KEY (Id),
);

CREATE TABLE FoodAndDrinkTheater (
	[FoodAndDrinkId] uniqueidentifier NOT NULL,
	[TheaterId] uniqueidentifier NOT NULL,
	[Price] float NOT NULL,
	PRIMARY KEY ([FoodAndDrinkId], [TheaterId]),
	CONSTRAINT FK_FoodAndDrinkTheater_FoodAndDrink FOREIGN KEY ([FoodAndDrinkId]) REFERENCES [FoodAndDrink] (Id),
	CONSTRAINT FK_FoodAndDrinkTheater_Theater FOREIGN KEY ([TheaterId]) REFERENCES [Theater] (Id),
)

CREATE TABLE [Invoice] (
	Id uniqueidentifier NOT NULL,
	[UserId] uniqueidentifier NOT NULL,
	[Code] nvarchar(255)  NOT NULL,
	[CreationTime] datetime NOT NULL,
	PRIMARY KEY (Id),
	CONSTRAINT FK_Invoice_User FOREIGN KEY ([UserId]) REFERENCES [User] (Id),
)

CREATE TABLE [InvoiceTicket] (
	[InvoiceId] uniqueidentifier NOT NULL,
	[ShowTimeId] uniqueidentifier NOT NULL,
	[SeatId] uniqueidentifier NOT NULL,
	[TicketTypeId] uniqueidentifier NOT NULL,
	[Price] float NOT NULL,
	PRIMARY KEY ([InvoiceId], [ShowTimeId], [SeatId], [TicketTypeId]),
	CONSTRAINT FK_InvoiceTicket_Invoice FOREIGN KEY ([InvoiceId]) REFERENCES [Invoice] (Id),
	CONSTRAINT FK_InvoiceTicket_ShowTime FOREIGN KEY ([ShowTimeId]) REFERENCES [ShowTime] (Id),
	CONSTRAINT FK_InvoiceTicket_Seat FOREIGN KEY ([SeatId]) REFERENCES [Seat] (Id),
	CONSTRAINT FK_InvoiceTicket_TicketType FOREIGN KEY ([TicketTypeId]) REFERENCES [TicketType] (Id),
)

CREATE TABLE [InvoiceFoodAndDrink] (
	[InvoiceId] uniqueidentifier NOT NULL,
	[FoodAndDrinkId] uniqueidentifier NOT NULL,
	[Quantity] int NOT NULL,
	[Price] float NOT NULL,
	PRIMARY KEY ([InvoiceId], [FoodAndDrinkId]),
	CONSTRAINT FK_InvoiceFoodAndDrink_Invoice FOREIGN KEY ([InvoiceId]) REFERENCES [Invoice] (Id),
	CONSTRAINT FK_InvoiceFoodAndDrink_FoodAndDrink FOREIGN KEY ([FoodAndDrinkId]) REFERENCES [FoodAndDrink] (Id),
)

CREATE TABLE [MovieType] (
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [Name] nvarchar(255) NOT NULL,
	[Status] bit NOT NULL,
	PRIMARY KEY (Id)
);

CREATE TABLE [MovieTypeDetail] (
	[MovieId] uniqueidentifier NOT NULL,
	[MovieTypeId] uniqueidentifier NOT NULL,
	CONSTRAINT PK_MovieTypeDetail PRIMARY KEY (MovieId, MovieTypeId),
	CONSTRAINT FK_MovieTypeDetail_Movie FOREIGN KEY ([MovieId]) REFERENCES [Movie] (Id),
	CONSTRAINT FK_MovieTypeDetail_MovieType FOREIGN KEY ([MovieTypeId]) REFERENCES [MovieType] (Id),
)