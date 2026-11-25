import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import 'vec3.dart';

final class PovCamera {
  const PovCamera({
    required this.eye,
    required this.target,
    required this.fieldOfView,
  });

  final Vec3 eye;
  final Vec3 target;

  final double fieldOfView;

  static PovCamera lerp(PovCamera a, PovCamera b, double t) => PovCamera(
    eye: Vec3.lerp(a.eye, b.eye, t),
    target: Vec3.lerp(a.target, b.target, t),
    fieldOfView: a.fieldOfView + (b.fieldOfView - a.fieldOfView) * t,
  );

  CameraProjection projectionFor(Size size) => CameraProjection._(this, size);
}

final class CameraProjection {
  CameraProjection._(PovCamera camera, Size size)
    : _eye = camera.eye,
      _forward = (camera.target - camera.eye).normalized,
      _center = Offset(size.width / 2, size.height * _horizonRatio),
      _focal =
          size.width / 2 / math.tan(camera.fieldOfView / 2 * math.pi / 180) {
    _right = _forward.cross(const Vec3(0, 1, 0)).normalized;
    _up = _right.cross(_forward);
  }

  static const _horizonRatio =
      0.34; // the look-at point sits in the upper third
  static const _nearPlane = 0.12;

  final Vec3 _eye;
  final Vec3 _forward;
  final Offset _center;
  final double _focal;
  late final Vec3 _right;
  late final Vec3 _up;

  double depthOf(Vec3 point) => (point - _eye).dot(_forward);

  Offset? project(Vec3 point) {
    final relative = point - _eye;
    final depth = relative.dot(_forward);
    if (depth < _nearPlane) return null;
    return Offset(
      _center.dx + _focal * relative.dot(_right) / depth,
      _center.dy - _focal * relative.dot(_up) / depth,
    );
  }

  List<Offset>? projectAll(List<Vec3> points) {
    final projected = <Offset>[];
    for (final point in points) {
      final offset = project(point);
      if (offset == null) return null;
      projected.add(offset);
    }
    return projected;
  }
}
