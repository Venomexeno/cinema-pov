import 'dart:math' as math;

import '../seat.dart';
import '../seat_map.dart';
import 'pov_camera.dart';
import 'seat_shape.dart';
import 'seat_view_stats.dart';
import 'vec3.dart';

final class HallGeometry {
  HallGeometry(this._seatMap);

  final SeatMap _seatMap;

  // IMAX-like screen, wider than the seating block.
  static const screenWidth = 17.0;
  static const screenHeight = 8.9;
  static const screenBottom = 1.0;
  static const _firstRowDistance = 7.5;
  static const _rowPitch = 1.05;
  static const _rake = 0.4; // steep stadium step per row
  static const _eyeHeight = 1.15;
  static const _seatWidth = 0.62;
  static const _aisleWidth = 1.1;
  static const _backOffset = 0.36; // seat back sits behind its occupant
  static const _backBottom = 0.38;
  static const _backTop = 0.98;
  static const _backHalfWidth = 0.27;
  static const _headTilt = 0.25;
  static const _cushionHeight = 0.45;
  static const _cushionFront = 0.22; // in front of the occupant
  static const _cushionRear = 0.3;

  static const _fovMargin = 8.0;
  static const _minSeatFov = 72.0;
  static const _maxSeatFov = 114.0;

  static const _overviewFov = 34.0;
  static const _overviewDistance = 31.0;
  static const _overviewElevation = 55 * math.pi / 180;

  static const _screenCurveDepth = 0.9;
  static const _screenStrips = 16;

  static const screenCenter = Vec3(0, screenBottom + screenHeight / 2, 0);

  static final List<({Vec3 top, Vec3 bottom})> screenEdges = List.unmodifiable([
    for (var i = 0; i <= _screenStrips; i++) _screenEdgeAt(i / _screenStrips),
  ]);

  static ({Vec3 top, Vec3 bottom}) _screenEdgeAt(double u) {
    final x = (u - 0.5) * screenWidth;
    final z = _screenCurveDepth * math.pow(2 * u - 1, 2);
    return (
      top: Vec3(x, screenBottom + screenHeight, z),
      bottom: Vec3(x, screenBottom, z),
    );
  }

  late final double _rowWidth =
      _seatMap.seatsPerRow * _seatWidth +
      (_seatMap.blocks.length - 1) * _aisleWidth;

  late final List<SeatShape> seats = List.unmodifiable(
    _seatMap.allSeats.map(_shapeOf),
  );

  double _seatX(Seat seat) =>
      -_rowWidth / 2 +
      (seat.number - 0.5) * _seatWidth +
      _seatMap.aislesBefore(seat.number) * _aisleWidth;

  double _rowZ(int rowIndex) => _firstRowDistance + rowIndex * _rowPitch;

  double _floorY(int rowIndex) => rowIndex * _rake;

  Vec3 eyeOf(Seat seat) => Vec3(
    _seatX(seat),
    _floorY(seat.rowIndex) + _eyeHeight,
    _rowZ(seat.rowIndex),
  );

  PovCamera cameraFor(Seat seat) {
    final eye = eyeOf(seat);
    return PovCamera(
      eye: eye,
      target: Vec3(0, eye.y + (screenCenter.y - eye.y) * _headTilt, 0),
      fieldOfView: (statsFor(seat).fieldOfView + _fovMargin).clamp(
        _minSeatFov,
        _maxSeatFov,
      ),
    );
  }

  PovCamera get overview {
    final target = Vec3(0, 1.5, _rowZ(_seatMap.rowCount ~/ 2) - 2.5);
    final lift =
        Vec3(0, math.sin(_overviewElevation), math.cos(_overviewElevation)) *
        _overviewDistance;
    return PovCamera(
      eye: target + lift,
      target: target,
      fieldOfView: _overviewFov,
    );
  }

  SeatViewStats statsFor(Seat seat) {
    final x = _seatX(seat);
    final z = _rowZ(seat.rowIndex);
    final eye = eyeOf(seat);
    const halfWidth = screenWidth / 2;
    final toEdges = z - _screenCurveDepth;
    final fov =
        math.atan((halfWidth - x) / toEdges) +
        math.atan((halfWidth + x) / toEdges);
    return SeatViewStats(
      distance: (screenCenter - eye).length,
      fieldOfView: fov * 180 / math.pi,
      offset: x,
    );
  }

  SeatShape _shapeOf(Seat seat) {
    final x = _seatX(seat);
    final rowZ = _rowZ(seat.rowIndex);
    final floor = _floorY(seat.rowIndex);
    final left = x - _backHalfWidth;
    final right = x + _backHalfWidth;

    final cushionY = floor + _cushionHeight;
    final cushionFront = rowZ - _cushionFront;
    final cushionRear = rowZ + _cushionRear;

    final backZ = rowZ + _backOffset;
    final top = floor + _backTop;
    final bottom = floor + _backBottom;

    return SeatShape(
      seatId: seat.id,
      cushion: [
        Vec3(left, cushionY, cushionFront),
        Vec3(right, cushionY, cushionFront),
        Vec3(right, cushionY, cushionRear),
        Vec3(left, cushionY, cushionRear),
      ],
      back: [
        Vec3(left, top, backZ),
        Vec3(right, top, backZ),
        Vec3(right, bottom, backZ),
        Vec3(left, bottom, backZ),
      ],
      crown: Vec3(x, top + 0.07, backZ),
    );
  }
}
