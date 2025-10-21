import 'package:flutter/material.dart';
import 'package:sketch_ar/core/media_list.dart';
import 'package:sketch_ar/view/sketch_screen.dart';
import 'package:sketch_ar/widgets/sketch_widget.dart';

class SketchGridPage extends StatelessWidget {
  final MediaList mediaList = MediaList();
  SketchGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    final images = mediaList.allImages;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sketch Category'),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
          child: SketchWidget(
            imagePath: "assets/models/chef boy.png",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FinalSketchScreen(
                    imagePath: "assets/models/chef boy.png",
                  ),
                ),
              );
            },
          ),
        ),
      ),
      // body: GridView.builder(
      //   padding: const EdgeInsets.all(10),
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     crossAxisSpacing: 8,
      //     mainAxisSpacing: 8,
      //   ),
      //   itemCount: images.length,
      //   itemBuilder: (context, index) {
      //     final imagePath = images[index];

      //     return SketchWidget(
      //       key: ValueKey(imagePath),
      //       imagePath: imagePath,
      //       onTap: () {
      //         MaterialPageRoute(
      //           builder: (context) => FinalSketchScreen(imagePath: imagePath),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
