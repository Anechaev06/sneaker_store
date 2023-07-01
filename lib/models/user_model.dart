import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:sneaker_store/services/auth_service.dart';

class UserModel extends ChangeNotifier {
  UserModel(this._authService) {
    _authService.user.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  final AuthService _authService;
  User? _user;

  User? get user => _user;
}
