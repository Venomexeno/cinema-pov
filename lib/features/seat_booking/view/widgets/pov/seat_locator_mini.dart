import 'package:material_ui/material_ui.dart';

import '../../../data/models/seat_map.dart';
import 'seat_locator_painter.dart';

class SeatLocatorMini extends StatelessWidget {
  const SeatLocatorMini({
    super.key,
    required this.seatMap,
    required this.seatId,
  });

  final SeatMap seatMap;
  final String seatId;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(48, 40),
      painter: SeatLocatorPainter(seatMap: seatMap, seatId: seatId),
    );
  }
}
