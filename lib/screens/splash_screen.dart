import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E7D32),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.shopping_bag,
                size: 60,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Ki Lagbe',
              style: GoogleFonts.poppins(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Bangladesh Marketplace',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}