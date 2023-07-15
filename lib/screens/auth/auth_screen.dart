import 'package:flutter/material.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // initially, show the login page
  bool showSignInScreen = true;

  void togglePages() => setState(() => showSignInScreen = !showSignInScreen);

  @override
  Widget build(BuildContext context) {
    if (showSignInScreen) {
      return SignInScreen(
        showSignUpScreen: togglePages,
      );
    } else {
      return SignUpScreen(
        showSignInScreen: togglePages,
      );
    }
  }
}
