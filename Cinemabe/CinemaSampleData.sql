use Cinema

DECLARE @NEW_GUID UNIQUEIDENTIFIER;
SET @NEW_GUID = NEWID();
INSERT ChairTypes(Id, Name, Price, Status) VALUES (@NEW_GUID, N'Đơn', 50000, 1)
SET @NEW_GUID = NEWID();
INSERT ChairTypes(Id, Name, Price, Status) VALUES (@NEW_GUID, N'Ðôi', 50000, 1)

SET @NEW_GUID = NEWID();
INSERT RowChairs(Id, Name) VALUES(@NEW_GUID, 'A')
SET @NEW_GUID = NEWID();
INSERT RowChairs(Id, Name) VALUES(@NEW_GUID, 'B')
SET @NEW_GUID = NEWID();
INSERT RowChairs(Id, Name) VALUES(@NEW_GUID, 'C')
SET @NEW_GUID = NEWID();
INSERT RowChairs(Id, Name) VALUES(@NEW_GUID, 'D')
SET @NEW_GUID = NEWID();
INSERT RowChairs(Id, Name) VALUES(@NEW_GUID, 'E')

SET @NEW_GUID = NEWID();
INSERT Rooms(Id, Name, [With], Length, Status) VALUES (@NEW_GUID, '1', '50', '50', 1)
SET @NEW_GUID = NEWID();
INSERT Rooms(Id, Name, [With], Length, Status) VALUES (@NEW_GUID, '2', '100', '100', 1)
SET @NEW_GUID = NEWID();
INSERT Rooms(Id, Name, [With], Length, Status) VALUES (@NEW_GUID, '3', '150', '150', 1)
SET @NEW_GUID = NEWID();
INSERT Rooms(Id, Name, [With], Length, Status) VALUES (@NEW_GUID, '4', '200', '200', 1)
SET @NEW_GUID = NEWID();
INSERT Rooms(Id, Name, [With], Length, Status) VALUES (@NEW_GUID, '5', '250', '250', 1)

SET @NEW_GUID = NEWID();
INSERT Chairs(Id, ChairTypeId, RowChairId, RoomId, Name, IsSold) VALUES (@NEW_GUID, (select Id from ChairTypes where Name=N'Đơn'), (select Id from RowChairs where Name='A'), (select Id from Rooms where Name='1'), 'A1', 0)
SET @NEW_GUID = NEWID();
INSERT Chairs(Id, ChairTypeId, RowChairId, RoomId, Name, IsSold) VALUES (@NEW_GUID, (select Id from ChairTypes where Name=N'Đơn'), (select Id from RowChairs where Name='A'), (select Id from Rooms where Name='1'), 'A2', 0)
SET @NEW_GUID = NEWID();
INSERT Chairs(Id, ChairTypeId, RowChairId, RoomId, Name, IsSold) VALUES (@NEW_GUID, (select Id from ChairTypes where Name=N'Đơn'), (select Id from RowChairs where Name='A'), (select Id from Rooms where Name='1'), 'A3', 0)
SET @NEW_GUID = NEWID();
INSERT Chairs(Id, ChairTypeId, RowChairId, RoomId, Name, IsSold) VALUES (@NEW_GUID, (select Id from ChairTypes where Name=N'Đơn'), (select Id from RowChairs where Name='A'), (select Id from Rooms where Name='1'), 'A4', 0)
SET @NEW_GUID = NEWID();
INSERT Chairs(Id, ChairTypeId, RowChairId, RoomId, Name, IsSold) VALUES (@NEW_GUID, (select Id from ChairTypes where Name=N'Đơn'), (select Id from RowChairs where Name='A'), (select Id from Rooms where Name='1'), 'A5', 0)
SET @NEW_GUID = NEWID();
INSERT Chairs(Id, ChairTypeId, RowChairId, RoomId, Name, IsSold) VALUES (@NEW_GUID, (select Id from ChairTypes where Name='Ðôi'), (select Id from RowChairs where Name='B'), (select Id from Rooms where Name='1'), 'B1', 0)
SET @NEW_GUID = NEWID();
INSERT Chairs(Id, ChairTypeId, RowChairId, RoomId, Name, IsSold) VALUES (@NEW_GUID, (select Id from ChairTypes where Name='Ðôi'), (select Id from RowChairs where Name='B'), (select Id from Rooms where Name='1'), 'B2', 0)
SET @NEW_GUID = NEWID();
INSERT Chairs(Id, ChairTypeId, RowChairId, RoomId, Name, IsSold) VALUES (@NEW_GUID, (select Id from ChairTypes where Name='Ðôi'), (select Id from RowChairs where Name='B'), (select Id from Rooms where Name='1'), 'B3', 0)
SET @NEW_GUID = NEWID();
INSERT Chairs(Id, ChairTypeId, RowChairId, RoomId, Name, IsSold) VALUES (@NEW_GUID, (select Id from ChairTypes where Name='Ðôi'), (select Id from RowChairs where Name='B'), (select Id from Rooms where Name='1'), 'B4', 0)
SET @NEW_GUID = NEWID();
INSERT Chairs(Id, ChairTypeId, RowChairId, RoomId, Name, IsSold) VALUES (@NEW_GUID, (select Id from ChairTypes where Name='Ðôi'), (select Id from RowChairs where Name='B'), (select Id from Rooms where Name='1'), 'B5', 0)

