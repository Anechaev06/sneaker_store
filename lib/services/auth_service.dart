import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sneaker_store/models/user_model.dart';
import 'package:sneaker_store/models/sneaker_model.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> getCurrentUser() async => _auth.currentUser;

  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp({required String email, required String password}) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserModel> getUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final docSnapshot =
          await _firestore.collection('users').doc(user.uid).get();
      if (docSnapshot.exists && docSnapshot.data() != null) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        return UserModel(
          name: data['name'],
          city: data['city'],
          phone: data['phone'],
          email: data['email'],
        );
      }
    }
    return UserModel();
  }

  Future<void> updateUserData(UserModel userModel) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'name': userModel.name,
        'city': userModel.city,
        'phone': userModel.phone,
      });
    }
  }

  Future<void> createUserData(String email) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'name': '',
        'city': '',
        'phone': '',
        'email': email,
      });
    }
  }

  Future<void> signOut() async => await _auth.signOut();

  Future<void> addFavoriteSneaker(Sneaker sneaker) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(sneaker.id)
          .set(sneaker.toJson());
    }
  }

  Future<void> removeFavoriteSneaker(Sneaker sneaker) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(sneaker.id)
          .delete();
    }
  }

  Future<List<Sneaker>> getFavoriteSneakers() async {
    final user = _auth.currentUser;
    List<Sneaker> favorites = [];
    if (user != null) {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .get();
      favorites = querySnapshot.docs
          .map((doc) => Sneaker.fromJson(doc.data()))
          .toList();
    }
    return favorites;
  }

  Future<bool> isAdmin() async {
    final user = _auth.currentUser;
    if (user != null) {
      final docSnapshot =
          await _firestore.collection('users').doc(user.uid).get();
      if (docSnapshot.exists && docSnapshot.data() != null) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        return data['isAdmin'] ?? false;
      }
    }
    return false;
  }
}
