// ignore_for_file: avoid_print

class SeatType {
  String id;
  String name;
  bool status;

  SeatType({this.id = "", this.name = "", this.status = false});

  SeatType.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? "",
        name = json["name"] ?? "",
        status = json["status"] ?? false;
}
