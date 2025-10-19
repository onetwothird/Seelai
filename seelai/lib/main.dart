import 'package:flutter/material.dart';
import 'package:seelai/mobile/auth_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Optional: removes debug banner
      home: AuthLayout(), // Changed from OnboardingScreen to AuthLayout
    );
  }
}