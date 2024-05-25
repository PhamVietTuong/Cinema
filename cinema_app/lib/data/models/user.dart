class User {
  int id;
  String name;
  String phone;
  String email;
  String address;
  DateTime birthday = DateTime.now();
  String image;
  bool gender;
  int status;

  User({
    this.id = 0,
    this.name = "",
    this.phone = "",
    this.email = "",
    this.address = "",
    this.image = "",
    this.gender = false,
    this.status = 0,
  });

  User.formJson(Map<String, dynamic> json)
      : id = json["id"] ?? 0,
        name = json["name"] ?? "",
        phone = json["phone"] ?? "",
        email = json["email"] ?? "",
        address = json["address"] ?? "",
        birthday = json["birthday"] ?? DateTime.now(),
        image = json["image"] ?? "",
        gender = json["gender"] ?? "",
        status = json["status"] ?? 0;
}
