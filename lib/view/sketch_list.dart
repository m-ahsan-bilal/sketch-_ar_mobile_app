// lib/view/sketch_grid_page.dart
import 'package:flutter/material.dart';
import 'package:sketch_ar/core/service/supabase_service.dart';
import 'package:sketch_ar/view/sketch_screen.dart';
import 'package:sketch_ar/widgets/sketch_widget.dart';

class SketchGridPage extends StatefulWidget {
  const SketchGridPage({super.key});

  @override
  _SketchGridPageState createState() => _SketchGridPageState();
}

class _SketchGridPageState extends State<SketchGridPage> {
  List<String> _imageUrls = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final urls = await SupabaseService.instance.getImageUrls();
    setState(() {
      _imageUrls = urls;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_imageUrls.isEmpty) {
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

        body: const Center(child: Text('No images found ')),
      );
    }

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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: _imageUrls.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final url = _imageUrls[index];
            return SketchWidget(
              imageUrl: url,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FinalSketchScreen(imagePath: url),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
