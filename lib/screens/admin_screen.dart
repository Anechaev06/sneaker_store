import 'package:flutter/material.dart';
import '../models/sneaker_model.dart';
import '../services/sneaker_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sneakerService = SneakerService();
  String id = '';
  String title = '';
  double price = 0.0;
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Sneaker'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onSaved: (value) => id = value ?? '',
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Title'),
                onSaved: (value) => title = value ?? '',
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Price'),
                onSaved: (value) => price = double.tryParse(value ?? '') ?? 0.0,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Image url'),
                onSaved: (value) => imageUrl = value ?? '',
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Delete'),
                onPressed: () async {
                  _formKey.currentState?.save();
                  try {
                    await _sneakerService.deleteSneaker(id);
                  } catch (e) {
                    print('Error deleting sneaker: $e');
                  }
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    final sneaker = Sneaker(
                      id: id,
                      title: title,
                      price: price,
                      images: [imageUrl],
                    );
                    _sneakerService.addSneaker(sneaker);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
