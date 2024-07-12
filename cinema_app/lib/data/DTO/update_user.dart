class UpdateUser{
  String id;
  String fullname;
  String phone;
  String email;
  DateTime birthday=DateTime.now();
  bool gender;

  UpdateUser({
    required this.id,
    this.fullname = "",
    this.phone = "",
    this.email = "",
        this.gender = true
  });

   UpdateUser.fromJson(Map<String, dynamic> json) :
      id=json["id"] ?? "",
      fullname= json["fullName"] ?? "",
      phone= json["phone"] ?? "",
      email= json["email"] ?? "",
      birthday= json["birthday"] != null
          ? DateTime.parse(json["birthday"])
          : DateTime.now(),
      gender= json["gender"] ?? true;
  

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullName": fullname,
      "phone": phone,
      "email": email,
      "birthday": birthday.toIso8601String(),
      "gender": gender,
    };
  }
}