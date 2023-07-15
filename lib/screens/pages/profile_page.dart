import 'package:flutter/material.dart';
import 'package:sneaker_store/services/auth_service.dart';
import 'package:sneaker_store/models/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final AuthService _authService = AuthService();
  UserModel _userModel = UserModel();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    UserModel userModel = await _authService.getUserData();
    setState(() {
      _userModel = userModel;
      _nameController.text = userModel.name ?? "";
      _cityController.text = userModel.city ?? "";
      _phoneController.text = userModel.phone ?? "";
      _emailController.text = userModel.email ?? "";
    });
  }

  Future<void> _updateUserData() async {
    _userModel.name = _nameController.text;
    _userModel.city = _cityController.text;
    _userModel.phone = _phoneController.text;
    // email is not updated because it's linked to the authentication
    await _authService.updateUserData(_userModel);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Name
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Your Name",
              ),
            ),
            const SizedBox(height: 15),
            // City
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Your City",
              ),
            ),
            const SizedBox(height: 15),
            // Phone
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Your Mobile Phone",
              ),
            ),
            const SizedBox(height: 15),
            // Email (disabled)
            TextField(
              controller: _emailController,
              enabled: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Your email",
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _updateUserData,
              child: const Text("Save Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
