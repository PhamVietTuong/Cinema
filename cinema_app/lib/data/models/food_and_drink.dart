class FoodAndDrink {
  String id;
  String name;
  String description;
  String image;
  double price;

  FoodAndDrink(
      {this.description = "",
      this.id = "",
      this.image = "",
      this.name = "",
      this.price = 0.0});

  FoodAndDrink.fromJson(Map<String, dynamic> json)
      : id = json["id"]??"",
        name = json["name"]??"",
        description = json["description"]??"",
        image = json["image"]??"",
        price = json["price"]??0.0;
}
