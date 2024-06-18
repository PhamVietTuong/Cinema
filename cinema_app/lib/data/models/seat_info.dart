class SeatInfo {
  String rowName;
  int colIndex;
  SeatInfo({this.colIndex = -1, this.rowName = ""});
  SeatInfo.fromJson(Map<String, dynamic> json)
      : colIndex = json["colIndex"] ?? -1,
        rowName = json["rowName"] ?? "";
}
