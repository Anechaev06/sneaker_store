import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/constants/colors.dart';
import 'package:sneaker_store/models/user_model.dart';
import 'package:sneaker_store/screens/auth/auth_screen.dart';
import 'package:sneaker_store/screens/profile_screen.dart';
import 'package:sneaker_store/screens/cart_screen.dart';
import 'package:sneaker_store/screens/favorites_screen.dart';
import 'package:sneaker_store/screens/home_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late List<Widget> _screens;
  int _selectedIndex = 0;

  void _onTap(int index) => setState(() => _selectedIndex = index);

  @override
  void didChangeDependencies() {
    final userModel = Provider.of<UserModel>(context);
    _screens = [
      const HomeScreen(),
      const FavoritesScreen(),
      const CartScreen(),
      userModel.user != null ? const ProfileScreen() : const AuthScreen(),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens.elementAt(_selectedIndex),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
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
              tabs: const [
                GButton(
                  icon: Icons.home_rounded,
                  text: "Home",
                ),
                GButton(icon: Icons.favorite_rounded, text: "Likes"),
                GButton(icon: Icons.shopping_cart_rounded, text: "Cart"),
                GButton(icon: Icons.person_rounded, text: "Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
