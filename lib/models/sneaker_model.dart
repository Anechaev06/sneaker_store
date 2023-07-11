class Sneaker {
  String title;
  double price;
  List<String> images;

  Sneaker({
    required this.title,
    required this.price,
    required this.images,
  });
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sneaker && other.title == title;
  }

  @override
  int get hashCode => title.hashCode;
}
