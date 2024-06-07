use Cinema

--Delete data table
DELETE FROM MovieTypeDetail;
DELETE FROM MovieType;
DELETE FROM ShowTimeRoom;
DELETE FROM ShowTime;
DELETE FROM Seat;
DELETE FROM Movie;
DELETE FROM [User];
DELETE FROM UserType;
DELETE FROM AgeRestriction;
DELETE FROM Room;
DELETE FROM SeatTypeTicketType;
DELETE FROM TicketType;
DELETE FROM SeatType;
DELETE FROM Theater;
DELETE FROM FoodAndDrink;


DECLARE @NEW_GUID UNIQUEIDENTIFIER;



--theater
SET @NEW_GUID = NEWID();
INSERT Theater(Id, Name, Address, Image, Phone, Status) VALUES (@NEW_GUID, N'CKC Quận 1', N'65 Huỳnh Thúc Kháng, Phường Bến Nghé ,Quận 1,Thành Phố Hồ Chí Minh','ckc_quan1.jpg','02437654321',
1)
SET @NEW_GUID = NEWID();
INSERT Theater(Id, Name, Address, Image, Phone, Status) VALUES (@NEW_GUID, N'CKC Quận 3', N'Lầu 6 - 7,
19 Cao Thắng, P.2, Q.3, Tp. Hồ Chí Minh','ckc_quan3.jpg','02838456789',
1)
SET @NEW_GUID = NEWID();
INSERT Theater(Id, Name, Address, Image, Phone, Status) VALUES (@NEW_GUID, N'CKC Quận 10', N'116 Nguyễn Tri Phương, Q.10, Tp. Hồ Chí Minh','ckc_quan10.jpg','02363839999',
1)
SET @NEW_GUID = NEWID();
INSERT Theater(Id, Name, Address, Image, Phone, Status) VALUES (@NEW_GUID, N'CKC Quận 5', N'Tầng 7, Hùng Vương Plaza,
126 Hùng Vương, Q.5, Tp. Hồ Chí Minh','ckc_quan5.jpg','02253851234',
1)
SET @NEW_GUID = NEWID();
INSERT Theater(Id, Name, Address, Image, Phone, Status) VALUES (@NEW_GUID, N'CKC Quận 7', N'Lầu 4, Siêu Thị Vincom 3/2,
3C Đường 3/2, Q.7, Tp. Hồ Chí Minh','ckc_quan7.jpg','02923734567',
1)

--room
DECLARE @GUID_room1 UNIQUEIDENTIFIER;
DECLARE @GUID_room2 UNIQUEIDENTIFIER;
DECLARE @GUID_room3 UNIQUEIDENTIFIER;
DECLARE @GUID_room4 UNIQUEIDENTIFIER;
DECLARE @GUID_room5 UNIQUEIDENTIFIER;
DECLARE @GUID_room6 UNIQUEIDENTIFIER;
DECLARE @GUID_room7 UNIQUEIDENTIFIER;
DECLARE @GUID_room8 UNIQUEIDENTIFIER;
DECLARE @GUID_room9 UNIQUEIDENTIFIER;
DECLARE @GUID_room10 UNIQUEIDENTIFIER;

SET @GUID_room1 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room1, (select Id from Theater where Name=N'CKC Quận 1'), '01',1)
SET @GUID_room2 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room2, (select Id from Theater where Name=N'CKC Quận 1'), '02', 1)
SET @GUID_room3 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room3, (select Id from Theater where Name=N'CKC Quận 1'), '03', 1)
SET @GUID_room4 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room4, (select Id from Theater where Name=N'CKC Quận 1'), '04', 1)
SET @GUID_room5 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room5, (select Id from Theater where Name=N'CKC Quận 1'), '05', 1)

SET @GUID_room6 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room6, (select Id from Theater where Name=N'CKC Quận 5'), '01',1)
SET @GUID_room7 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room7, (select Id from Theater where Name=N'CKC Quận 5'), '02', 1)
SET @GUID_room8 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room8, (select Id from Theater where Name=N'CKC Quận 7'), '01', 1)
SET @GUID_room9 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room9, (select Id from Theater where Name=N'CKC Quận 7'), '02', 1)
SET @GUID_room10 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room10, (select Id from Theater where Name=N'CKC Quận 10'), '01', 1)

