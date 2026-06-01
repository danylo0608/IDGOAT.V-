import 'package:flutter/material.dart';
import 'package:idgoat/screens/login/login_screen.dart';
import 'package:idgoat/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IDGOAT',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Roboto', // Можеш замінити на свій шрифт
      ),
      home: const LoginScreen(),
    );
  }
}
