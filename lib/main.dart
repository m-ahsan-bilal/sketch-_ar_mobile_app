import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sketch_ar/view/home_screen.dart';
import 'package:sketch_ar/view/sketch_list.dart';
import 'package:sketch_ar/view/sketch_screen.dart';
import 'package:sketch_ar/view/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Sketch Tracer',
      theme: ThemeData(
        // fontFamily: 'SpaceGrotesk',
        textTheme: GoogleFonts.spaceGroteskTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF13a4ec)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashOnboardingScreen(),
        '/home': (context) => const HomeScreen(),
        '/sketch_list': (context) => SketchGridPage(),
        '/final_sketch': (context) => const FinalSketchScreen(imagePath: ''),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
