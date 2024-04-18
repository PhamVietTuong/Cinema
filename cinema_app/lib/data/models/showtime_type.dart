class ShowTimeType {
  int id;
  String name;
  ShowTimeType({required this.id, required this.name});
  ShowTimeType.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}
