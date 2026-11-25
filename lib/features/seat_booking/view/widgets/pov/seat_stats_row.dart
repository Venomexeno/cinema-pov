import 'package:material_ui/material_ui.dart';

import '../../../data/models/pov/seat_view_stats.dart';
import 'seat_stat_card.dart';

class SeatStatsRow extends StatelessWidget {
  const SeatStatsRow({super.key, required this.stats});

  final SeatViewStats stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SeatStatCard(value: stats.distanceLabel, caption: 'to screen'),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SeatStatCard(
            value: stats.fieldOfViewLabel,
            caption: 'field of view',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SeatStatCard(
            value: stats.offsetLabel,
            caption: stats.offsetCaption,
          ),
        ),
      ],
    );
  }
}
