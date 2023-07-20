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
      QuerySnapshot querySnapshot =
          await _firestore.collection('sneakers').get();
      return querySnapshot.docs
          .map((doc) => Sneaker.fromJson(doc.data() as Map<String, dynamic>))
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
    String fileName = basename(imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('sneakers/$brand/$id/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<List<String>> uploadImages(
      List<File> imageFiles, String id, String brand) async {
    return Future.wait(imageFiles
        .map((imageFile) => uploadImageToFirebase(imageFile, id, brand)));
  }

  Future<void> addSneaker(Sneaker sneaker, List<File> imageFiles) async {
    List<String> imageUrls =
        await uploadImages(imageFiles, sneaker.id, sneaker.brand);
    sneaker = Sneaker(
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
        .set(sneaker.toJson());
  }

  Future<Sneaker> getSneakerById(String id) async {
    DocumentSnapshot docSnapshot =
        await _firestore.collection('sneakers').doc(id).get();
    return Sneaker.fromJson(docSnapshot.data() as Map<String, dynamic>);
  }

  Future<List<String>> getSneakerImagesByBrand(String brand) async {
    List<String> imageUrls = [];
    ListResult listResult =
        await FirebaseStorage.instance.ref('sneakers/$brand').listAll();
    for (Reference ref in listResult.items) {
      String url = await ref.getDownloadURL();
      imageUrls.add(url);
    }
    return imageUrls;
  }

  Future<void> deleteSneaker(String id) async {
    await _firestore.collection('sneakers').doc(id).delete();
  }

  Future<List<Sneaker>> getSneakersByBrand(String brand) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('sneakers')
          .where('brand', isEqualTo: brand)
          .get();
      return querySnapshot.docs
          .map((doc) => Sneaker.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error fetching sneakers');
    }
  }
}
