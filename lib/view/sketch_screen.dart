// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class FinalSketchScreen extends StatefulWidget {
//   final String imagePath;

//   const FinalSketchScreen({super.key, required this.imagePath});

//   @override
//   State<FinalSketchScreen> createState() => _FinalSketchScreenState();
// }

// class _FinalSketchScreenState extends State<FinalSketchScreen> {
//   CameraController? _cameraController;
//   List<CameraDescription>? _cameras;
//   double _opacity = 0.7;
//   double _scale = 1.0;
//   Offset _position = Offset.zero;
//   bool _showControls = true;
//   FlashMode _flashMode = FlashMode.off;

//   @override
//   void initState() {
//     super.initState();
//     _initCamera();
//   }

//   Future<void> _initCamera() async {
//     _cameras = await availableCameras();
//     if (_cameras != null && _cameras!.isNotEmpty) {
//       _cameraController = CameraController(
//         _cameras!.first,
//         ResolutionPreset.high,
//         enableAudio: false,
//       );
//       await _cameraController!.initialize();
//       if (mounted) setState(() {});
//     }
//   }

//   Future<void> _toggleFlash() async {
//     if (_cameraController == null) return;

//     setState(() {
//       _flashMode = _flashMode == FlashMode.off
//           ? FlashMode.torch
//           : FlashMode.off;
//     });

//     await _cameraController!.setFlashMode(_flashMode);
//   }

//   void _resetPosition() {
//     setState(() {
//       _position = Offset.zero;
//       _scale = 1.0;
//       _opacity = 0.7;
//     });
//   }

//   @override
//   void dispose() {
//     _cameraController?.dispose();
//     super.dispose();
//   }

//   bool get _isNetworkImage {
//     return widget.imagePath.startsWith('http://') ||
//         widget.imagePath.startsWith('https://');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pushReplacementNamed(context, '/sketch_list');
//           },
//           icon: Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.5),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
//           ),
//         ),
//         actions: [
//           // Flash toggle
//           IconButton(
//             onPressed: _toggleFlash,
//             icon: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.5),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 _flashMode == FlashMode.torch
//                     ? Icons.flash_on
//                     : Icons.flash_off,
//                 color: _flashMode == FlashMode.torch
//                     ? Colors.yellow
//                     : Colors.white,
//               ),
//             ),
//           ),
//           // Reset button
//           IconButton(
//             onPressed: _resetPosition,
//             icon: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.5),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(Icons.refresh, color: Colors.white),
//             ),
//           ),
//           // Toggle controls
//           IconButton(
//             onPressed: () {
//               setState(() => _showControls = !_showControls);
//             },
//             icon: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.5),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 _showControls ? Icons.visibility : Icons.visibility_off,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           // Camera preview
//           if (_cameraController != null &&
//               _cameraController!.value.isInitialized)
//             Positioned.fill(child: CameraPreview(_cameraController!))
//           else
//             const Center(child: CircularProgressIndicator(color: Colors.white)),

//           // Sketch overlay
//           Positioned.fill(
//             child: GestureDetector(
//               onScaleStart: (details) {
//                 // Store initial position
//               },
//               onScaleUpdate: (details) {
//                 setState(() {
//                   // Handle zoom
//                   _scale = (_scale * details.scale).clamp(0.3, 4.0);

