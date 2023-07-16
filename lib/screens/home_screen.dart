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
  late List<Sneaker> sneakers;
  final SneakerService _sneakerService = SneakerService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    sneakers = await _sneakerService.getSneakers();
    setState(() {});
  }

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
