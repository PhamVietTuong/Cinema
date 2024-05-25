
class AgeRestriction {
  String id;
  String name;
  String description;
  String abbreviation;
  bool status;

  AgeRestriction(
      {this.id = "", this.name = "", this.status = false, this.description = "", this.abbreviation=""});

  AgeRestriction.fromJson(Map<String, dynamic> json)
      : id = json["id"]??"",
        name = json["name"]??"",
        description = json["description"] ?? "",
        abbreviation=json["abbreviation"]??"",
        status = json["status"] ?? false;
}
