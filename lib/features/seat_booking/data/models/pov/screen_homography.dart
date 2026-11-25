import 'dart:typed_data';

import 'package:material_ui/material_ui.dart';

// Maps `Offset.zero & source` onto a quad (tl, tr, br, bl).
Float64List? quadTransform(Size source, List<Offset> quad) {
  final [p0, p1, p2, p3] = quad;
  final dx1 = p1.dx - p2.dx, dx2 = p3.dx - p2.dx;
  final dy1 = p1.dy - p2.dy, dy2 = p3.dy - p2.dy;
  final sx = p0.dx - p1.dx + p2.dx - p3.dx;
  final sy = p0.dy - p1.dy + p2.dy - p3.dy;
  final det = dx1 * dy2 - dx2 * dy1;
  if (det.abs() < 1e-9) return null;

  // Unit square -> quad (Heckbert).
  final g = (sx * dy2 - dx2 * sy) / det;
  final h = (dx1 * sy - sx * dy1) / det;
  final a = p1.dx - p0.dx + g * p1.dx;
  final b = p3.dx - p0.dx + h * p3.dx;
  final d = p1.dy - p0.dy + g * p1.dy;
  final e = p3.dy - p0.dy + h * p3.dy;

  final w = source.width, ht = source.height;
  // Column-major 4x4 with the projective terms in the last row.
  return Float64List.fromList([
    a / w, d / w, 0, g / w, //
    b / ht, e / ht, 0, h / ht,
    0, 0, 1, 0,
    p0.dx, p0.dy, 0, 1,
  ]);
}
