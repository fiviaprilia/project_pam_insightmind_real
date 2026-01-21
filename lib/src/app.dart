// lib/src/app.dart
import 'package:flutter/material.dart';
import 'features/insightmind/presentation/pages/login_page.dart';

class InsightMindApp extends StatelessWidget {
  const InsightMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InsightMind',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FC), // WEEK5: Soft background
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Poppins', fontSize: 14),
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}