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
  String name = '';
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
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'ID'),
              onSaved: (value) => id = value ?? '',
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              onSaved: (value) => name = value ?? '',
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              onSaved: (value) => title = value ?? '',
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              onSaved: (value) => price = double.tryParse(value ?? '') ?? 0.0,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Image url'),
              onSaved: (value) => imageUrl = value ?? '',
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  final sneaker = Sneaker(
                    id: id,
                    name: name,
                    title: title,
                    price: price,
                    images: [imageUrl], // create a new list with the image url
                  );
                  _sneakerService.addSneaker(sneaker);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