SET @NEW_GUID = NEWID();
INSERT AgeRestrictions(Id, Name, Status) VALUES (@NEW_GUID, N'Trên 18 tuổi', 1)

SET @NEW_GUID = NEWID();
INSERT Movies(Id, AgeRestrictionId, Name, image, Time, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) VALUES (@NEW_GUID, (select Id from AgeRestrictions where Name=N'Trên 18 tuổi'), N'GODZILLA X KONG', 'godzilla-x-kong.jpg', '125', GETDATE(), N'Kong và Godzilla - hai sinh vật vĩ đại huyền thoại, hai kẻ thủ truyền kiếp sẽ cùng bắt tay thực thi một sứ mệnh chung mang tính sống còn để bảo vệ nhân loại, và trận chiến gắn kết chúng với loài người mãi mãi sẽ bắt đầu.', N'Adam Wingard', N'Rebecca Hall, Dan Stevens, Rachel House', N'trailer', N'Tiếng việt', 1)
SET @NEW_GUID = NEWID();
INSERT Movies(Id, AgeRestrictionId, Name, image, Time, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) VALUES (@NEW_GUID, (select Id from AgeRestrictions where Name=N'Trên 18 tuổi'), N'QUẬT MỘ TRÙNG MA', 'quat-mo-trung-ma.jpg', '150', GETDATE(), N'Hai pháp sư, một thầy phong thuỷ và một chuyên gia khâm liệm cùng hợp lực khai quật ngôi mộ bị nguyền rủa của một gia đình giàu có, nhằm cứu lấy sinh mạng hậu duệ cuối cùng trong dòng tộc. Bí mật hắc ám của tổ tiên được đánh thức.', N'Jang Jae Hyun', N'Choi Min Sik, Yoo Hai Jin, Kim Go Eun, Lee Do Hyun,...', N'trailer', N'Tiếng việt', 1)
SET @NEW_GUID = NEWID();
INSERT Movies(Id, AgeRestrictionId, Name, image, Time, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) VALUES (@NEW_GUID, (select Id from AgeRestrictions where Name=N'Trên 18 tuổi'), N'KUNG FU PANDA 4', 'kungfu-panda-4-poster.jpg', '94', GETDATE(), N'Sau khi Po được chọn trở thành Thủ lĩnh tinh thần của Thung lũng Bình Yên, Po cần tìm và huấn luyện một Chiến binh Rồng mới, trong khi đó một mụ phù thủy độc ác lên kế hoạch triệu hồi lại tất cả những kẻ phản diện mà Po đã đánh bại về cõi linh hồn.', N'Mike Mitchell', N'Jack Black, Dustin Hoffman, James Hong, Awkwafina', N'trailer', N'Tiếng việt', 1)
SET @NEW_GUID = NEWID();
INSERT Movies(Id, AgeRestrictionId, Name, image, Time, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) VALUES (@NEW_GUID, (select Id from AgeRestrictions where Name=N'Trên 18 tuổi'), N'MAI', 'poster-mai.jpg', '131',  GETDATE(), N'"Mai" xoay quanh cuộc đời của một người phụ nữ đẹp tên Mai (do Phương Anh Đào thủ vai) có số phận rất đặc biệt. Bởi làm nghề mát xa, Mai thường phải đối mặt với ánh nhìn soi mói, phán xét từ những người xung quanh. Và rồi Mai gặp Dương (Tuấn Trần) - chàng trai đào hoa lãng tử. Những tưởng bản thân không còn thiết tha yêu đương và mưu cầu hạnh phúc cho riêng mình thì khao khát được sống một cuộc đời mới trong Mai trỗi dậy khi Dương tấn công cô không khoan nhượng. Họ cho mình những khoảnh khắc tự do, say đắm và tràn đầy tiếng cười. Liệu cặp đôi ấy có nắm giữ được niềm hạnh phúc đó dài lâu khi miệng đời lắm khi cay nghiệt, bất công? "Mai" - một câu chuyện tâm lý, tình cảm pha lẫn nhiều tràng cười vui nhộn với sự đầu tư mạnh tay nhất trong ba phim của Trấn Thành hứa hẹn sẽ đem đến cho khán giả những phút giây thật sự ý nghĩa trong mùa Tết năm nay.', 'Trấn Thành', 'Phương Anh Đào, Tuấn Trần, Trấn Thành, Uyển Ân, Hồng Đào, NSND Việt Anh, NSND Ngọc Giàu, Khả Như, Quốc Khánh, Anh Thư, Lý Hạo Mạnh Quỳnh, Anh Đức, Anh Phạm, Lộ Lộ, Kiều Linh, Ngọc Nga, Thanh Hằng, Ngọc Nguyễn, Hoàng Mèo, Mạnh Lân', N'trailer', N'Tiếng việt', 1)
SET @NEW_GUID = NEWID();
INSERT Movies(Id, AgeRestrictionId, Name, image, Time, ReleaseDate, Description, Director, Actor, Trailer, Languages, Status) VALUES (@NEW_GUID, (select Id from AgeRestrictions where Name=N'Trên 18 tuổi'), N'ĐỀN MẠNG', 'den-mang.jpg', '93', GETDATE(), N'Người cha quá cố đã phản bội lời thề khiến cho hồn ma Nang Rum nổi giận, quyết trả báo ứng lên người August bắt cầu đền mạng để chuộc tội . August sẽ tìm ra được lời thề để hóa giải lỗi lầm hay phải trả giá bằng tính mạng của bản thân?', N'Ekachai Sriwichai', N'Ekachai Sriwichai, Siwat Chotichaicharin, Ratchanok Suwannaket', N'trailer',N'Tiếng việt', 1)

