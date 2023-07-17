class Sneaker {
  final String id;
  final String title;
  final double price;
  final List<String> images;

  const Sneaker({
    required this.id,
    required this.title,
    required this.price,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'images': images,
    };
  }

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
