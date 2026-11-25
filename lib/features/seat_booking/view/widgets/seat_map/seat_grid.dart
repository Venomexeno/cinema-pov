import 'package:material_ui/material_ui.dart';

import '../../../data/models/seat_map.dart';
import 'seat_row_view.dart';

class SeatGrid extends StatelessWidget {
  const SeatGrid({super.key, required this.seatMap});

  final SeatMap seatMap;

  @override
  Widget build(BuildContext context) {
    final aisleAfter = seatMap.aisleAfterNumbers;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final row in seatMap.rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: SeatRowView(row: row, aisleAfter: aisleAfter),
          ),
      ],
    );
  }
}
