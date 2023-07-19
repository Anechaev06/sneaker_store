import 'package:flutter/material.dart';
import '../models/sneaker_model.dart';

class SneakerDetails extends StatelessWidget {
  final Sneaker sneaker;

  const SneakerDetails({super.key, required this.sneaker});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            sneaker.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Price: \$${sneaker.price.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            sneaker.description,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
