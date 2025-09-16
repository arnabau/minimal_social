import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social/auth/auth.dart';
import 'package:minimal_social/auth/login_register.dart';
import 'package:minimal_social/firebase_options.dart';
import 'package:minimal_social/pages/home_page.dart';
import 'package:minimal_social/pages/profile_page.dart';
import 'package:minimal_social/pages/theme/dark_mode.dart';
import 'package:minimal_social/pages/theme/light_mode.dart';
import 'package:minimal_social/pages/users_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_register': (context) => const LoginRegister(),
        '/home_page': (context) => HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/users_page': (context) => const UsersPage(),
      },
    );
  }
}
