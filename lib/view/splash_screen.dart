import 'package:flutter/material.dart';
import 'dart:async';

class SplashOnboardingScreen extends StatefulWidget {
  const SplashOnboardingScreen({super.key});

  @override
  State<SplashOnboardingScreen> createState() => _SplashOnboardingScreenState();
}

class _SplashOnboardingScreenState extends State<SplashOnboardingScreen> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = const Color(0xff13A4EC);
    final Color backgroundLight = const Color(0xFFF6F7F8);
    final Color backgroundDark = const Color(0xFF101C22);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? backgroundDark
          : backgroundLight,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _showSplash
            ? _buildSplash(primary, backgroundDark, backgroundLight)
            : _buildOnboarding(primary, backgroundDark, backgroundLight),
      ),
    );
  }

  Widget _buildSplash(Color primary, Color bgDark, Color bgLight) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      key: const ValueKey('splash'),
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
              color: isDark ? bgLight : bgDark,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboarding(Color primary, Color bgDark, Color bgLight) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      key: const ValueKey('onboarding'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 2 / 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: Image.asset('assets/branding/logo.png').image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(primary, active: true),
                _buildDot(primary.withOpacity(0.2)),
                _buildDot(primary.withOpacity(0.2)),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              "Choose Sketch",
              style: TextStyle(
                color: isDark ? bgLight : bgDark,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Select a sketch from our library or import your own.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: (isDark ? bgLight : bgDark).withOpacity(0.7),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(Color color, {bool active = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
