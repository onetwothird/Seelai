import 'package:flutter/material.dart';
import 'auth/theme.dart';
import 'auth/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AuthTheme.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AuthTheme.theme,
      home: const LoginPage(),
      builder: (context, child) {
        return AuthTheme.wrapWithSystemUI(child: child!);
      },
    );
  }
}