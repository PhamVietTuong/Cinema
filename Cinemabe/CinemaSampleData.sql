use Cinema

--Delete data table
DELETE FROM MovieTypeDetail;
DELETE FROM Ticket;
DELETE FROM ShowTimeRoom;
DELETE FROM ShowTime;
DELETE FROM Seat;
DELETE FROM Movie;
DELETE FROM [User];
DELETE FROM UserType;
DELETE FROM AgeRestriction;
DELETE FROM Room;
DELETE FROM TicketType;
DELETE FROM SeatType;
DELETE FROM Theater;
DELETE FROM FoodAndDrink;
DELETE FROM MovieType;

DECLARE @NEW_GUID UNIQUEIDENTIFIER;
DECLARE @NEW_GUID1 UNIQUEIDENTIFIER;
DECLARE @NEW_GUID2 UNIQUEIDENTIFIER;

SET @NEW_GUID = NEWID();
INSERT SeatType(Id, Name, Status) VALUES (@NEW_GUID, N'Đơn', 1)
SET @NEW_GUID = NEWID();
INSERT SeatType(Id, Name, Status) VALUES (@NEW_GUID, N'Ðôi', 1)
SET @NEW_GUID = NEWID();
INSERT SeatType(Id, Name, Status) VALUES (@NEW_GUID, N'Nằm', 1)


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


SET @NEW_GUID = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@NEW_GUID, (select Id from Theater where Name=N'CKC Quận 1'), '01',1)
SET @NEW_GUID = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@NEW_GUID, (select Id from Theater where Name=N'CKC Quận 1'), '02', 1)
SET @NEW_GUID = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@NEW_GUID, (select Id from Theater where Name=N'CKC Quận 1'), '03', 1)
SET @NEW_GUID = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@NEW_GUID, (select Id from Theater where Name=N'CKC Quận 1'), '04', 1)
SET @NEW_GUID = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@NEW_GUID, (select Id from Theater where Name=N'CKC Quận 1'), '05', 1)

SET @NEW_GUID = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@NEW_GUID, (select Id from Theater where Name=N'CKC Quận 5'), '01',1)
SET @NEW_GUID = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@NEW_GUID, (select Id from Theater where Name=N'CKC Quận 5'), '02', 1)
SET @NEW_GUID = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@NEW_GUID, (select Id from Theater where Name=N'CKC Quận 7'), '01', 1)
SET @NEW_GUID = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@NEW_GUID, (select Id from Theater where Name=N'CKC Quận 7'), '02', 1)
SET @NEW_GUID = NEWID();
INSERT Room(Id, TheaterId, Name,  Status) VALUES (@NEW_GUID, (select Id from Theater where Name=N'CKC Quận 10'), '01', 1)


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







