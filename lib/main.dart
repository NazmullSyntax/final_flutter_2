import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const KiLagbeApp());
}

class KiLagbeApp extends StatelessWidget {
  const KiLagbeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ki Lagbe - Bangladesh Marketplace',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF2E7D32),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2E7D32),
          secondary: Color(0xFFFF6F00),
        ),
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 2,
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF2E7D32),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF4CAF50),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF4CAF50),
          secondary: Color(0xFFFF9800),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          elevation: 2,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}