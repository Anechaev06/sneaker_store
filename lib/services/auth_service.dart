import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneaker_store/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp({required String email, required String password}) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserModel> getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(user.uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
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
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'name': userModel.name,
        'city': userModel.city,
        'phone': userModel.phone,
        // email is not updated because it's linked to the authentication
      });
    }
  }

  Future<void> createUserData(String email) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'name': '',
        'city': '',
        'phone': '',
        'email': email,
      });
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
