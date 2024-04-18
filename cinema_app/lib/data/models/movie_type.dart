class MovieType {
  int id;
  String name;
  MovieType({this.id = 0, this.name = ""});
  MovieType.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}
