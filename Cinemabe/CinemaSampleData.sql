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
DELETE FROM FoodAndDrinkTheater;
DELETE FROM Theater;
DELETE FROM FoodAndDrink;


DECLARE @NEW_GUID UNIQUEIDENTIFIER;

DECLARE @GUID_theater1 UNIQUEIDENTIFIER;
DECLARE @GUID_theater2 UNIQUEIDENTIFIER;
DECLARE @GUID_theater3 UNIQUEIDENTIFIER;
DECLARE @GUID_theater4 UNIQUEIDENTIFIER;
DECLARE @GUID_theater5 UNIQUEIDENTIFIER;

--theater
SET @GUID_theater1 = NEWID();
INSERT Theater(Id, Name, Address, Image, Phone, Status) VALUES (@GUID_theater1, N'CKC Quận 1', N'65 Huỳnh Thúc Kháng, Phường Bến Nghé ,Quận 1,Thành Phố Hồ Chí Minh','ckc_quan1.jpg','02437654321',
1)
SET @GUID_theater2 = NEWID();
INSERT Theater(Id, Name, Address, Image, Phone, Status) VALUES (@GUID_theater2, N'CKC Quận 3', N'Lầu 6 - 7,
19 Cao Thắng, P.2, Q.3, Tp. Hồ Chí Minh','ckc_quan3.jpg','02838456789',
1)
SET @GUID_theater3 = NEWID();
INSERT Theater(Id, Name, Address, Image, Phone, Status) VALUES (@GUID_theater3, N'CKC Quận 10', N'116 Nguyễn Tri Phương, Q.10, Tp. Hồ Chí Minh','ckc_quan10.jpg','02363839999',
1)
SET @GUID_theater4 = NEWID();
INSERT Theater(Id, Name, Address, Image, Phone, Status) VALUES (@GUID_theater4, N'CKC Quận 5', N'Tầng 7, Hùng Vương Plaza,
126 Hùng Vương, Q.5, Tp. Hồ Chí Minh','ckc_quan5.jpg','02253851234',
1)
SET @GUID_theater5 = NEWID();
INSERT Theater(Id, Name, Address, Image, Phone, Status) VALUES (@GUID_theater5, N'CKC Quận 7', N'Lầu 4, Siêu Thị Vincom 3/2,
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
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room1, @GUID_theater1, '01',1)
SET @GUID_room2 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room2, @GUID_theater1, '02', 1)
SET @GUID_room3 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room3, @GUID_theater1, '03', 1)
SET @GUID_room4 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room4, @GUID_theater1, '04', 1)
SET @GUID_room5 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room5, @GUID_theater1, '05', 1)

SET @GUID_room6 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room6, @GUID_theater4, '01',1)
SET @GUID_room7 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room7, @GUID_theater4, '02', 1)
SET @GUID_room8 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room8, @GUID_theater5, '01', 1)
SET @GUID_room9 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room9, @GUID_theater5, '02', 1)
SET @GUID_room10 = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@GUID_room10,@GUID_theater3, '01', 1)

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
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID, @GUID_movie1,0, '2024-06-11T08:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room1);

SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID, @GUID_movie1,0, '2024-06-11T09:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room3);

--3d
SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID, @GUID_movie1,1, '2024-06-11T08:30:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room2);

--spider
--2d
SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie5,0, '2024-06-11T11:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room1);

--3d
SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie5,1, '2024-06-11T11:30:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room2);

SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie5,1, '2024-06-11T12:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room3);


--dune
--2d
SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie3,0, '2024-06-11T14:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room1);

SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie3,0, '2024-06-11T15:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room3);

--batman
--2d
SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie4,0, '2024-06-11T14:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room2);

--avatar
--3d
SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie2,0, '2024-06-11T18:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room3);

SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie2,0, '2024-06-11T17:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room1);

SET @NEW_GUID = NEWID();
INSERT ShowTime(Id, MovieId, ProjectionForm, StartTime, EndTime, Status) VALUES (@NEW_GUID,@GUID_movie2,0, '2024-06-11T21:00:00', getdate(), 1)
INSERT ShowTimeRoom(ShowTimeId, RoomId) VALUES ( @NEW_GUID, @GUID_room3);

--ticket type
DECLARE @GUID_TicketType1 UNIQUEIDENTIFIER;
DECLARE @GUID_TicketType2 UNIQUEIDENTIFIER;


