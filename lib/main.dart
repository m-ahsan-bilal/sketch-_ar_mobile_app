import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sketch_ar/view/home_screen.dart';
import 'package:sketch_ar/view/sketch_list.dart';
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
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// // main.dart
// // ignore_for_file: use_build_context_synchronously, deprecated_member_use

// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   final firstCamera = cameras.isNotEmpty ? cameras.first : null;
//   runApp(MyApp(camera: firstCamera));
// }

// class MyApp extends StatelessWidget {
//   final CameraDescription? camera;
//   const MyApp({super.key, required this.camera});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'AR Sketch Tracer',
//       theme: ThemeData(
//         useMaterial3: true,
//         brightness: Brightness.dark,
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: Colors.blue,
//           brightness: Brightness.dark,
//         ),
//       ),
//       home: HomeScreen(camera: camera),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   final CameraDescription? camera;
//   const HomeScreen({super.key, required this.camera});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('AR Sketch Tracer'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: camera == null
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.disabled_by_default,
//                     size: 64,
//                     color: Colors.grey[600],
//                   ),
//                   const SizedBox(height: 16),
//                   const Text('No camera found'),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Please check your device permissions',
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 ],
//               ),
//             )
//           : CameraOverlayScreen(camera: camera!),
//     );
//   }
// }

// class CameraOverlayScreen extends StatefulWidget {
//   final CameraDescription camera;
//   const CameraOverlayScreen({super.key, required this.camera});

//   @override
//   State<CameraOverlayScreen> createState() => _CameraOverlayScreenState();
// }

// class _CameraOverlayScreenState extends State<CameraOverlayScreen>
//     with WidgetsBindingObserver {
//   late CameraController _controller;
//   bool _cameraInitialized = false;

//   ui.Image? overlayImage;
//   double overlayOpacity = 0.6;

//   Offset overlayOffset = Offset.zero;
//   double overlayScale = 1.0;
//   double overlayRotation = 0.0;

//   Offset _lastFocalPoint = Offset.zero;
//   double _startScale = 1.0;
//   double _startRotation = 0.0;

//   List<Offset?> strokes = [];
//   bool drawMode = false;

//   Color brushColor = Colors.red;
//   double brushSize = 4.0;
//   String? lastSavedPath;
//   bool showGridlines = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _initCamera();
//   }

//   Future<void> _initCamera() async {
//     _controller = CameraController(
//       widget.camera,
//       ResolutionPreset.high,
//       enableAudio: false,
//     );
//     await _controller.initialize();
//     if (!mounted) return;
//     setState(() => _cameraInitialized = true);
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _controller.dispose();
//     overlayImage?.dispose();
//     super.dispose();
//   }

//   Future<void> pickFromGallery() async {
//     final XFile? file = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );
//     if (file == null) return;
//     await _loadUiImage(File(file.path));
//   }

//   Future<void> pickAsset(String assetPath) async {
//     try {
//       final data = await DefaultAssetBundle.of(context).load(assetPath);
//       final bytes = data.buffer.asUint8List();
//       final temp = await _bytesToImage(bytes);
//       setState(() => overlayImage = temp);
//     } catch (e) {
//       debugPrint('Error loading asset: $e');
//     }
//   }

//   Future<void> _loadUiImage(File file) async {
//     final bytes = await file.readAsBytes();
//     final img = await _bytesToImage(bytes);
//     setState(() => overlayImage = img);
//   }

//   Future<ui.Image> _bytesToImage(Uint8List bytes) async {
//     final codec = await ui.instantiateImageCodec(bytes);
//     final frame = await codec.getNextFrame();
//     return frame.image;
//   }

//   Future<String?> saveSnapshot() async {
//     if (!_cameraInitialized) return null;
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final fileName = 'sketch_${DateTime.now().millisecondsSinceEpoch}.png';
//       final path = '${directory.path}/$fileName';

//       final XFile raw = await _controller.takePicture();
//       final rawFile = File(raw.path);
//       final rawBytes = await rawFile.readAsBytes();
//       final decoded = await _bytesToImage(rawBytes);

//       final recorder = ui.PictureRecorder();
//       final canvas = Canvas(recorder);

