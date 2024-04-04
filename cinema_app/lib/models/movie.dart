class Movie {
  int id;
  String name;
  int time;
  int ageRestrictionId;
  DateTime releaseDate;
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
}