--age restriction
SET @NEW_GUID = NEWID();
INSERT INTO AgeRestriction(Id, Name, Description, Abbreviation, Status) 
VALUES (@NEW_GUID, 'P', N'Phim không giới hạn độ tuổi.', 'KID', 1);


SET @NEW_GUID = NEWID();
INSERT INTO AgeRestriction(Id, Name, Description, Abbreviation, Status) 
VALUES (@NEW_GUID, 'T13', N'Phim dành cho khán giả từ đủ 13 tuổi trở lên.', 'Teen', 1);


SET @NEW_GUID = NEWID();
INSERT INTO AgeRestriction(Id, Name, Description, Abbreviation, Status) 
VALUES (@NEW_GUID, 'T16', N'Phim dành cho khán giả từ đủ 16 tuổi trở lên.', 'Adult', 1);

SET @NEW_GUID = NEWID();
INSERT INTO AgeRestriction(Id, Name, Description, Abbreviation, Status) 
VALUES (@NEW_GUID, 'K', N'Phim dành cho mọi đối tượng, có hướng dẫn của phụ huynh.', 'KID', 1);

SET @NEW_GUID = NEWID();
INSERT INTO AgeRestriction(Id, Name, Description, Abbreviation, Status) 
VALUES (@NEW_GUID, 'T18', N'Phim dành cho khán giả từ đủ 18 tuổi trở lên.', 'Adult', 1);

--movie
DECLARE @GUID_movie1 UNIQUEIDENTIFIER;
DECLARE @GUID_movie2 UNIQUEIDENTIFIER;
DECLARE @GUID_movie3 UNIQUEIDENTIFIER;
DECLARE @GUID_movie4 UNIQUEIDENTIFIER;
DECLARE @GUID_movie5 UNIQUEIDENTIFIER;
DECLARE @GUID_movie6 UNIQUEIDENTIFIER;
DECLARE @GUID_movie7 UNIQUEIDENTIFIER;
DECLARE @GUID_movie8 UNIQUEIDENTIFIER;
DECLARE @GUID_movie9 UNIQUEIDENTIFIER;
DECLARE @GUID_movie10 UNIQUEIDENTIFIER;

-- Movie 1: GODZILLA X KONG
SET @GUID_movie1 = NEWID();
INSERT Movie(Id, AgeRestrictionId, Name, Image, Time2D, Time3D, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) 
VALUES (
    @GUID_movie1, 
    (SELECT Id FROM AgeRestriction WHERE Name='T13'), 
    N'GODZILLA X KONG', 
    'godzilla-x-kong.jpg', 
    125, 
    129, 
    '2021-03-24', 
    N'Kong và Godzilla - hai sinh vật vĩ đại huyền thoại, hai kẻ thủ truyền kiếp sẽ cùng bắt tay thực thi một sứ mệnh chung mang tính sống còn để bảo vệ nhân loại, và trận chiến gắn kết chúng với loài người mãi mãi sẽ bắt đầu.', 
    N'Adam Wingard', 
    N'Rebecca Hall, Dan Stevens, Rachel House', 
    N'qqrpMRDuPfc', 
    N'Tiếng việt', 
    1
);

-- Movie 2: AVATAR: THE WAY OF WATER
SET @GUID_movie2 = NEWID();
INSERT Movie(Id, AgeRestrictionId, Name, Image, Time2D, Time3D, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) 
VALUES (
    @GUID_movie2, 
    (SELECT Id FROM AgeRestriction WHERE Name='T13'), 
    N'AVATAR: THE WAY OF WATER', 
    'avatar-the-way-of-water.jpg', 
    190, 
    195, 
    '2022-12-16', 
    N'Jake Sully sống với gia đình mới được hình thành trên hành tinh Pandora. Khi một mối đe dọa quen thuộc quay trở lại để hoàn tất những gì đã bắt đầu trước đó, Jake phải hợp tác với Neytiri và đội quân người Navi để bảo vệ hành tinh của họ.', 
    N'James Cameron', 
    N'Sam Worthington, Zoe Saldana, Sigourney Weaver', 
    N'd9MyW72ELq0', 
    N'Tiếng việt', 
    1
);

