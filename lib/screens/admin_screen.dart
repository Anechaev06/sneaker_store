import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
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
  String brand = '';
  String description = '';
  double price = 0.0;
  List<File> images = [];
  final ImagePicker _picker = ImagePicker();

  Future pickImages() async {
    final pickedImages = await _picker.pickMultiImage();
    setState(() => images = pickedImages.map((i) => File(i.path)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: id,
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
              initialValue: name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Name'),
              onSaved: (value) => name = value ?? '',
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: brand, // Add this block
              decoration: InputDecoration(
                labelText: 'Brand',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onSaved: (value) => brand = value ?? '',
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: description,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onSaved: (value) => description = value ?? '',
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: price.toString(),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Price'),
              onSaved: (value) => price = double.tryParse(value ?? '') ?? 0.0,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: pickImages,
              child: const Text('Pick Images'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                child: const Text('Add Sneaker'),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    final sneaker = Sneaker(
                      id: id,
                      name: name,
                      price: price,
                      brand: brand,
                      description: description,
                      images: [],
                    );
                    _sneakerService.addSneaker(sneaker, images);
                    _formKey.currentState?.reset();
                    setState(() => images.clear());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
