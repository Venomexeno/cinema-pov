import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/pov/hall_geometry.dart';
import '../../../data/models/pov/pov_camera.dart';
import '../../../data/models/pov/pov_camera_rig.dart';
import '../../../data/models/pov/screen_homography.dart';
import '../../../data/models/pov/seat_shape.dart';
import 'screen_artwork.dart';

final class PovScenePainter extends CustomPainter {
  PovScenePainter({
    required this.rig,
    required this.hall,
    required this.highlightedSeatIds,
    required this.screenImage,
  }) : super(repaint: Listenable.merge([rig.changes, screenImage]));

  final PovCameraRig rig;
  final HallGeometry hall;
  final Set<String> highlightedSeatIds;
  final ValueListenable<ui.Image?> screenImage;

  static const _fogDistance = 26.0;
  static const _nearCull = 0.5; // anything closer would fill the view

  @override
  void paint(Canvas canvas, Size size) {
    final camera = rig.camera;
    final projection = camera.projectionFor(size);
    _paintBackdrop(canvas, size);
    _paintScreen(canvas, projection);
    _paintSeats(canvas, projection);
  }

  void _paintBackdrop(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.hallTop, AppColors.hallBottom],
        ).createShader(rect),
    );
  }

  void _paintScreen(Canvas canvas, CameraProjection projection) {
    final edges = HallGeometry.screenEdges;
    final tops = projection.projectAll([for (final edge in edges) edge.top]);
    final bottoms = projection.projectAll([
      for (final edge in edges) edge.bottom,
    ]);
    if (tops == null || bottoms == null) return;
    final outline = Path()..addPolygon([...tops, ...bottoms.reversed], true);

    canvas.drawPath(
      outline,
      Paint()
        ..color = AppColors.hallScreenSpill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60),
    );

    final strips = edges.length - 1;
    const art = ScreenArtwork.size;
    final image = screenImage.value;
    final strip = Size(art.width / strips, art.height);
    canvas
      ..save()
      ..clipPath(outline);
    for (var i = 0; i < strips; i++) {
      final transform = quadTransform(strip, [
        tops[i],
        tops[i + 1],
        bottoms[i + 1],
        bottoms[i],
      ]);
      if (transform == null) continue;
      final left = strip.width * i;
      canvas
        ..save()
        ..transform(transform)
        ..translate(-left, 0)
        // 1px overlap to hide seams between strips
        ..clipRect(Rect.fromLTWH(left - 1, 0, strip.width + 2, art.height));
      ScreenArtwork.paint(canvas, image);
      canvas.restore();
    }
    canvas.restore();

    canvas.drawPath(
      outline,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = AppColors.hallScreenFrame,
    );
  }

  void _paintSeats(Canvas canvas, CameraProjection projection) {
    final hiddenSeatId = rig.hiddenSeatId;
    final visible = [
      for (final seat in hall.seats)
        if (seat.seatId != hiddenSeatId)
          if (projection.depthOf(seat.crown) case final depth
              when depth >= _nearCull)
            (
              seat: seat,
              fog: (depth / _fogDistance).clamp(0.0, 0.75),
              depth: depth,
              highlighted: highlightedSeatIds.contains(seat.seatId),
            ),
    ]..sort((a, b) => b.depth.compareTo(a.depth));

    // Cushions first so the backs always cover them.
    for (final (:seat, :fog, :highlighted, depth: _) in visible) {
      final cushion = Color.lerp(
        _upholstery(highlighted),
        AppColors.hallSeatShadow,
        0.35,
      )!;
      _paintCushion(canvas, projection, seat, cushion, fog);
    }
    for (final (:seat, :fog, :highlighted, depth: _) in visible) {
      _paintBack(
        canvas,
        projection,
        seat,
        _upholstery(highlighted),
        _sheen(highlighted),
        fog,
      );
    }
  }

  void _paintCushion(
    Canvas canvas,
    CameraProjection projection,
    SeatShape seat,
    Color color,
    double fog,
  ) {
    final corners = projection.projectAll(seat.cushion);
    if (corners == null) return;
    canvas.drawPath(
      Path()..addPolygon(corners, true),
      Paint()..color = _fogged(color, fog),
    );
  }

  void _paintBack(
    Canvas canvas,
    CameraProjection projection,
    SeatShape seat,
    Color upholstery,
    Color sheen,
    double fog,
  ) {
    final corners = projection.projectAll(seat.back);
    final crown = projection.project(seat.crown);
    if (corners == null || crown == null) return;
    final [topLeft, topRight, bottomRight, bottomLeft] = corners;

    final shape = Path()
      ..moveTo(bottomLeft.dx, bottomLeft.dy)
      ..lineTo(topLeft.dx, topLeft.dy)
      ..quadraticBezierTo(crown.dx, crown.dy, topRight.dx, topRight.dy)
      ..lineTo(bottomRight.dx, bottomRight.dy)
      ..close();

    final bottomMid = Offset.lerp(bottomLeft, bottomRight, 0.5)!;
    canvas.drawPath(
      shape,
      Paint()
        ..shader = ui.Gradient.linear(
          crown,
          bottomMid,
          [
            _fogged(sheen, fog),
            _fogged(upholstery, fog),
            _fogged(AppColors.hallSeatShadow, fog),
          ],
          const [0, 0.35, 1],
        ),
    );
  }

  static Color _upholstery(bool highlighted) =>
      highlighted ? AppColors.accent : AppColors.hallSeat;

  static Color _sheen(bool highlighted) =>
      highlighted ? AppColors.accent : AppColors.hallSeatHighlight;

  static Color _fogged(Color color, double fog) =>
      Color.lerp(color, AppColors.hallBottom, fog)!;

  @override
  bool shouldRepaint(PovScenePainter oldDelegate) =>
      oldDelegate.rig != rig ||
      oldDelegate.highlightedSeatIds != highlightedSeatIds ||
      oldDelegate.screenImage != screenImage;
}
