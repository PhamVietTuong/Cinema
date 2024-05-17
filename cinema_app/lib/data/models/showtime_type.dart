class ShowTimeType {
  int id;
  String name;
  int status;
  ShowTimeType({this.id = 0, this.name = "", this.status = 0});
  ShowTimeType.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? 0,
        name = json["name"] ?? "",
        status = json["status"] ?? 0;
}
