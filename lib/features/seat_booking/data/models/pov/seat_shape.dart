import 'vec3.dart';

final class SeatShape {
  const SeatShape({
    required this.seatId,
    required this.cushion,
    required this.back,
    required this.crown,
  });

  final String seatId;

  final List<Vec3> cushion;

  final List<Vec3> back;

  final Vec3 crown;
}
