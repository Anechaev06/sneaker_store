import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import '../models/sneaker_model.dart';

class SneakerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Sneaker>> getSneakers() async {
    QuerySnapshot querySnapshot = await _firestore.collection('sneakers').get();
    return querySnapshot.docs
        .map((doc) => Sneaker.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<Sneaker> getSneakerById(String id) async {
    DocumentSnapshot docSnapshot =
        await _firestore.collection('sneakers').doc(id).get();
    return Sneaker.fromJson(docSnapshot.data() as Map<String, dynamic>);
  }

  Future<String> uploadImage(File file) async {
    String fileName = basename(file.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('sneakers/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(file);
    await uploadTask.whenComplete(() {
      print('File Upload Complete');
    });
    String downloadUrl = await firebaseStorageRef.getDownloadURL();
    return downloadUrl;
  }

  Future<void> addSneaker(Sneaker sneaker, List<File> imageFiles) async {
    List<String> imageUrls = [];
    for (File imageFile in imageFiles) {
      String imageUrl = await uploadImage(imageFile);
      imageUrls.add(imageUrl);
    }
    return _firestore.collection('sneakers').doc(sneaker.id).set({
      'name': sneaker.name,
      'title': sneaker.title,
      'price': sneaker.price,
      'images': imageUrls,
    });
  }
}
