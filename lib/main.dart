import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'theme_casino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Casino App',
      theme: casinoTheme,
      home: const HomeScreen(),
    );
  }
}