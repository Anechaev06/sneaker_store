import 'package:flutter/material.dart';
import 'package:sneaker_store/screens/pages/profile_page.dart';
import 'package:sneaker_store/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildButton(
              "Profile",
              "your information",
              Icons.person_rounded,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              ),
            ),
            buildButton(
              "My Orders",
              "keep track of current orders",
              Icons.list_alt_rounded,
              () {},
            ),
            buildButton(
              "Stores Location",
              "find out where the nearest stores are",
              Icons.location_on_rounded,
              () {},
            ),
            buildButton(
              "Delivery And Payment",
              "find out all payment and delivery options",
              Icons.payment_rounded,
              () {},
            ),
            buildButton(
              "Feedback",
              "ask us a question",
              Icons.feedback_rounded,
              () {},
            ),
            buildButton(
              "Sign Out",
              "sign out of your account",
              Icons.logout_rounded,
              () => AuthService().signOut(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(
    String title,
    String subTitle,
    IconData icon,
    Function onPressed,
  ) {
    return SizedBox(
      width: 350,
      child: OutlinedButton(
        onPressed: () => onPressed(),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(subTitle),
        ),
      ),
    );
  }
}
