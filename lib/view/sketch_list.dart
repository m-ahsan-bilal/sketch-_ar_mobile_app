import 'package:flutter/material.dart';
import 'package:sketch_ar/core/media_list.dart';

class SketchGridPage extends StatelessWidget {
  final MediaList mediaList = MediaList();
  SketchGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    final images = mediaList.allImages;

    return Scaffold(
      appBar: AppBar(title: Text('Sketch Category')),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              debugPrint('Selected: ${images[index]}');
            },
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: Image.asset(images[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