-- Movie 3: DUNE
SET @GUID_movie3 = NEWID();
INSERT Movie(Id, AgeRestrictionId, Name, Image, Time2D, Time3D, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) 
VALUES (
    @GUID_movie3, 
    (SELECT Id FROM AgeRestriction WHERE Name='T16'), 
    N'DUNE', 
    'dune.jpg', 
    155, 
    160, 
    '2021-10-22', 
    N'Paul Atreides, một thanh niên tài năng với một số phận vĩ đại, phải du hành tới hành tinh nguy hiểm nhất trong vũ trụ để đảm bảo tương lai cho gia đình và người dân của mình.', 
    N'Denis Villeneuve', 
    N'Timothée Chalamet, Rebecca Ferguson, Zendaya', 
    N'n9xhJrPXop4', 
    N'Tiếng việt', 
    1
);

-- Movie 4: THE BATMAN
SET @GUID_movie4 = NEWID();
INSERT Movie(Id, AgeRestrictionId, Name, Image, Time2D, Time3D, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) 
VALUES (
    @GUID_movie4, 
    (SELECT Id FROM AgeRestriction WHERE Name='T16'), 
    N'THE BATMAN', 
    'the-batman.jpg', 
    175, 
    -1, 
    '2022-03-04', 
    N'Bruce Wayne/ Batman trong những năm đầu tiên của mình, phải đối mặt với một vụ án giết người hàng loạt, đồng thời đấu tranh với việc làm sáng tỏ danh tính của mình.', 
    N'Matt Reeves', 
    N'Robert Pattinson, Zoë Kravitz, Jeffrey Wright', 
    N'mqqft2x_Aa4', 
    N'Tiếng việt', 
    1
);

-- Movie 5: SPIDER-MAN: NO WAY HOME
SET @GUID_movie5 = NEWID();
INSERT Movie(Id, AgeRestrictionId, Name, Image, Time2D, Time3D, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) 
VALUES (
    @GUID_movie5, 
    (SELECT Id FROM AgeRestriction WHERE Name='T13'), 
    N'SPIDER-MAN: NO WAY HOME', 
    'spider-man-no-way-home.jpg', 
    148, 
    152, 
    '2021-12-17', 
    N'Peter Parker phải đối mặt với những hậu quả của việc tiết lộ danh tính Spider-Man của mình, đồng thời cố gắng ngăn chặn các kẻ thù từ các vũ trụ khác đổ bộ vào New York.', 
    N'Jon Watts', 
    N'Tom Holland, Zendaya, Benedict Cumberbatch', 
    N'JfVOs4VSpmA', 
    N'Tiếng việt', 
    1
);
-- Movie 1: INDIANA JONES AND THE DIAL OF DESTINY
SET @GUID_movie6 = NEWID();
INSERT Movie(Id, AgeRestrictionId, Name, Image, Time2D, Time3D, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) 
VALUES (
    @GUID_movie6, 
    (SELECT Id FROM AgeRestriction WHERE Name='T13'), 
    N'INDIANA JONES AND THE DIAL OF DESTINY', 
    'indiana-jones-and-the-dial-of-destiny.jpg', 
    154, 
    -1, 
    '2024-07-05', 
    N'Indiana Jones trở lại với một cuộc phiêu lưu mới đầy thử thách và nguy hiểm. Lần này, ông phải đối mặt với những bí ẩn của một vật phẩm cổ xưa có sức mạnh thay đổi số phận.', 
    N'James Mangold', 
    N'Harrison Ford, Phoebe Waller-Bridge, Mads Mikkelsen', 
    N'Lf-G6HgdjRs', 
    N'Tiếng việt', 
    1
);

