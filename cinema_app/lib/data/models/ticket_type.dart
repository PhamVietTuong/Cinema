// ignore_for_file: avoid_print

class TicketType {
  String id;
  String name;
  bool status;

  TicketType({this.id = "", this.name = "", this.status = false});
  TicketType.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? 0,
        name = json["name"] ?? "",
        status = json["status"] ?? 0;
}
