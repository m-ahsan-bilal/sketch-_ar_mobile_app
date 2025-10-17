import 'package:flutter/material.dart';
import 'dart:async';

class SplashOnboardingScreen extends StatefulWidget {
  const SplashOnboardingScreen({super.key});

  @override
  State<SplashOnboardingScreen> createState() => _SplashOnboardingScreenState();
}

class _SplashOnboardingScreenState extends State<SplashOnboardingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1200), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xff13A4EC);
    final Color backgroundLight = const Color(0xFFF6F7F8);
    final Color backgroundDark = const Color(0xFF101C22);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? backgroundDark
          : backgroundLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/branding/logo.png',
              width: 100,
              height: 100,
              color: primary,
            ),
            const SizedBox(height: 20),
            Text(
              "Sketch AR",
              style: TextStyle(
                color: isDark ? backgroundLight : backgroundDark,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
