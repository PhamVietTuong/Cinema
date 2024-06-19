class FoodAndDrink {
  String id;
  String name;
  String description;
  String image;
  int price;
  int quantity;

  FoodAndDrink(
      {this.description = "",
      this.id = "",
      this.image = "",
      this.name = "",
      this.price = 0, this.quantity=0});

  FoodAndDrink.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? "",
        name = json["name"] ?? "",
        description = json["description"] ?? "",
        image = json["image"] ?? "",
        quantity=0,
        price = json["price"] ?? 0;
}
