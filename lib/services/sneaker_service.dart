import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sneaker_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SneakerService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Sneaker>> getSneakers() async {
    try {
      final querySnapshot = await _firestore.collection('sneakers').get();
      return querySnapshot.docs
          .map((doc) => Sneaker.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error fetching sneakers');
    }
  }

  Stream<QuerySnapshot> getSneakersStream() {
    return _firestore.collection('sneakers').snapshots();
  }

  Future<String> uploadImageToFirebase(
      File imageFile, String id, String brand) async {
    final fileName = basename(imageFile.path);
    final firebaseStorageRef =
        FirebaseStorage.instance.ref().child('sneakers/$brand/$id/$fileName');
    final uploadTask = firebaseStorageRef.putFile(imageFile);
    final taskSnapshot = await uploadTask;
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<List<String>> uploadImages(
      List<File> imageFiles, String id, String brand) async {
    return Future.wait(imageFiles
        .map((imageFile) => uploadImageToFirebase(imageFile, id, brand)));
  }

  Future<void> addSneaker(Sneaker sneaker, List<File> imageFiles) async {
    final imageUrls = await uploadImages(imageFiles, sneaker.id, sneaker.brand);
    final updatedSneaker = Sneaker(
      id: sneaker.id,
      name: sneaker.name,
      price: sneaker.price,
      brand: sneaker.brand,
      description: sneaker.description,
      images: imageUrls,
    );
    await _firestore
        .collection('sneakers')
        .doc(sneaker.id)
        .set(updatedSneaker.toJson());
  }

  Future<Sneaker> getSneakerById(String id) async {
    final docSnapshot = await _firestore.collection('sneakers').doc(id).get();
    return Sneaker.fromJson(docSnapshot.data() as Map<String, dynamic>);
  }

  Future<List<String>> getSneakerImagesByBrand(String brand) async {
    final imageUrls = <String>[];
    final listResult =
        await FirebaseStorage.instance.ref('sneakers/$brand').listAll();
    for (final ref in listResult.items) {
      final url = await ref.getDownloadURL();
      imageUrls.add(url);
    }
    return imageUrls;
  }

  Future<void> deleteSneaker(String id) async {
    await _firestore.collection('sneakers').doc(id).delete();
  }

  Future<List<Sneaker>> getSneakersByBrand(String brand) async {
    try {
      final querySnapshot = await _firestore
          .collection('sneakers')
          .where('brand', isEqualTo: brand)
          .get();
      return querySnapshot.docs
          .map((doc) => Sneaker.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error fetching sneakers');
    }
  }

  Future<List<Sneaker>> getSneakersByName(String name) async {
    try {
      final querySnapshot = await _firestore
          .collection('sneakers')
          .where('name', isGreaterThanOrEqualTo: name)
          .where('name', isLessThan: '${name}z')
          .get();
      return querySnapshot.docs
          .map((doc) => Sneaker.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error fetching sneakers');
    }
  }

  Future<List<String>> getBrands() async {
    try {
      final querySnapshot = await _firestore.collection('sneakers').get();
      final brands = querySnapshot.docs
          .map((doc) => (doc.data())['brand'] as String)
          .toSet()
          .toList();
      brands.sort();
      return brands;
    } catch (e) {
      throw Exception('Error fetching brands');
    }
  }
}