//                   // Handle pan (move)
//                   if (details.pointerCount == 1) {
//                     _position += details.focalPointDelta;
//                   }
//                 });
//               },
//               child: Center(
//                 child: Transform.translate(
//                   offset: _position,
//                   child: Opacity(
//                     opacity: _opacity,
//                     child: Transform.scale(
//                       scale: _scale,
//                       child: _isNetworkImage
//                           ? CachedNetworkImage(
//                               imageUrl: widget.imagePath,
//                               fit: BoxFit.contain,
//                               placeholder: (context, url) => Container(
//                                 width: 200,
//                                 height: 200,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: const Center(
//                                   child: CircularProgressIndicator(
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               errorWidget: (context, url, error) => Container(
//                                 width: 200,
//                                 height: 200,
//                                 decoration: BoxDecoration(
//                                   color: Colors.red.withOpacity(0.2),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: const Center(
//                                   child: Icon(
//                                     Icons.error_outline,
//                                     color: Colors.white,
//                                     size: 48,
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : Image.asset(widget.imagePath, fit: BoxFit.contain),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Hint text (only show initially)
//           if (_scale == 1.0 && _position == Offset.zero)
//             Positioned(
//               top: 100,
//               left: 0,
//               right: 0,
//               child: IgnorePointer(
//                 child: AnimatedOpacity(
//                   opacity: 0.7,
//                   duration: const Duration(seconds: 2),
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 32),
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.6),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Text(
//                       '👆 Pinch to zoom • Drag to move',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.white, fontSize: 14),
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//           // Controls panel
//           if (_showControls)
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                     colors: [
//                       Colors.black.withOpacity(0.8),
//                       Colors.black.withOpacity(0.4),
//                       Colors.transparent,
//                     ],
//                   ),
//                 ),
//                 child: SafeArea(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Opacity control
//                       _buildControlRow(
//                         icon: Icons.opacity,
//                         label: 'Opacity',
//                         value: _opacity,
//                         onChanged: (value) {
//                           setState(() => _opacity = value);
//                         },
//                         min: 0.1,
//                         max: 1.0,
//                       ),
//                       const SizedBox(height: 16),

//                       // Size control
//                       _buildControlRow(
//                         icon: Icons.zoom_out_map,
//                         label: 'Size',
//                         value: _scale.clamp(1.0, 2.5),
//                         onChanged: (value) {
//                           setState(() => _scale = value);
//                         },
//                         min: 0.3,
//                         max: 4.0,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//           // Quick stats overlay
//           if (_showControls)
//             Positioned(
//               bottom: 200,
//               right: 16,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 8,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.6),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       '${(_scale * 100).toInt()}%',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '${(_opacity * 100).toInt()}%',
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.7),
//                         fontSize: 10,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

// ignore_for_file: deprecated_member_use

//   Widget _buildControlRow({
//     required IconData icon,
//     required String label,
//     required double value,
//     required ValueChanged<double> onChanged,
//     required double min,
//     required double max,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(icon, color: Colors.white, size: 20),
//                   const SizedBox(width: 8),
//                   Text(
//                     label,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               Text(
//                 '${(value * 100).toInt()}%',
//                 style: const TextStyle(
//                   color: Colors.white70,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           SliderTheme(
//             data: SliderThemeData(
//               trackHeight: 4,
//               thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
//               overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
//               activeTrackColor: Colors.white,
//               inactiveTrackColor: Colors.white.withOpacity(0.3),
//               thumbColor: Colors.white,
//               overlayColor: Colors.white.withOpacity(0.2),
//             ),
//             child: Slider(
//               value: value,
//               onChanged: onChanged,
//               min: min,
//               max: max,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FinalSketchScreen extends StatefulWidget {
  final String imagePath;

  const FinalSketchScreen({super.key, required this.imagePath});

  @override
  State<FinalSketchScreen> createState() => _FinalSketchScreenState();
}