-- Movie 2: MISSION: IMPOSSIBLE – DEAD RECKONING PART ONE
SET @GUID_movie7 = NEWID();
INSERT Movie(Id, AgeRestrictionId, Name, Image, Time2D, Time3D, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) 
VALUES (
    @GUID_movie7, 
    (SELECT Id FROM AgeRestriction WHERE Name='T16'), 
    N'MISSION: IMPOSSIBLE – DEAD RECKONING PART ONE', 
    'mission-impossible-dead-reckoning-part-one.jpg', 
    163, 
    -1, 
    '2024-07-14', 
    N'Ethan Hunt và đội IMF của anh phải đối mặt với mối đe dọa lớn nhất từ trước tới nay, với những âm mưu và phản bội trong một cuộc đua để cứu thế giới.', 
    N'Christopher McQuarrie', 
    N'Tom Cruise, Rebecca Ferguson, Simon Pegg', 
    N'AV4H04RmUbg', 
    N'Tiếng việt', 
    1
);

-- Movie 3: BLACK PANTHER: WAKANDA FOREVER
SET @GUID_movie8 = NEWID();
INSERT Movie(Id, AgeRestrictionId, Name, Image, Time2D, Time3D, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) 
VALUES (
    @GUID_movie8, 
    (SELECT Id FROM AgeRestriction WHERE Name='T13'), 
    N'BLACK PANTHER: WAKANDA FOREVER', 
    'black-panther-wakanda-forever.jpg', 
    161, 
    162, 
    '2024-11-10', 
    N'Wakanda phải chiến đấu để bảo vệ vương quốc của mình khỏi sự can thiệp của các thế lực bên ngoài sau cái chết của Vua T''Challa.', 
    N'Ryan Coogler', 
    N'Letitia Wright, Lupita Nyong''o, Danai Gurira', 
    N'RlOB3UALvrQ', 
    N'Tiếng việt', 
    1
);

-- Movie 4: THE FLASH
SET @GUID_movie9 = NEWID();
INSERT Movie(Id, AgeRestrictionId, Name, Image, Time2D, Time3D, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) 
VALUES (
    @GUID_movie9, 
    (SELECT Id FROM AgeRestriction WHERE Name='T13'), 
    N'THE FLASH', 
    'the-flash.jpg', 
    144, 
    144, 
    '2024-06-16', 
    N'Barry Allen sử dụng siêu tốc độ của mình để thay đổi quá khứ, nhưng lại tạo ra một dòng thời gian mới với những nguy cơ khôn lường.', 
    N'Andy Muschietti', 
    N'Ezra Miller, Michael Keaton, Sasha Calle', 
    N'hebWYacbdvc', 
    N'Tiếng việt', 
    1
);

-- Movie 5: JURASSIC WORLD: DOMINION
SET @GUID_movie10 = NEWID();
INSERT Movie(Id, AgeRestrictionId, Name, Image, Time2D, Time3D, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) 
VALUES (
    @GUID_movie10, 
    (SELECT Id FROM AgeRestriction WHERE Name='T13'), 
    N'JURASSIC WORLD: DOMINION', 
    'jurassic-world-dominion.jpg', 
    147, 
    -1, 
    '2024-06-10', 
    N'Một cuộc phiêu lưu đầy hồi hộp và nguy hiểm khi các loài khủng long thoát khỏi khu bảo tồn và sống tự do trong thế giới con người.', 
    N'Colin Trevorrow', 
    N'Chris Pratt, Bryce Dallas Howard, Sam Neill', 
    N'fb5ELWi-ekk', 
    N'Tiếng việt', 
    1
);
--movie type and details
DECLARE @GUID_movieType1 UNIQUEIDENTIFIER;
DECLARE @GUID_movieType2 UNIQUEIDENTIFIER;
DECLARE @GUID_movieType3 UNIQUEIDENTIFIER;
DECLARE @GUID_movieType4 UNIQUEIDENTIFIER;
DECLARE @GUID_movieType5 UNIQUEIDENTIFIER;
DECLARE @GUID_movieType6 UNIQUEIDENTIFIER;
DECLARE @GUID_movieType7 UNIQUEIDENTIFIER;
DECLARE @GUID_movieType8 UNIQUEIDENTIFIER;
DECLARE @GUID_movieType9 UNIQUEIDENTIFIER;


