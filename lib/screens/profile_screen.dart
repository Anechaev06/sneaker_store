import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              () {},
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
              () {
                FirebaseAuth.instance.signOut();
              },
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
