import 'package:flutter/material.dart';
import 'package:sneaker_store/widgets/sneaker_tile.dart';
import '../models/sneaker_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

  // Assume you have a list of Sneakers here
  final List<Sneaker> sneakers = [
    Sneaker(
      imageUrl: 'assets/images/dunk_low.jpg',
      title: 'Nike SB Dunk Low VX1000',
      price: 399.99,
    ),
    Sneaker(
      imageUrl: 'assets/images/club_58_gulf.jpeg',
      title: 'Dunk SB Low Club 58 Gulf',
      price: 499.99,
    ),
    Sneaker(
      imageUrl: 'assets/images/nb-White-Green.jpeg',
      title: 'New Balance 550 Aime Leon Dore - White Green',
      price: 239.99,
    ),
    Sneaker(
      imageUrl: 'assets/images/adidas_slides.jpeg',
      title: 'Yeezy Slide Glow Green',
      price: 199.99,
    ),
    Sneaker(
      imageUrl: 'assets/images/samba-green.jpeg',
      title: 'Adidas Samba OG Collegiate Green Gum Grey Toe',
      price: 249.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: SearchBar(
                  hintText: "Search",
                  controller: _controller,
                  onTap: () => {},
                ),
              ),
              const SizedBox(width: 10),

              // Filter
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Filter screen or show a dialog
                },
                child: const Icon(Icons.tune),
              )
            ],
          ),

          const SizedBox(height: 20),

          // Sneakers
          Expanded(
            child: ListView.separated(
              itemCount: sneakers.length,
              itemBuilder: (context, index) {
                return SneakerTile(sneaker: sneakers[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
            ),
          ),
        ],
      ),
    );
  }
}