SET @NEW_GUID = NEWID();
INSERT Theaters(Id, Name, Address, Status) VALUES (@NEW_GUID, N'CINESTAR HAI BÀ TRƯNG', N'135 Hai Bà Trưng, Phường Bến Nghé ,Quận 1,Thành Phố Hồ Chí Minh', 1)
SET @NEW_GUID = NEWID();
INSERT Theaters(Id, Name, Address, Status) VALUES (@NEW_GUID, N'Mega GS Cao Thắng', N'Lầu 6 - 7, 19 Cao Thắng, P.2, Q.3, Tp. Hồ Chí Minh', 1)
SET @NEW_GUID = NEWID();
INSERT Theaters(Id, Name, Address, Status) VALUES (@NEW_GUID, N'Galaxy Nguyễn Du', N'116 Nguyễn Du, Q.1, Tp. Hồ Chí Minh', 1)
SET @NEW_GUID = NEWID();
INSERT Theaters(Id, Name, Address, Status) VALUES (@NEW_GUID, N'CGV Hùng Vương Plaza ', N'Tầng 7, Hùng Vương Plaza, 126 Hùng Vương, Q.5, Tp. Hồ Chí Minh', 1)
SET @NEW_GUID = NEWID();
INSERT Theaters(Id, Name, Address, Status) VALUES (@NEW_GUID, N'BHD Star 3/2', N'Lầu 4, Siêu Thị Vincom 3/2, 3C Đường 3/2, Q. 10, Tp. Hồ Chí Minh', 1)

