import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:material_ui/material_ui.dart';

import '../../../data/models/pov/hall_geometry.dart';
import '../../../data/models/pov/pov_camera_rig.dart';
import 'pov_scene_painter.dart';

class PovScene extends StatelessWidget {
  const PovScene({
    super.key,
    required this.rig,
    required this.hall,
    required this.highlightedSeatIds,
    required this.screenImage,
  });

  final PovCameraRig rig;
  final HallGeometry hall;
  final Set<String> highlightedSeatIds;
  final ValueListenable<ui.Image?> screenImage;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: Size.infinite,
        painter: PovScenePainter(
          rig: rig,
          hall: hall,
          highlightedSeatIds: highlightedSeatIds,
          screenImage: screenImage,
        ),
      ),
    );
  }
}
