import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/firebase_options.dart';
import 'package:sneaker_store/screens/navigation_screen.dart';
import 'package:sneaker_store/services/favorites_service.dart';
import 'package:sneaker_store/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthService()),
        ChangeNotifierProxyProvider<AuthService, FavoritesService>(
          create: (_) => FavoritesService(
              Provider.of<AuthService>(context, listen: false)),
          update: (_, authService, previous) => FavoritesService(authService),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(brightness: Brightness.light, useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const NavigationScreen(),
      ),
    );
  }
}
