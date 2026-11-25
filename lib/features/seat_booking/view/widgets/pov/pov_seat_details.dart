import 'package:material_ui/material_ui.dart';

import '../../../../../core/extensions/price_format.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/models/seat.dart';
import '../../../data/models/seat_map.dart';
import '../../../data/models/pov/seat_view_stats.dart';
import 'seat_locator_mini.dart';
import 'seat_stats_row.dart';

class PovSeatDetails extends StatelessWidget {
  const PovSeatDetails({
    super.key,
    required this.seat,
    required this.stats,
    required this.seatMap,
  });

  final Seat seat;
  final SeatViewStats stats;
  final SeatMap seatMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    seat.zone.label.toUpperCase(),
                    style: AppTextStyles.overline,
                  ),
                  const SizedBox(height: 6),
                  Text(seat.title, style: AppTextStyles.seatTitle),
                  const SizedBox(height: 2),
                  Text(
                    '${seat.kind.label} · ${seat.price.euro}',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            SeatLocatorMini(seatMap: seatMap, seatId: seat.id),
          ],
        ),
        const SizedBox(height: 16),
        SeatStatsRow(stats: stats),
      ],
    );
  }
}
