class AgeRestriction {
  int id;
  String name;
  String value;
  AgeRestriction({this.id=0, this.name="", this.value=""});
  AgeRestriction.fromJson(Map<String, dynamic> json):
  id=json["id"],
  name=json["name"],
  value=json["value"];
}
