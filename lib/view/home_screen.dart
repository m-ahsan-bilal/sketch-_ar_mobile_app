// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sketch_ar/core/app_colors.dart';
import 'package:sketch_ar/widgets/my_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Sketch AR Home')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Trace your sketches with AR",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Text(
              'Select a sketch from our categories or import your own from the gallery.',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            CustomButton(
              title: 'Choose Sketch From Categories',

              textColor: Colors.white,
              backgroundColor: AppColors.primary,
              onTap: () {
                Navigator.pushReplacementNamed(context, '/sketch_list');
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              title: 'Import from Gallery',

              onTap: () {},
              backgroundColor: AppColors.primary30,
              textColor: AppColors.primary,
            ),
            const SizedBox(height: 30),
            Container(
              height: height * 0.39,

              width: width * 0.9,
              // margin: const EdgeInsets.only(left: 20, right: 20),
              // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: const Text(
                  'Ad Banner',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