-- Insert các thể loại phim vào bảng MovieType với GUID riêng
set @GUID_movieType1 = NEWID();
set @GUID_movieType2 = NEWID();
set @GUID_movieType3 = NEWID();
set @GUID_movieType4 = NEWID();
set @GUID_movieType5 = NEWID();
set @GUID_movieType6 = NEWID();
set @GUID_movieType7 = NEWID();
set @GUID_movieType8 = NEWID();
set @GUID_movieType9 = NEWID();

INSERT MovieType(Id, Name, Status) VALUES (@GUID_movieType1, N'Hành động', 1);
INSERT MovieType(Id, Name, Status) VALUES (@GUID_movieType2, N'Khoa học viễn tưởng', 1);
INSERT MovieType(Id, Name, Status) VALUES (@GUID_movieType3, N'Phiêu lưu', 1);
INSERT MovieType(Id, Name, Status) VALUES (@GUID_movieType4, N'Tâm lý', 1);
INSERT MovieType(Id, Name, Status) VALUES (@GUID_movieType5, N'Giả tưởng', 1);
INSERT MovieType(Id, Name, Status) VALUES (@GUID_movieType6, N'Hình sự', 1);
INSERT MovieType(Id, Name, Status) VALUES (@GUID_movieType7, N'Kinh dị', 1);
INSERT MovieType(Id, Name, Status) VALUES (@GUID_movieType8, N'Hoạt hình', 1);
INSERT MovieType(Id, Name, Status) VALUES (@GUID_movieType9, N'Hài hước', 1);

-- Insert các MovieTypeDetail cho các phim tương ứng

-- GODZILLA X KONG
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie1, @GUID_movieType1);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie1, @GUID_movieType2);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie1, @GUID_movieType3);

-- AVATAR: THE WAY OF WATER
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie2, @GUID_movieType2);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie2, @GUID_movieType3);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie2, @GUID_movieType1);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie2, @GUID_movieType5);

-- DUNE
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie3, @GUID_movieType2);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie3, @GUID_movieType3);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie3, @GUID_movieType4);

-- THE BATMAN
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie4, @GUID_movieType1);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie4, @GUID_movieType6);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie4, @GUID_movieType4);

-- SPIDER-MAN: NO WAY HOME
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie5, @GUID_movieType1);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie5, @GUID_movieType3);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie5, @GUID_movieType5);

-- INDIANA JONES AND THE DIAL OF DESTINY
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie6, @GUID_movieType1);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie6, @GUID_movieType3);

-- MISSION: IMPOSSIBLE – DEAD RECKONING PART ONE
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie7, @GUID_movieType1);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie7, @GUID_movieType3);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie7, @GUID_movieType7);

-- BLACK PANTHER: WAKANDA FOREVER
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie8, @GUID_movieType1);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie8, @GUID_movieType5);

-- THE FLASH
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie9, @GUID_movieType1);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie9, @GUID_movieType2);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie9, @GUID_movieType5);

-- JURASSIC WORLD: DOMINION
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie10, @GUID_movieType1);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie10, @GUID_movieType3);
INSERT MovieTypeDetail(MovieId, MovieTypeId) VALUES (@GUID_movie10, @GUID_movieType5);


--showtime and showtime-room
--kong
--2d
SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID, @GUID_movie1,0, '2024-06-10T08:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room1);

SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID, @GUID_movie1,0, '2024-06-10T09:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room3);

--3d
SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID, @GUID_movie1,1, '2024-06-10T08:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room2);

--spider
--2d
SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie5,0, '2024-06-10T11:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room1);

--3d
SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie5,1, '2024-06-10T11:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room2);

SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie5,1, '2024-06-10T12:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room3);


