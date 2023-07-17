import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> addSneaker(Sneaker sneaker) async {
    await _firestore
        .collection('sneakers')
        .doc(sneaker.id)
        .set(sneaker.toJson());
  }
}