class _FinalSketchScreenState extends State<FinalSketchScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  double _opacity = 0.7;
  double _scale = 1.0;
  Offset _position = Offset.zero;
  bool _showControls = true;
  bool _isLocked = false;
  FlashMode _flashMode = FlashMode.off;

  @override
  void initState() {
    super.initState();
    _initCamera();
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

  Future<void> _toggleFlash() async {
    if (_cameraController == null) return;

    setState(() {
      _flashMode = _flashMode == FlashMode.off
          ? FlashMode.torch
          : FlashMode.off;
    });

    await _cameraController!.setFlashMode(_flashMode);
  }

  void _resetPosition() {
    setState(() {
      _position = Offset.zero;
      _scale = 1.5; // Standardized size
      _opacity = 0.7;
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  bool get _isNetworkImage {
    return widget.imagePath.startsWith('http://') ||
        widget.imagePath.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/sketch_list');
          },
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          ),
        ),
        actions: [
          // Flash toggle
          IconButton(
            onPressed: _toggleFlash,
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _flashMode == FlashMode.torch
                    ? Icons.flash_on
                    : Icons.flash_off,
                color: _flashMode == FlashMode.torch
                    ? Colors.yellow
                    : Colors.white,
              ),
            ),
          ),
          // Lock/Unlock button
          IconButton(
            onPressed: () {
              setState(() => _isLocked = !_isLocked);
            },
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _isLocked
                    ? Colors.green.withOpacity(0.7)
                    : Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isLocked ? Icons.lock : Icons.lock_open,
                color: Colors.white,
              ),
            ),
          ),
          // Reset button
          IconButton(
            onPressed: _resetPosition,
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.refresh, color: Colors.white),
            ),
          ),
          // Toggle controls
          IconButton(
            onPressed: () {
              setState(() => _showControls = !_showControls);
            },
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _showControls ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera preview
          if (_cameraController != null &&
              _cameraController!.value.isInitialized)
            Positioned.fill(child: CameraPreview(_cameraController!))
          else
            const Center(child: CircularProgressIndicator(color: Colors.white)),

          // Sketch overlay
          Positioned.fill(
            child: GestureDetector(
              onScaleStart: _isLocked
                  ? null
                  : (details) {
                      // Store initial position
                    },
              onScaleUpdate: _isLocked
                  ? null
                  : (details) {
                      setState(() {
                        // Handle zoom
                        _scale = (_scale * details.scale).clamp(0.8, 3.0);

                        // Handle pan (move)
                        if (details.pointerCount == 1) {
                          _position += details.focalPointDelta;
                        }
                      });
                    },
              child: Center(
                child: Transform.translate(
                  offset: _position,
                  child: Opacity(
                    opacity: _opacity,
                    child: Transform.scale(
                      scale: _scale,
                      child: _isNetworkImage
                          ? CachedNetworkImage(
                              imageUrl: widget.imagePath,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.error_outline,
                                    color: Colors.white,
                                    size: 48,
                                  ),
                                ),
                              ),
                            )
                          : Image.asset(widget.imagePath, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Hint text (only show initially)
          if (_scale == 1.5 && _position == Offset.zero && !_isLocked)
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: AnimatedOpacity(
                  opacity: 0.7,
                  duration: const Duration(seconds: 2),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '👆 Pinch to zoom • Drag to move • Lock when ready',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),

          // Locked indicator
          if (_isLocked)
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.lock, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Locked On - Ready to sketch!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Controls panel
          if (_showControls && !_isLocked)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Opacity control
                      _buildControlRow(
                        icon: Icons.opacity,
                        label: 'Opacity',
                        value: _opacity,
                        onChanged: (value) {
                          setState(() => _opacity = value);
                        },
                        min: 0.1,
                        max: 1.0,
                      ),
                      const SizedBox(height: 16),

                      // Size control
                      _buildControlRow(
                        icon: Icons.zoom_out_map,
                        label: 'Size',
                        value: _scale.clamp(0.8, 2.0),
                        onChanged: (value) {
                          setState(() => _scale = value);
                        },
                        min: 0.8,
                        max: 2.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Quick stats overlay
          // if (_showControls)
          //   Positioned(
          //     bottom: 200,
          //     right: 16,
          //     child: Container(
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: 12,
          //         vertical: 8,
          //       ),
          //       decoration: BoxDecoration(
          //         color: Colors.black.withOpacity(0.6),
          //         borderRadius: BorderRadius.circular(20),
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Text(
          //             '${(_scale * 100).toInt()}%',
          //             style: const TextStyle(
          //               color: Colors.white,
          //               fontSize: 12,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           const SizedBox(height: 4),
          //           Text(
          //             '${(_opacity * 100).toInt()}%',
          //             style: TextStyle(
          //               color: Colors.white.withOpacity(0.7),
          //               fontSize: 10,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  Widget _buildControlRow({
    required IconData icon,
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
    required double min,
    required double max,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white.withOpacity(0.3),
              thumbColor: Colors.white,
              overlayColor: Colors.white.withOpacity(0.2),
            ),
            child: Slider(
              value: value,
              onChanged: onChanged,
              min: min,
              max: max,
            ),
          ),
        ],
      ),
    );
  }
}
