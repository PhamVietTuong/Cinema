class Theater {
  int id;
  String name;
  String address;
  String phone;
  String img;
  bool status = false;

  Theater({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.img
  });

  Theater.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        address = json['address'],
        name = json['name'],
        img=json['img'],
        phone = json['phone'],
        status = json['status'] ?? false;
}
