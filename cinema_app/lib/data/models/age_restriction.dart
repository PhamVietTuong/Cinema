class AgeRestriction {
  int id;
  String name;
  String description;
  int status;

  AgeRestriction({this.id = 0, this.name = "", this.status = 0, this.description=""});

  AgeRestriction.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"], description=json["description"]??"",
        status = json["status"] ?? 0;
}
