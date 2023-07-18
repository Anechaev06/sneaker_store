import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../models/sneaker_model.dart';
import '../../services/sneaker_service.dart';

class NewSneakerPage extends StatefulWidget {
  const NewSneakerPage({super.key});

  @override
  State<NewSneakerPage> createState() => _NewSneakerPageState();
}

class _NewSneakerPageState extends State<NewSneakerPage> {
  final _formKey = GlobalKey<FormState>();
  final _sneakerService = SneakerService();
  String id = '';
  String title = '';
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
            // Adding Images here
            ElevatedButton(
              onPressed: pickImages,
              child: const Text('Pick Images'),
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
                    images: [],
                  );
                  _sneakerService.addSneaker(sneaker, images);
                  _formKey.currentState?.reset();
                  setState(() {
                    images.clear();
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