//       final paint = Paint();
//       canvas.drawImageRect(
//         decoded,
//         Rect.fromLTWH(
//           0,
//           0,
//           decoded.width.toDouble(),
//           decoded.height.toDouble(),
//         ),
//         Rect.fromLTWH(
//           0,
//           0,
//           decoded.width.toDouble(),
//           decoded.height.toDouble(),
//         ),
//         paint,
//       );

//       if (overlayImage != null) {
//         final w = overlayImage!.width.toDouble();
//         final h = overlayImage!.height.toDouble();
//         final centerX = decoded.width / 2 + overlayOffset.dx;
//         final centerY = decoded.height / 2 + overlayOffset.dy;

//         canvas.save();
//         canvas.translate(centerX, centerY);
//         canvas.rotate(overlayRotation);
//         canvas.scale(overlayScale, overlayScale);
//         final dst = Rect.fromLTWH(-w / 2, -h / 2, w, h);
//         paint.color = Colors.white.withOpacity(overlayOpacity);
//         canvas.drawImageRect(
//           overlayImage!,
//           Rect.fromLTWH(0, 0, w, h),
//           dst,
//           paint,
//         );
//         canvas.restore();
//       }

//       final strokePaint = Paint()
//         ..color = brushColor
//         ..strokeWidth = brushSize
//         ..strokeCap = StrokeCap.round
//         ..strokeJoin = StrokeJoin.round;

//       for (int i = 0; i < strokes.length - 1; i++) {
//         final a = strokes[i];
//         final b = strokes[i + 1];
//         if (a != null && b != null) {
//           final ax = a.dx / MediaQuery.of(context).size.width * decoded.width;
//           final ay = a.dy / MediaQuery.of(context).size.height * decoded.height;
//           final bx = b.dx / MediaQuery.of(context).size.width * decoded.width;
//           final by = b.dy / MediaQuery.of(context).size.height * decoded.height;
//           canvas.drawLine(Offset(ax, ay), Offset(bx, by), strokePaint);
//         }
//       }

//       final picture = recorder.endRecording();
//       final img = await picture.toImage(decoded.width, decoded.height);
//       final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);

//       final out = File(path);
//       await out.writeAsBytes(pngBytes!.buffer.asUint8List());
//       setState(() => lastSavedPath = out.path);
//       return out.path;
//     } catch (e) {
//       debugPrint('saveSnapshot error: $e');
//       return null;
//     }
//   }

//   void _onScaleStart(ScaleStartDetails details) {
//     _lastFocalPoint = details.focalPoint;
//     _startScale = overlayScale;
//     _startRotation = overlayRotation;
//   }

//   void _onScaleUpdate(ScaleUpdateDetails details) {
//     final dx = details.focalPoint.dx - _lastFocalPoint.dx;
//     final dy = details.focalPoint.dy - _lastFocalPoint.dy;
//     _lastFocalPoint = details.focalPoint;

//     setState(() {
//       overlayOffset += Offset(dx, dy);
//       overlayScale = (_startScale * details.scale).clamp(0.1, 6.0);
//       overlayRotation = _startRotation + details.rotation;
//     });
//   }

//   void _resetOverlay() {
//     setState(() {
//       overlayOffset = Offset.zero;
//       overlayScale = 1.0;
//       overlayRotation = 0.0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 if (_cameraInitialized)
//                   CameraPreview(_controller)
//                 else
//                   const Center(child: CircularProgressIndicator()),

//                 if (overlayImage != null)
//                   Positioned.fill(
//                     child: GestureDetector(
//                       behavior: HitTestBehavior.translucent,
//                       onScaleStart: _onScaleStart,
//                       onScaleUpdate: _onScaleUpdate,
//                       child: CustomPaint(
//                         size: Size.infinite,
//                         painter: OverlayPainter(
//                           image: overlayImage!,
//                           offset: overlayOffset,
//                           scale: overlayScale,
//                           rotation: overlayRotation,
//                           opacity: overlayOpacity,
//                           showGridlines: showGridlines,
//                         ),
//                       ),
//                     ),
//                   ),

