import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sketch_ar/view/home_screen.dart';
import 'package:sketch_ar/view/sketch_list.dart';
import 'package:sketch_ar/view/sketch_screen.dart';
import 'package:sketch_ar/view/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://funkqyfjkejaskgvqxqr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ1bmtxeWZqa2VqYXNrZ3ZxeHFyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjExMjY1MzcsImV4cCI6MjA3NjcwMjUzN30.BO-nNy5s1bnVhHIFsXK3Un7KWKxje_VS-1EA8ETQ6DE',
  );
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
