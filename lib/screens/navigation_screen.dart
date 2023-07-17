import 'package:firebase_auth/firebase_auth.dart';
import 'package:sneaker_store/screens/admin_screen.dart';
import 'package:sneaker_store/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_store/constants/colors.dart';
import 'package:sneaker_store/screens/auth/auth_screen.dart';
import 'package:sneaker_store/screens/profile_screen.dart';
import 'package:sneaker_store/screens/favorites_screen.dart';
import 'package:sneaker_store/screens/home_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sneaker_store/screens/cart_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  final AuthService _authService = AuthService();
  bool _isAdmin = false;

  void _onTap(int index) => setState(() => _selectedIndex = index);

  Future<void> checkAdmin(User? user) async {
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      _isAdmin = userDoc.get('isAdmin') ?? false;
    } else {
      _isAdmin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: _authService.authStateChanges,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          User? user = snapshot.data;

          checkAdmin(user);

          List<Widget> screens = [
            const HomeScreen(),
            const FavoritesScreen(),
            _isAdmin
                ? const AdminScreen()
                : const CartScreen(), // Only for admins
            user == null ? const AuthScreen() : const ProfileScreen(),
          ];

          return SafeArea(
            child: Scaffold(
              body: IndexedStack(
                index: _selectedIndex,
                children: screens,
              ),
              bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: GNav(
                    tabBorderRadius: 50,
                    onTabChange: (index) => _onTap(index),
                    tabActiveBorder: Border.all(color: Colors.black, width: 2),
                    selectedIndex: _selectedIndex,
                    tabBorder: Border.all(color: Colors.black, width: 2),
                    backgroundColor: Colors.black,
                    color: Colors.white,
                    activeColor: secondColor,
                    tabBackgroundColor: primaryColor,
                    duration: const Duration(milliseconds: 150),
                    gap: 5,
                    tabs: [
                      const GButton(
                        icon: Icons.home_rounded,
                        text: "Home",
                      ),
                      const GButton(
                          icon: Icons.favorite_rounded, text: "Likes"),
                      GButton(
                          icon: _isAdmin
                              ? Icons.admin_panel_settings
                              : Icons.shopping_cart_rounded,
                          text: _isAdmin ? "Admin" : "Cart"),
                      const GButton(
                          icon: Icons.person_rounded, text: "Profile"),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
