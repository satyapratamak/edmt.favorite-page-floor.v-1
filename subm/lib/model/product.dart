class Product {
  late int id;
  late String name;
  late String category;
  late String imageUrl;
  late String oldPrice;
  late String price;

  Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.imageUrl,
      required this.oldPrice,
      required this.price});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    imageUrl = json['imageUrl'];
    oldPrice = json['oldPrice'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['imageUrl'] = imageUrl;
    data['oldPrice'] = oldPrice;
    data['price'] = price;
    return data;
  }
}
