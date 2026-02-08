import 'package:flutter/material.dart';
import 'package:to_do_list/screens/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO Do List',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff222222),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7C7CFF),
          surface: Color(0xFF0F172A),
          error: Color(0xFFF87171),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFE5E7EB), fontSize: 16),
          bodyMedium: TextStyle(
            color: Color(0xFF94A3B8),
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Color(0xff222222),
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      home: Homepage(),
    );
  }
}
