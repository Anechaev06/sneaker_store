class Sneaker {
  String id;
  String name;
  String title;
  double price;
  List<String> images;

  Sneaker({
    required this.name,
    required this.id,
    required this.title,
    required this.price,
    required this.images,
  });

  // Convert a Sneaker object into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'price': price,
      'images': images,
    };
  }

  // Create a Sneaker object from a JSON map.
  static Sneaker fromJson(Map<String, dynamic> json) {
    return Sneaker(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
      price: json['price'] as double,
      images: List<String>.from(json['images'] as List),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Sneaker && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