--dune
--2d
SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie3,0, '2024-06-10T14:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room1);

SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie3,0, '2024-06-10T15:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room3);

--batman
--2d
SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie4,0, '2024-06-10T14:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room2);

--avatar
--3d
SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie2,0, '2024-06-10T18:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room3);

SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie2,0, '2024-06-10T17:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room1);

SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie2,0, '2024-06-10T21:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room3);

--ticket type
DECLARE @GUID_TicketType1 UNIQUEIDENTIFIER;
DECLARE @GUID_TicketType2 UNIQUEIDENTIFIER;


SET @GUID_TicketType1 = NEWID();
INSERT TicketType(Id, Name, Status) VALUES (@GUID_TicketType1, N'HSSV-Người Cao Tuổi', 1)
SET @GUID_TicketType2 = NEWID();
INSERT TicketType(Id, Name, Status) VALUES (@GUID_TicketType2,  N'Người lớn', 1)

--seat type
SET @NEW_GUID = NEWID();
INSERT SeatType(Id, Name, Status) VALUES (@NEW_GUID, N'Đơn', 1)
SET @NEW_GUID = NEWID();
INSERT SeatType(Id, Name, Status) VALUES (@NEW_GUID, N'Ðôi', 1)
SET @NEW_GUID = NEWID();
INSERT SeatType(Id, Name, Status) VALUES (@NEW_GUID, N'Nằm', 1)

SET @NEW_GUID = NEWID();
INSERT Seat(Id, RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@NEW_GUID, NULL, (select Id from Room where Name='01'), 'A', 1, NULL, 0)
SET @NEW_GUID = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID, NULL, (select Id from Room where Name='01'), 'A', 2, NULL, 0)

SET @NEW_GUID = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID, NULL, (select Id from Room where Name='02'), 'A', 1, NULL, 0)
SET @NEW_GUID = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID, NULL, (select Id from Room where Name='02'), 'A', 2, 'A1', 0)



SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='01'), 'A', 3, 'A1', 0)
SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='01'), 'A', 4, 'A2', 0)
SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='01'), 'A', 5, 'A3', 0)

SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='02'), 'A', 3, 'A2', 0)
SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='02'), 'A', 4, 'A3', 0)
SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='02'), 'A', 5, 'A4', 0)


SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='01'), 'B', 1, 'B1', 0)
SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='01'), 'B', 2, 'B2', 0)
SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='01'), 'B', 3, 'B3', 0)
SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='01'), 'B', 4, 'B4', 0)
SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='01'), 'B', 5, 'B5', 0)

SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='02'), 'B', 1, 'B1', 0)
SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='02'), 'B', 2, 'B2', 0)
SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='02'), 'B', 3, 'B3', 0)
SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='02'), 'B', 4, 'B4', 0)
SET @NEW_GUID1 = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='02'), 'B', 5, 'B5', 0)



SET @NEW_GUID = NEWID();
INSERT FoodAndDrink(Id, Name, Image, Price, Description, Status) VALUES (@NEW_GUID, N'Combo Solo 2 Ngăn - VOL', 'BAP-2-NGAN_COMBO-SOLO.png', 119000, N'1 Coke 32oz - V + 1 Bắp 2 Ngăn 64OZ PM + CARAMEN', 1)
SET @NEW_GUID = NEWID();
INSERT FoodAndDrink(Id, Name, Image, Price, Description, Status) VALUES (@NEW_GUID, N'Combo Party 2 Ngăn - VOL', 'BAP-2-NGAN_COMBO-PARTY.png', 259000, N'4 Coke 22oz - V + 2 Bắp 2 Ngăn 64OZ PM + CARAMEN', 1)
SET @NEW_GUID = NEWID();
INSERT FoodAndDrink(Id, Name, Image, Price, Description, Status) VALUES (@NEW_GUID, N'Combo Couple 2 Ngăn - VOL', 'BAP-2-NGAN_COMBO-COUPLE.png', 129000, N'2 Coke 32oz - V + 1 Bắp 2 Ngăn 64OZ PM + CARAMEN', 1)