SET @NEW_GUID = NEWID();
INSERT ShowTimeTypes(Id, Name, Status) VALUES (@NEW_GUID, '2D-LT', 1)
SET @NEW_GUID = NEWID();
INSERT ShowTimeTypes(Id, Name, Status) VALUES (@NEW_GUID, '2D-PĐ', 1)
SET @NEW_GUID = NEWID();
INSERT ShowTimeTypes(Id, Name, Status) VALUES (@NEW_GUID, '3D-LT', 1)
SET @NEW_GUID = NEWID();
INSERT ShowTimeTypes(Id, Name, Status) VALUES (@NEW_GUID, '3D-PĐ', 1)

SET @NEW_GUID = NEWID();
INSERT ShowTimes(Id, MovieId, TheaterId, ShowTimeTypeId, RoomId, [Day], StartTime, EndTime, Status) VALUES (@NEW_GUID, (select Id from Movies where Name=N'GODZILLA X KONG'), (select Id from Theaters where Name=N'CINESTAR HAI BÀ TRƯNG'), (select Id from ShowTimeTypes where Name='2D-LT'), (select Id from Rooms where Name='1'), GETDATE(), GETDATE(), GETDATE()+1, 1)
SET @NEW_GUID = NEWID();
INSERT ShowTimes(Id, MovieId, TheaterId, ShowTimeTypeId, RoomId, [Day], StartTime, EndTime, Status) VALUES (@NEW_GUID, (select Id from Movies where Name=N'GODZILLA X KONG'), (select Id from Theaters where Name=N'CINESTAR HAI BÀ TRƯNG'), (select Id from ShowTimeTypes where Name='2D-PĐ'), (select Id from Rooms where Name='1'), GETDATE(), GETDATE()+2, GETDATE()+3, 1)
SET @NEW_GUID = NEWID();
INSERT ShowTimes(Id, MovieId, TheaterId, ShowTimeTypeId, RoomId, [Day], StartTime, EndTime, Status) VALUES (@NEW_GUID, (select Id from Movies where Name=N'QUẬT MỘ TRÙNG MA'), (select Id from Theaters where Name=N'Mega GS Cao Thắng'), (select Id from ShowTimeTypes where Name='2D-LT'), (select Id from Rooms where Name='2'), GETDATE(), GETDATE(), GETDATE()+1, 1)
SET @NEW_GUID = NEWID();
INSERT ShowTimes(Id, MovieId, TheaterId, ShowTimeTypeId, RoomId, [Day], StartTime, EndTime, Status) VALUES (@NEW_GUID, (select Id from Movies where Name=N'QUẬT MỘ TRÙNG MA'), (select Id from Theaters where Name=N'Mega GS Cao Thắng'), (select Id from ShowTimeTypes where Name='2D-PĐ'), (select Id from Rooms where Name='2'), GETDATE(), GETDATE()+1, GETDATE()+2, 1)
SET @NEW_GUID = NEWID();
INSERT ShowTimes(Id, MovieId, TheaterId, ShowTimeTypeId, RoomId, [Day], StartTime, EndTime, Status) VALUES (@NEW_GUID, (select Id from Movies where Name=N'QUẬT MỘ TRÙNG MA'), (select Id from Theaters where Name=N'Mega GS Cao Thắng'), (select Id from ShowTimeTypes where Name='3D-LT'), (select Id from Rooms where Name='2'), GETDATE(), GETDATE()+2, GETDATE()+3, 1)

SET @NEW_GUID = NEWID();
INSERT Tickets(Id, ShowTimeId, UserId, Status) VALUES (@NEW_GUID, (select ShowTimes.Id from ShowTimes join Movies on Movies.Id = ShowTimes.MovieId Join ShowTimeTypes on ShowTimeTypes.Id = ShowTimes.ShowTimeTypeId where Movies.Name = N'GODZILLA X KONG' and ShowTimeTypes.Name = N'2D-LT'), (select Id from AspNetUsers where UserName='Tuong'), 1)
SET @NEW_GUID = NEWID();
INSERT Tickets(Id, ShowTimeId, UserId, Status) VALUES (@NEW_GUID, (select ShowTimes.Id from ShowTimes join Movies on Movies.Id = ShowTimes.MovieId Join ShowTimeTypes on ShowTimeTypes.Id = ShowTimes.ShowTimeTypeId where Movies.Name = N'QUẬT MỘ TRÙNG MA' and ShowTimeTypes.Name = N'2D-LT'), (select Id from AspNetUsers where UserName='Tuong'), 1)

