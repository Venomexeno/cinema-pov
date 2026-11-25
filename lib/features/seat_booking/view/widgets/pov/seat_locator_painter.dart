import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/seat_map.dart';

final class SeatLocatorPainter extends CustomPainter {
  const SeatLocatorPainter({required this.seatMap, required this.seatId});

  final SeatMap seatMap;
  final String seatId;

  @override
  void paint(Canvas canvas, Size size) {
    final aisles = seatMap.blocks.length - 1;
    final columns = seatMap.seatsPerRow + aisles;
    final cell = size.width / columns;
    const top = 6.0;
    final rowStep = (size.height - top) / seatMap.rowCount;

    canvas.drawLine(
      Offset(cell, 1),
      Offset(size.width - cell, 1),
      Paint()
        ..color = AppColors.screenArc
        ..strokeWidth = 1,
    );

    final dot = Paint()..color = AppColors.textMuted;
    final current = Paint()..color = AppColors.accent;
    for (final seat in seatMap.allSeats) {
      final column = seat.number - 1 + seatMap.aislesBefore(seat.number);
      final center = Offset(
        (column + 0.5) * cell,
        top + (seat.rowIndex + 0.5) * rowStep,
      );
      final isCurrent = seat.id == seatId;
      canvas.drawCircle(
        center,
        isCurrent ? cell * 0.75 : cell * 0.28,
        isCurrent ? current : dot,
      );
    }
  }

  @override
  bool shouldRepaint(SeatLocatorPainter oldDelegate) =>
      oldDelegate.seatId != seatId || oldDelegate.seatMap != seatMap;
}
