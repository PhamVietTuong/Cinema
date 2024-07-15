class UpdateUser{
  String fullname;
  String phone;
  String email;
  DateTime birthDay=DateTime.now();
  bool gender;

  UpdateUser({
    this.fullname = "",
    this.phone = "",
    this.email = "",
        this.gender = false
  });

   UpdateUser.fromJson(Map<String, dynamic> json) :
      fullname= json["fullName"] ?? "",
      phone= json["phone"] ?? "",
      email= json["email"] ?? "",
      birthDay= json["birthDay"] != null
          ? DateTime.parse(json["birthDay"])
          : DateTime.now(),
      gender= json["gender"] ?? false;
  

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullname,
      "phone": phone,
      "email": email,
      "birthDay": birthDay.toIso8601String(),
      "gender": gender,
    };
  }
}