import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sneaker_model.dart';

class SneakerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get a list of all sneakers
  Future<List<Sneaker>> getSneakers() async {
    QuerySnapshot querySnapshot = await _firestore.collection('sneakers').get();
    return querySnapshot.docs
        .map((doc) => Sneaker.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Get a single sneaker by its ID
  Future<Sneaker> getSneakerById(String id) async {
    DocumentSnapshot docSnapshot =
        await _firestore.collection('sneakers').doc(id).get();
    return Sneaker.fromJson(docSnapshot.data() as Map<String, dynamic>);
  }

  // Add a new sneaker to Firestore
  Future<void> addSneaker(Sneaker sneaker) {
    return _firestore.collection('sneakers').doc(sneaker.id).set({
      'name': sneaker.name,
      'title': sneaker.title,
      'price': sneaker.price,
      'images': sneaker.images,
    });
  }
}
