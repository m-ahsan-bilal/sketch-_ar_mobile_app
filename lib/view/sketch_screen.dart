import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FinalSketchScreen extends StatefulWidget {
  final String imagePath; // This will be the asset path of the selected image

  const FinalSketchScreen({super.key, required this.imagePath});

  @override
  State<FinalSketchScreen> createState() => _FinalSketchScreenState();
}

class _FinalSketchScreenState extends State<FinalSketchScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  double _opacity = 0.7;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _initCamera();
    precacheImage(AssetImage(widget.imagePath), context);
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras!.first,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _cameraController!.initialize();
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draw Sketch'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/sketch_list');
          },
          icon: Icon(Icons.add_ic_call_rounded),
        ),
      ),
      body: Stack(
        children: [
          /// 📸 Camera Preview
          if (_cameraController != null &&
              _cameraController!.value.isInitialized)
            CameraPreview(_cameraController!)
          else
            const Center(child: CircularProgressIndicator()),

          /// 🖼️ Sketch Image Overlay
          Center(
            child: GestureDetector(
              onScaleUpdate: (details) {
                setState(() {
                  _scale = details.scale.clamp(0.5, 3.0);
                });
              },
              child: Opacity(
                opacity: _opacity,
                child: Transform.scale(
                  scale: _scale,
                  child: Image.asset(widget.imagePath, fit: BoxFit.contain),
                ),
              ),
            ),
          ),

          /// 🔙 Top App Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.4),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),

          /// ⚡ Controls (bottom)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Opacity Slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Opacity", style: TextStyle(color: Colors.white)),
                      Icon(Icons.opacity, color: Colors.white),
                    ],
                  ),
                  Slider(
                    value: _opacity,
                    onChanged: (value) {
                      setState(() => _opacity = value);
                    },
                    min: 0.1,
                    max: 1.0,
                    activeColor: Colors.white,
                  ),
                  const SizedBox(height: 10),

                  // Scale Slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Size", style: TextStyle(color: Colors.white)),
                      Icon(Icons.zoom_out_map, color: Colors.white),
                    ],
                  ),
                  Slider(
                    value: _scale,
                    onChanged: (value) {
                      setState(() => _scale = value);
                    },
                    min: 0.5,
                    max: 3.0,
                    activeColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
