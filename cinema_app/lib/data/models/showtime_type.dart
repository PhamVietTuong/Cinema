class ShowTimeType {
  int id;
  String name;
  //int status;
  ShowTimeType({this.name = "", this.id = 0});
  ShowTimeType.fromProjectionFrom(int projectionFrom)
      : id = projectionFrom,
        name = projectionFrom == 1 ? "2D" : "3D";
  ShowTimeType.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? 0,
        name = json["name"] ?? "";
  //status = json["status"] ?? 0;
}
