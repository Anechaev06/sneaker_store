import 'package:flutter/material.dart';
import 'dart:io';
import '../../models/sneaker_model.dart';
import '../../services/sneaker_service.dart';

class AddSneakerPage extends StatefulWidget {
  const AddSneakerPage({Key? key}) : super(key: key);

  @override
  State<AddSneakerPage> createState() => _AddSneakerPageState();
}

class _AddSneakerPageState extends State<AddSneakerPage> {
  final _formKey = GlobalKey<FormState>();
  final _sneakerService = SneakerService();
  final _sneaker = Sneaker(
    id: '1',
    name: 'Yeezy',
    title: 'Yeezy Boost',
    price: 199.9,
    images: [],
  );
  final _imageFiles = <File>[];

  Future<void> _addImages() async {
    // Implement logic to add images
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _sneakerService.addSneaker(_sneaker, _imageFiles);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Sneaker'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
                // Add your validation and save logic here for 'name'
                ),
            TextFormField(
                // Add your validation and save logic here for 'title'
                ),
            TextFormField(
                // Add your validation and save logic here for 'price'
                ),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
