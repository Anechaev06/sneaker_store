import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_store/widgets/sneaker_tile.dart';
import '../models/sneaker_model.dart';
import '../services/sneaker_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  final SneakerService _sneakerService = SneakerService();

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
                  onTap: () {
                    // Implement the search functionality here
                  },
                ),
              ),
              const SizedBox(width: 10),

              // Filter
              IconButton(
                onPressed: () {
                  // Navigate to the Filter screen or show a dialog
                },
                icon: const Icon(Icons.tune),
              )
            ],
          ),

          const SizedBox(height: 20),

          // Sneakers
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _sneakerService.getSneakersStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                List<Sneaker> sneakers = snapshot.data!.docs
                    .map((doc) =>
                        Sneaker.fromJson(doc.data() as Map<String, dynamic>))
                    .toList();

                return ListView.separated(
                  itemCount: sneakers.length,
                  itemBuilder: (context, index) {
                    return SneakerTile(sneaker: sneakers[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
