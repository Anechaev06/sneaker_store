class Sneaker {
  final String id;
  final String name;
  final double price;
  final String brand;
  final String description;
  final List<String> images;

  const Sneaker({
    required this.id,
    required this.name,
    required this.price,
    required this.brand,
    required this.description,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'brand': brand,
      'description': description,
      'images': images,
    };
  }

  Sneaker.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = json['price'].toDouble(),
        brand = json['brand'],
        description = json['description'],
        images = List<String>.from(json['images']);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Sneaker && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
