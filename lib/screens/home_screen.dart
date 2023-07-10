import 'package:flutter/material.dart';
import 'package:sneaker_store/widgets/sneaker_tile.dart';
import '../models/sneaker_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

  // Assume you have a list of Sneakers here
  final List<Sneaker> sneakers = [
    Sneaker(
      images: [
        'assets/images/nike/dunk_low_vx1000_1.jpg',
        'assets/images/nike/dunk_low_vx1000_2.jpeg',
        'assets/images/nike/dunk_low_vx1000_3.jpeg'
      ],
      title: 'Nike SB Dunk Low VX1000',
      price: 299.99,
    ),
    Sneaker(
      images: [
        'assets/images/nike/dunk_low_gulf_58_1.jpeg',
        'assets/images/nike/dunk_low_gulf_58_2.jpeg',
        'assets/images/nike/dunk_low_gulf_58_3.jpeg'
      ],
      title: 'Dunk SB Low Club 58 Gulf',
      price: 399.99,
    ),
    Sneaker(
      images: ['assets/images/new_balance/nb-White-Green.jpeg'],
      title: 'New Balance 550 Aime Leon Dore - White Green',
      price: 239.99,
    ),
    Sneaker(
      images: ['assets/images/adidas/adidas_slides.jpeg'],
      title: 'Yeezy Slide Glow Green',
      price: 199.99,
    ),
    Sneaker(
      images: ['assets/images/adidas/samba-green.jpeg'],
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