SET @NEW_GUID = NEWID();
INSERT Movie(Id, AgeRestrictionId, ShowTimeTypeId, Name, image, Time, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) VALUES (@NEW_GUID, (select Id from AgeRestriction where Name='T18'), (select Id from ShowTimeType where Name='3D'), N'GODZILLA X KONG', 'godzilla-x-kong.jpg', '125', GETDATE(), N'Kong và Godzilla - hai sinh vật vĩ đại huyền thoại, hai kẻ thủ truyền kiếp sẽ cùng bắt tay thực thi một sứ mệnh chung mang tính sống còn để bảo vệ nhân loại, và trận chiến gắn kết chúng với loài người mãi mãi sẽ bắt đầu.', N'Adam Wingard', N'Rebecca Hall, Dan Stevens, Rachel House', N'trailer', N'Tiếng việt', 1)
SET @NEW_GUID = NEWID();
INSERT Movie(Id, AgeRestrictionId, ShowTimeTypeId, Name, image, Time, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) VALUES (@NEW_GUID, (select Id from AgeRestriction where Name='T18'), (select Id from ShowTimeType where Name='2D'), N'QUẬT MỘ TRÙNG MA', 'quat-mo-trung-ma.jpg', '150', GETDATE(), N'Hai pháp sư, một thầy phong thuỷ và một chuyên gia khâm liệm cùng hợp lực khai quật ngôi mộ bị nguyền rủa của một gia đình giàu có, nhằm cứu lấy sinh mạng hậu duệ cuối cùng trong dòng tộc. Bí mật hắc ám của tổ tiên được đánh thức.', N'Jang Jae Hyun', N'Choi Min Sik, Yoo Hai Jin, Kim Go Eun, Lee Do Hyun,...', N'trailer', N'Tiếng việt', 1)
SET @NEW_GUID = NEWID();
INSERT Movie(Id, AgeRestrictionId, ShowTimeTypeId, Name, image, Time, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) VALUES (@NEW_GUID, (select Id from AgeRestriction where Name='T18'), (select Id from ShowTimeType where Name='3D'), N'KUNG FU PANDA 4', 'kungfu-panda-4-poster.jpg', '94', GETDATE(), N'Sau khi Po được chọn trở thành Thủ lĩnh tinh thần của Thung lũng Bình Yên, Po cần tìm và huấn luyện một Chiến binh Rồng mới, trong khi đó một mụ phù thủy độc ác lên kế hoạch triệu hồi lại tất cả những kẻ phản diện mà Po đã đánh bại về cõi linh hồn.', N'Mike Mitchell', N'Jack Black, Dustin Hoffman, James Hong, Awkwafina', N'trailer', N'Tiếng việt', 1)
SET @NEW_GUID = NEWID();
INSERT Movie(Id, AgeRestrictionId, ShowTimeTypeId, Name, image, Time, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) VALUES (@NEW_GUID, (select Id from AgeRestriction where Name='T18'), (select Id from ShowTimeType where Name='2D'), N'MAI', 'poster-mai.jpg', '131',  GETDATE(), N'"Mai" xoay quanh cuộc đời của một người phụ nữ đẹp tên Mai (do Phương Anh Đào thủ vai) có số phận rất đặc biệt. Bởi làm nghề mát xa, Mai thường phải đối mặt với ánh nhìn soi mói, phán xét từ những người xung quanh. Và rồi Mai gặp Dương (Tuấn Trần) - chàng trai đào hoa lãng tử. Những tưởng bản thân không còn thiết tha yêu đương và mưu cầu hạnh phúc cho riêng mình thì khao khát được sống một cuộc đời mới trong Mai trỗi dậy khi Dương tấn công cô không khoan nhượng. Họ cho mình những khoảnh khắc tự do, say đắm và tràn đầy tiếng cười. Liệu cặp đôi ấy có nắm giữ được niềm hạnh phúc đó dài lâu khi miệng đời lắm khi cay nghiệt, bất công? "Mai" - một câu chuyện tâm lý, tình cảm pha lẫn nhiều tràng cười vui nhộn với sự đầu tư mạnh tay nhất trong ba phim của Trấn Thành hứa hẹn sẽ đem đến cho khán giả những phút giây thật sự ý nghĩa trong mùa Tết năm nay.', N'Trấn Thành', N'Phương Anh Đào, Tuấn Trần, Trấn Thành, Uyển Ân, Hồng Đào, NSND Việt Anh, NSND Ngọc Giàu, Khả Như, Quốc Khánh, Anh Thư, Lý Hạo Mạnh Quỳnh, Anh Đức, Anh Phạm, Lộ Lộ, Kiều Linh, Ngọc Nga, Thanh Hằng, Ngọc Nguyễn, Hoàng Mèo, Mạnh Lân', N'trailer', N'Tiếng việt', 1)
SET @NEW_GUID = NEWID();
INSERT Movie(Id, AgeRestrictionId, ShowTimeTypeId, Name, image, Time, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) VALUES (@NEW_GUID, (select Id from AgeRestriction where Name='T18'), (select Id from ShowTimeType where Name='3D'), N'ĐỀN MẠNG', 'den-mang.jpg', '93', GETDATE(), N'Người cha quá cố đã phản bội lời thề khiến cho hồn ma Nang Rum nổi giận, quyết trả báo ứng lên người August bắt cầu đền mạng để chuộc tội . August sẽ tìm ra được lời thề để hóa giải lỗi lầm hay phải trả giá bằng tính mạng của bản thân?', N'Ekachai Sriwichai', N'Ekachai Sriwichai, Siwat Chotichaicharin, Ratchanok Suwannaket', N'trailer',N'Tiếng việt', 1)

SET @NEW_GUID = NEWID();
SET @NEW_GUID1 = NEWID();
SET @NEW_GUID2 = NEWID();
INSERT ShowTime(Id, MovieId, [Day], StartTime, EndTime, Status) VALUES (@NEW_GUID, (select Id from Movie where Name=N'GODZILLA X KONG'), GETDATE(), GETDATE(), GETDATE(), 1)
INSERT ShowTimeRoom(Id, ShowTimeId, RoomId) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='01'))
INSERT ShowTimeRoom(Id, ShowTimeId, RoomId) VALUES (@NEW_GUID2, @NEW_GUID, (select Id from Room where Name='02'))

SET @NEW_GUID = NEWID();
SET @NEW_GUID1 = NEWID();
INSERT ShowTime(Id, MovieId, [Day], StartTime, EndTime, Status) VALUES (@NEW_GUID, (select Id from Movie where Name=N'GODZILLA X KONG'), GETDATE() + 1, GETDATE(), GETDATE(), 1)
INSERT ShowTimeRoom(Id, ShowTimeId, RoomId) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='02'))

SET @NEW_GUID = NEWID();
SET @NEW_GUID1 = NEWID();
INSERT ShowTime(Id, MovieId, [Day], StartTime, EndTime, Status) VALUES (@NEW_GUID, (select Id from Movie where Name=N'GODZILLA X KONG'), GETDATE(),GETDATE(), GETDATE(), 1)
INSERT ShowTimeRoom(Id, ShowTimeId, RoomId) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='02'))