SET @GUID_TicketType1 = NEWID();
INSERT TicketType(Id, Name, Status) VALUES (@GUID_TicketType1, N'HSSV-Người Cao Tuổi', 1)
SET @GUID_TicketType2 = NEWID();
INSERT TicketType(Id, Name, Status) VALUES (@GUID_TicketType2,  N'Người lớn', 1)

--seat type
DECLARE @GUID_seatType1 UNIQUEIDENTIFIER;
DECLARE @GUID_seatType2 UNIQUEIDENTIFIER;
DECLARE @GUID_seatType3 UNIQUEIDENTIFIER;

SET @GUID_seatType1 = NEWID();
INSERT SeatType(Id, Name, Status) VALUES (@GUID_seatType1, N'Đơn', 1)
SET @GUID_seatType2 = NEWID();
INSERT SeatType(Id, Name, Status) VALUES (@GUID_seatType2, N'Ðôi', 1)
SET @GUID_seatType3 = NEWID();
INSERT SeatType(Id, Name, Status) VALUES (@GUID_seatType3, N'Nằm', 1)

--đơn - hssv, lớn
Insert SeatTypeTicketType(SeatTypeId, TicketTypeId,Price) VALUES(@GUID_seatType1,@GUID_TicketType1,45000)
Insert SeatTypeTicketType(SeatTypeId, TicketTypeId,Price) VALUES(@GUID_seatType1,@GUID_TicketType2,70000)
--đôi - lớn
Insert SeatTypeTicketType(SeatTypeId, TicketTypeId,Price) VALUES(@GUID_seatType2,@GUID_TicketType2,145000)
--nằm - hssv, lớn
Insert SeatTypeTicketType(SeatTypeId, TicketTypeId,Price) VALUES(@GUID_seatType3,@GUID_TicketType1, 90000)
Insert SeatTypeTicketType(SeatTypeId, TicketTypeId,Price) VALUES(@GUID_seatType3,@GUID_TicketType2,190000)

--combo
DECLARE @GUID_cb1 UNIQUEIDENTIFIER;
DECLARE @GUID_cb2 UNIQUEIDENTIFIER;
DECLARE @GUID_cb3 UNIQUEIDENTIFIER;

SET @GUID_cb1 = NEWID();
INSERT FoodAndDrink(Id, Name, Image, Description, Status) VALUES (@GUID_cb1, N'Combo Solo - VOL', 'BAP-2-NGAN_COMBO-SOLO.png', N'1 Coke 32oz - V + 1 Bắp 64OZ PM + CARAMEN', 1)
SET @GUID_cb2 = NEWID();
INSERT FoodAndDrink(Id, Name, Image, Description, Status) VALUES (@GUID_cb2, N'Combo Party - VOL', 'BAP-2-NGAN_COMBO-PARTY.png', N'4 Coke 22oz - V + 2 Bắp 64OZ PM + CARAMEN', 1)
SET @GUID_cb3 = NEWID();
INSERT FoodAndDrink(Id, Name, Image, Description, Status) VALUES (@GUID_cb3, N'Combo Couple - VOL', 'BAP-2-NGAN_COMBO-COUPLE.png', N'2 Coke 32oz - V + 1 Bắp 64OZ PM + CARAMEN', 1)

--theater 1
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb1,@GUID_theater1,109000);
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb2,@GUID_theater1,249000);
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb3,@GUID_theater1,119000);
--theater 2
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb1,@GUID_theater2,109000);
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb2,@GUID_theater2,249000);
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb3,@GUID_theater2,119000);


--theater 3
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb1,@GUID_theater3,119000);
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb2,@GUID_theater3,259000);
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb3,@GUID_theater3,129000);

--theater 4
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb1,@GUID_theater4,100000);
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb2,@GUID_theater4,240000);
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb3,@GUID_theater4,110000);

--theater 5
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb1,@GUID_theater5,99000);
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb2,@GUID_theater5,240000);
Insert FoodAndDrinkTheater(FoodAndDrinkId,TheaterId,Price) values(@GUID_cb3,@GUID_theater5,110000);

--phòng 1
--hàng A
SET @NEW_GUID = NEWID();

INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'A', 1, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'A', 2, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'A', 3, 0, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'A', 4, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'A', 5, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'A', 6, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'A', 7, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'A', 8, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'A', 9, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'A', 10, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'A', 11, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'A', 12, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'A', 13, 0, @GUID_seatType1)

-- Hàng B
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'B', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'B', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'B', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'B', 4, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'B', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'B', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'B', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'B', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'B', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'B', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'B', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'B', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'B', 13, 0, @GUID_seatType1);

-- Hàng C
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'C', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'C', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'C', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'C', 4, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'C', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'C', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'C', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'C', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'C', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'C', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'C', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'C', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'C', 13, 0, @GUID_seatType1);

