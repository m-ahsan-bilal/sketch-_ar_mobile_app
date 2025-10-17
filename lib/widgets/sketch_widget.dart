import 'package:flutter/material.dart';
import 'package:sketch_ar/core/app_colors.dart';

class SketchWidget extends StatefulWidget {
  final String imagePath;
  final VoidCallback? onTap;

  const SketchWidget({super.key, required this.imagePath, this.onTap});

  @override
  State<SketchWidget> createState() => _SketchWidgetState();
}

class _SketchWidgetState extends State<SketchWidget> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          /// 🖼️ Image container
          Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.8))],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                cacheWidth: 300, // reduce resolution to save memory
                cacheHeight: 300,
                filterQuality: FilterQuality.low, // faster rendering
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),

          /// ❤️ Favorite icon
          Positioned(
            top: 15,
            right: 15,
            child: GestureDetector(
              onTap: () {
                setState(() => _isFavorite = !_isFavorite);
              },
              child: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),

          /// 📝 Bottom buttons (Preview + Pen)
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Preview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const ImageIcon(
                    AssetImage('assets/branding/pen.png'),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