SET @NEW_GUID = NEWID();
SET @NEW_GUID1 = NEWID();
INSERT ShowTime(Id, MovieId, [Day], StartTime, EndTime, Status) VALUES (@NEW_GUID, (select Id from Movie where Name=N'KUNG FU PANDA 4'), GETDATE() + 3, GETDATE(), GETDATE(), 1)
INSERT ShowTimeRoom(Id, ShowTimeId, RoomId) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='02'))

SET @NEW_GUID = NEWID();
SET @NEW_GUID1 = NEWID();
INSERT ShowTime(Id, MovieId, [Day], StartTime, EndTime, Status) VALUES (@NEW_GUID, (select Id from Movie where Name=N'KUNG FU PANDA 4'), GETDATE() + 4, GETDATE(), GETDATE(), 1)
INSERT ShowTimeRoom(Id, ShowTimeId, RoomId) VALUES (@NEW_GUID1, @NEW_GUID, (select Id from Room where Name='02'))

SET @NEW_GUID = NEWID();
INSERT TicketType(Id, SeatTypeId, Name, Price, Status) VALUES (@NEW_GUID, (select Id from SeatType where Name=N'Đơn'), N'HSSV-Người Cao Tuổi', 45000, 1)
SET @NEW_GUID = NEWID();
INSERT TicketType(Id, SeatTypeId, Name, Price, Status) VALUES (@NEW_GUID, (select Id from SeatType where Name=N'Ðôi'), N'Người lớn', 145000, 1)

SET @NEW_GUID = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID, NULL, (select Id from Room where Name='01'), 'A', 1, NULL, 0)
SET @NEW_GUID = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID, NULL, (select Id from Room where Name='01'), 'A', 2, NULL, 0)

SET @NEW_GUID = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID, NULL, (select Id from Room where Name='02'), 'A', 1, NULL, 0)
SET @NEW_GUID = NEWID();
INSERT Seat(Id, TicketTypeId, RoomId, RowName, ColIndex, Name, IsSeat) VALUES (@NEW_GUID, NULL, (select Id from Room where Name='02'), 'A', 2, 'A1', 0)

SET @NEW_GUID = NEWID();
INSERT TicketType(Id, SeatTypeId, Name, Price, Status) VALUES (@NEW_GUID, (select Id from SeatType where Name=N'Đơn'), N'Người lớn', 70000, 1)

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

SET @NEW_GUID = NEWID();
INSERT TicketType(Id, SeatTypeId, Name, Price, Status) VALUES (@NEW_GUID, (select Id from SeatType where Name=N'Ðôi'), N'HSSV-Người Cao Tuổi', 90000, 1)

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
SET @NEW_GUID1 = NEWID();
INSERT MovieType(Id, Name, Status) VALUES (@NEW_GUID, N'Hành động', 1)
INSERT MovieTypeDetail(Id, MovieId, MovieTypeId) VALUES (@NEW_GUID1, (select Id from Movie where Name=N'GODZILLA X KONG'), @NEW_GUID)
SET @NEW_GUID = NEWID();
SET @NEW_GUID1 = NEWID();
INSERT MovieType(Id, Name, Status) VALUES (@NEW_GUID, N'Hoạt hình', 1)
INSERT MovieTypeDetail(Id, MovieId, MovieTypeId) VALUES (@NEW_GUID1, (select Id from Movie where Name=N'KUNG FU PANDA 4'), @NEW_GUID)
SET @NEW_GUID = NEWID();
SET @NEW_GUID1 = NEWID();
INSERT MovieType(Id, Name, Status) VALUES (@NEW_GUID, N'Hài hước', 1)
INSERT MovieTypeDetail(Id, MovieId, MovieTypeId) VALUES (@NEW_GUID1, (select Id from Movie where	Name=N'KUNG FU PANDA 4'), @NEW_GUID)

SET @NEW_GUID = NEWID();
INSERT FoodAndDrink(Id, Name, Image, Price, Description, Status) VALUES (@NEW_GUID, N'Combo Solo 2 Ngăn - VOL', 'BAP-2-NGAN_COMBO-SOLO.png', 119000, N'1 Coke 32oz - V + 1 Bắp 2 Ngăn 64OZ PM + CARAMEN', 1)
SET @NEW_GUID = NEWID();
INSERT FoodAndDrink(Id, Name, Image, Price, Description, Status) VALUES (@NEW_GUID, N'Combo Party 2 Ngăn - VOL', 'BAP-2-NGAN_COMBO-PARTY.png', 259000, N'4 Coke 22oz - V + 2 Bắp 2 Ngăn 64OZ PM + CARAMEN', 1)
SET @NEW_GUID = NEWID();
INSERT FoodAndDrink(Id, Name, Image, Price, Description, Status) VALUES (@NEW_GUID, N'Combo Couple 2 Ngăn - VOL', 'BAP-2-NGAN_COMBO-COUPLE.png', 129000, N'2 Coke 32oz - V + 1 Bắp 2 Ngăn 64OZ PM + CARAMEN', 1)
