class Movie {
  int id;
  String name;
  int time;
  int ageRestrictionId;
  String releaseDate;
  String description;
  String director;
  String actor;
  String trailer;
  String languages;
  String img;
  Movie(
      {required this.id,
      required this.actor,
      required this.ageRestrictionId,
      required this.description,
      required this.director,
      required this.img,
      required this.languages,
      required this.name,
      required this.releaseDate,
      required this.time,
      required this.trailer});
  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        actor = json["actor"],
        ageRestrictionId = json["ageRestrictionId"],
        description = json["description"],
        director = json["director"],
        img = json["img"],
        languages = json["languages"],
        name = json["name"],
        releaseDate = json["releaseDate"],
        time = json["time"],
        trailer = json["trailer"];
}
