import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  String _currentBrand = 'All';
  List<Sneaker>? _searchResults;

  @override
  Widget build(BuildContext context) {
    final sneakerService = Provider.of<SneakerService>(context, listen: false);
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
                    String searchQuery = _controller.text;
                    sneakerService
                        .getSneakersByName(searchQuery)
                        .then((List<Sneaker> searchResults) {
                      setState(() {
                        _searchResults = searchResults;
                      });
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),

              // Filter
              FutureBuilder<List<String>>(
                future: sneakerService.getBrands(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show loading spinner while waiting
                  } else if (snapshot.hasError) {
                    return Text(
                        'Error: ${snapshot.error}'); // Show error message if something went wrong
                  } else {
                    List<String> brands = snapshot.data!;
                    brands.insert(0, 'All');
                    return PopupMenuButton<String>(
                      onSelected: (String brand) {
                        setState(() {
                          _currentBrand = brand;
                        });
                      },
                      itemBuilder: (BuildContext context) {
                        return brands.map((String brand) {
                          return PopupMenuItem<String>(
                            value: brand,
                            child: Text(brand),
                          );
                        }).toList();
                      },
                      icon: const Icon(Icons.tune),
                    );
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Sneakers
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: sneakerService.getSneakersStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                List<Sneaker> sneakers = _searchResults != null
                    ? _searchResults!
                    : snapshot.data!.docs
                        .map((doc) => Sneaker.fromJson(
                            doc.data() as Map<String, dynamic>))
                        .toList();

                if (_currentBrand != 'All') {
                  sneakers = sneakers
                      .where((sneaker) => sneaker.brand == _currentBrand)
                      .toList();
                }

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