-- Hàng D
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'D', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'D', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'D', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'D', 4, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'D', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'D', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'D', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'D', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'D', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'D', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'D', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'D', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'D', 13, 1, @GUID_seatType1);

-- Hàng E
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'E', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'E', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'E', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'E', 4, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'E', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'E', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'E', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'E', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'E', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'E', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'E', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'E', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'E', 13, 1, @GUID_seatType1);

-- Hàng F
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'F', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'F', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'F', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'F', 4, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'F', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'F', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'F', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'F', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'F', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'F', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'F', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'F', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'F', 13, 1, @GUID_seatType1);

-- Hàng g
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'G', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'G', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'G', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'G', 4, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'G', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'G', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'G', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'G', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'G', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'G', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'G', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'G', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'G', 13, 1, @GUID_seatType1);


-- Hàng H
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'H', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'H', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'H', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'H', 4, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'H', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'H', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'H', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'H', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'H', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'H', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'H', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'H', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'H', 13, 1, @GUID_seatType1);

-- Hàng I
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'I', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'I', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'I', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'I', 4, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'I', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'I', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'I', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'I', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'I', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'I', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'I', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'I', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'I', 13, 1, @GUID_seatType1);

-- Hàng k
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'K', 1, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'K', 2, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'K', 3, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'K', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'K', 5, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'K', 6, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room1, 'K', 7, 1, @GUID_seatType2);

--phòng 2
--hàng A
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 1, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 2, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 3, 0, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 4, 0, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 5, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 6, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 7, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 8, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 9, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 10, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 11, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 12, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 13, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'A', 17, 1, @GUID_seatType1)
-- Hàng B
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'B', 17, 1, @GUID_seatType1)

-- Hàng C
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'C', 17, 1, @GUID_seatType1)

-- Hàng D
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'D', 17, 1, @GUID_seatType1)

-- Hàng E
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'E', 17, 1, @GUID_seatType1)
-- Hàng F
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'F', 17, 1, @GUID_seatType1)

-- Hàng g
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'G', 17, 1, @GUID_seatType1)


-- Hàng H
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'H', 17, 1, @GUID_seatType1)

-- Hàng I
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'I', 17, 1, @GUID_seatType1)
-- Hàng k
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'K', 1, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'K', 2, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'K', 3, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'K', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'K', 5, 0, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'K', 6, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'K', 7, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'K', 8, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room2, 'K', 9, 1, @GUID_seatType2);

--phòng 3
--hàng A
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 1, 0, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 2, 0, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 3, 0, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 4, 0, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 5, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 6, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 7, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 8, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 9, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 10, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 11, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 12, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 13, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'A', 17, 1, @GUID_seatType1)
-- Hàng B
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 1, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 2, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'B', 17, 1, @GUID_seatType1)

-- Hàng C
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 1, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 2, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'C', 17, 1, @GUID_seatType1)

-- Hàng D
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 1, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 2, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'D', 17, 1, @GUID_seatType1)

-- Hàng E
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 1, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 2, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'E', 17, 1, @GUID_seatType1)
-- Hàng F
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'F', 17, 1, @GUID_seatType1)

-- Hàng g
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'G', 17, 1, @GUID_seatType1)


-- Hàng H
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'H', 17, 1, @GUID_seatType1)

-- Hàng I
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'I', 17, 1, @GUID_seatType1)

-- Hàng k
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 3, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'K', 17, 1, @GUID_seatType1)

-- Hàng L
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 3, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 4, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'L', 17, 1, @GUID_seatType1)

-- Hàng M
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 3, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 4, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'M', 17, 1, @GUID_seatType1)
-- Hàng N
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 1, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 2, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 3, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 4, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 5, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 6, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 7, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 8, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 9, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 10, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 11, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 12, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 13, 1, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 14, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 15, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 16, 1, @GUID_seatType1)
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'N', 17, 1, @GUID_seatType1)

-- Hàng O
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'O', 1, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'O', 2, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'O', 3, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'O', 4, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'O', 5, 0, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'O', 6, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'O', 7, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'O', 8, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'O', 9, 1, @GUID_seatType2);

-- Hàng P
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'P', 1, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'P', 2, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'P', 3, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'P', 4, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'P', 5, 0, @GUID_seatType1);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'P', 6, 0, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'P', 7, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'P', 8, 1, @GUID_seatType2);
INSERT Seat(RoomId, RowName, ColIndex, IsSeat,SeatTypeId) VALUES (@GUID_room3, 'P', 9, 1, @GUID_seatType2);