//                 Positioned.fill(
//                   child: GestureDetector(
//                     onPanDown: (d) {
//                       if (!drawMode) return;
//                       setState(
//                         () =>
//                             strokes = List.from(strokes)..add(d.localPosition),
//                       );
//                     },
//                     onPanUpdate: (d) {
//                       if (!drawMode) return;
//                       setState(
//                         () =>
//                             strokes = List.from(strokes)..add(d.localPosition),
//                       );
//                     },
//                     onPanEnd: (d) {
//                       if (!drawMode) return;
//                       setState(() => strokes.add(null));
//                     },
//                     child: CustomPaint(
//                       painter: StrokePainter(strokes, brushColor, brushSize),
//                     ),
//                   ),
//                 ),

//                 Positioned(
//                   top: 16,
//                   right: 16,
//                   child: Column(
//                     children: [
//                       FloatingActionButton.small(
//                         onPressed: () {
//                           setState(() => showGridlines = !showGridlines);
//                         },
//                         tooltip: 'Toggle gridlines',
//                         child: Icon(
//                           showGridlines ? Icons.grid_on : Icons.grid_off,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       FloatingActionButton.small(
//                         onPressed: _resetOverlay,
//                         tooltip: 'Reset overlay',
//                         child: const Icon(Icons.restart_alt),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Drawing Controls
//           if (drawMode)
//             Container(
//               padding: const EdgeInsets.all(12),
//               color: Colors.black54,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Text(
//                           'Brush Size',
//                           style: TextStyle(fontSize: 12),
//                         ),
//                         Slider(
//                           value: brushSize,
//                           onChanged: (v) => setState(() => brushSize = v),
//                           min: 1.0,
//                           max: 20.0,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   GestureDetector(
//                     onTap: () {
//                       _showColorPicker();
//                     },
//                     child: Container(
//                       width: 48,
//                       height: 48,
//                       decoration: BoxDecoration(
//                         color: brushColor,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(color: Colors.white, width: 2),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//           // Opacity Control
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             color: Colors.black87,
//             child: Row(
//               children: [
//                 const Icon(Icons.opacity, size: 20),
//                 const SizedBox(width: 12),
//                 const Text('Overlay', style: TextStyle(fontSize: 12)),
//                 Expanded(
//                   child: Slider(
//                     value: overlayOpacity,
//                     onChanged: (v) => setState(() => overlayOpacity = v),
//                     min: 0.0,
//                     max: 1.0,
//                   ),
//                 ),
//                 Text(
//                   '${(overlayOpacity * 100).toInt()}%',
//                   style: const TextStyle(fontSize: 12),
//                 ),
//               ],
//             ),
//           ),

