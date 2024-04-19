export class MovieInformation {
    maLichChieu = "";
    tenCumRap = "";
    tenRap = "";
    diaChi = "";
    tenPhim = "";
    hinhAnh = "";
    ngayChieu = "";
    gioChieu = "";
}

export class Chair {
    Id="";
    ChairTypeName="";
    RowChairName="";
    Name="";
    IsSold="";
}

export class ShowTimeInformation {
    MovieInformation = new MovieInformation();
    ListChair = [];
}
