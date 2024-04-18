class ShowTime {
  int id;
  int movieId;
  DateTime day;
  DateTime startTime;
  DateTime endTime;
  int theaterId;
  int roomId;
  int showTimeTypeId;

  ShowTime(
      {required this.day,
      required this.endTime,
      required this.id,
      required this.movieId,
      required this.roomId,
      required this.showTimeTypeId,
      required this.startTime,
      required this.theaterId});

  ShowTime.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        movieId = json['movieId'],
        day = json['day'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        theaterId = json['theaterId'],
        roomId = json['roomId'] ?? false,
        showTimeTypeId = json['showTimeTypeId'];
}