//           // Bottom Controls
//           Container(
//             color: Colors.black54,
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             child: SafeArea(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     IconButton.filledTonal(
//                       icon: const Icon(Icons.photo_library),
//                       onPressed: pickFromGallery,
//                       tooltip: 'Pick from gallery',
//                     ),
//                     const SizedBox(width: 8),
//                     PopupMenuButton<String>(
//                       tooltip: 'Load asset sketch',
//                       icon: const Icon(Icons.collections),
//                       onSelected: (path) => pickAsset(path),
//                       itemBuilder: (_) => [
//                         const PopupMenuItem(
//                           value: 'assets/models/cat.png',
//                           child: Row(
//                             children: [
//                               Icon(Icons.pets),
//                               SizedBox(width: 8),
//                               Text('Cat'),
//                             ],
//                           ),
//                         ),
//                         const PopupMenuItem(
//                           value: 'assets/models/dog.png',
//                           child: Row(
//                             children: [
//                               Icon(Icons.pets),
//                               SizedBox(width: 8),
//                               Text('Dog'),
//                             ],
//                           ),
//                         ),
//                         const PopupMenuItem(
//                           value: 'assets/models/dancingflower.png',
//                           child: Row(
//                             children: [
//                               Icon(Icons.local_florist),
//                               SizedBox(width: 8),
//                               Text('Rose'),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(width: 8),
//                     IconButton.filledTonal(
//                       icon: Icon(drawMode ? Icons.brush : Icons.pan_tool),
//                       onPressed: () => setState(() => drawMode = !drawMode),
//                       tooltip: drawMode ? 'Drawing mode' : 'Transform mode',
//                     ),
//                     const SizedBox(width: 8),
//                     IconButton.filledTonal(
//                       icon: const Icon(Icons.delete_outline),
//                       onPressed: () => setState(() => strokes.clear()),
//                       tooltip: 'Clear strokes',
//                     ),
//                     const SizedBox(width: 8),
//                     IconButton.filledTonal(
//                       icon: const Icon(Icons.camera_alt),
//                       onPressed: () async {
//                         final path = await saveSnapshot();
//                         if (path != null) {
//                           _showSaveDialog(context, path);
//                         }
//                       },
//                       tooltip: 'Capture sketch',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showColorPicker() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Choose Brush Color'),
//         content: SingleChildScrollView(
//           child: Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children:
//                 [
//                       Colors.red,
//                       Colors.blue,
//                       Colors.green,
//                       Colors.yellow,
//                       Colors.purple,
//                       Colors.orange,
//                       Colors.cyan,
//                       Colors.pink,
//                       Colors.white,
//                       Colors.black,
//                     ]
//                     .map(
//                       (color) => GestureDetector(
//                         onTap: () {
//                           setState(() => brushColor = color);
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             color: color,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(
//                               color: brushColor == color
//                                   ? Colors.white
//                                   : Colors.transparent,
//                               width: 2,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                     .toList(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showSaveDialog(BuildContext context, String path) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.check_circle, size: 48, color: Colors.green),
//             const SizedBox(height: 16),
//             const Text('Sketch saved successfully!'),
//             const SizedBox(height: 24),
//             Row(
//               children: [
//                 Expanded(
//                   child: FilledButton.tonal(
//                     onPressed: () => Navigator.pop(context),
//                     child: const Text('Close'),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: FilledButton(
//                     onPressed: () {
//                       Share.shareXFiles([XFile(path)]);
//                       Navigator.pop(context);
//                     },
//                     child: const Text('Share'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OverlayPainter extends CustomPainter {
//   final ui.Image image;
//   final Offset offset;
//   final double scale;
//   final double rotation;
//   final double opacity;
//   final bool showGridlines;

//   OverlayPainter({
//     required this.image,
//     required this.offset,
//     required this.scale,
//     required this.rotation,
//     required this.opacity,
//     this.showGridlines = false,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..filterQuality = FilterQuality.high;
//     paint.color = Color.fromRGBO(255, 255, 255, opacity);

//     final imgW = image.width.toDouble();
//     final imgH = image.height.toDouble();
//     final center = Offset(size.width / 2, size.height / 2) + offset;

//     canvas.save();
//     canvas.translate(center.dx, center.dy);
//     canvas.rotate(rotation);
//     canvas.scale(scale, scale);

//     final dst = Rect.fromCenter(center: Offset.zero, width: imgW, height: imgH);
//     canvas.drawImageRect(image, Rect.fromLTWH(0, 0, imgW, imgH), dst, paint);

//     if (showGridlines) {
//       final gridPaint = Paint()
//         ..color = Colors.cyan.withOpacity(0.3)
//         ..strokeWidth = 1.0;
//       const gridSpacing = 40.0;
//       for (double x = -imgW / 2; x <= imgW / 2; x += gridSpacing) {
//         canvas.drawLine(Offset(x, -imgH / 2), Offset(x, imgH / 2), gridPaint);
//       }
//       for (double y = -imgH / 2; y <= imgH / 2; y += gridSpacing) {
//         canvas.drawLine(Offset(-imgW / 2, y), Offset(imgW / 2, y), gridPaint);
//       }
//     }

//     canvas.restore();
//   }

//   @override
//   bool shouldRepaint(covariant OverlayPainter old) {
//     return old.image != image ||
//         old.offset != offset ||
//         old.scale != scale ||
//         old.rotation != rotation ||
//         old.opacity != opacity ||
//         old.showGridlines != showGridlines;
//   }
// }

// class StrokePainter extends CustomPainter {
//   final List<Offset?> strokes;
//   final Color color;
//   final double size;

//   StrokePainter(this.strokes, this.color, this.size);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final p = Paint()
//       ..color = color
//       ..strokeCap = StrokeCap.round
//       ..strokeJoin = StrokeJoin.round
//       ..strokeWidth = this.size;

//     for (int i = 0; i < strokes.length - 1; i++) {
//       final a = strokes[i];
//       final b = strokes[i + 1];
//       if (a != null && b != null) {
//         canvas.drawLine(a, b, p);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant StrokePainter old) =>
//       old.strokes != strokes || old.color != color || old.size != size;
// }
