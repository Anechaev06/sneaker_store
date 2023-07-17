class Sneaker {
  String id;

  String title;
  double price;
  List<String> images;

  Sneaker({
    required this.id,
    required this.title,
    required this.price,
    required this.images,
  });

  // Convert a Sneaker object into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'images': images,
    };
  }

  // Create a Sneaker object from a JSON map.
  Sneaker.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        price = json['price'].toDouble(),
        images = List<String>.from(json['images']);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Sneaker && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
