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
  String _currentBrand = 'All'; // Variable to store the current brand filter

  @override
  Widget build(BuildContext context) {
    final sneakerService = Provider.of<SneakerService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sneaker Store'),
        actions: [
          // PopupMenuButton to allow the user to select a brand
          PopupMenuButton<String>(
            onSelected: (String brand) {
              setState(() {
                _currentBrand = brand;
              });
            },
            itemBuilder: (BuildContext context) {
              return ['All', 'Brand1', 'Brand2', 'Brand3'].map((String brand) {
                return PopupMenuItem<String>(
                  value: brand,
                  child: Text(brand),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Sneaker>>(
        // Use the current brand to fetch the sneakers
        future: _currentBrand == 'All'
            ? sneakerService.getSneakers()
            : sneakerService.getSneakersByBrand(_currentBrand),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return SneakerTile(sneaker: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
