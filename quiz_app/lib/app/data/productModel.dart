class Product {
  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.brand,
    required this.model,
    required this.color,
    required this.category,
    required this.discount,
    required this.popular,
    required this.onSale,
  });

  final int id;
  final String title;
  final String image;
  final int price;
  final String description;
  final String brand;
  final String model;
  final String color;
  final String category;
  final int discount;
  final bool popular;
  final bool onSale;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      image: json["image"] ?? json["thumbnail"] ?? "",
      price: (json["price"] ?? 0).toInt(),
      description: json["description"] ?? "",
      brand: json["brand"] ?? "",
      model: json["model"] ?? "", // API doesn’t have this
      color: json["color"] ?? "", // API doesn’t have this
      category: json["category"] ?? "",
      discount: (json["discountPercentage"] ?? 0).toInt(),
      popular: json["popular"] ?? false, // not in API
      onSale: json["onSale"] ?? false, // not in API
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "price": price,
    "description": description,
    "brand": brand,
    "model": model,
    "color": color,
    "category": category,
    "discount": discount,
    "popular": popular,
    "onSale": onSale,
  };

  @override
  String toString() {
    return "$id, $title, $image, $price, $description, $brand, $model, $color, $category, $discount, $popular, $onSale, ";
  }
}
