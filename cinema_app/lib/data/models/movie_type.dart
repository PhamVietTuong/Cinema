class MovieType {
  String id;
  String name;

  MovieType({this.name = "", this.id = ""});

  MovieType.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? "",
        name = json["name"] ?? "";
  //status = json["status"] ?? 0;
}
