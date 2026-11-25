import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/models/seat_row.dart';
import 'seat_grid_item.dart';

class SeatRowView extends StatelessWidget {
  const SeatRowView({super.key, required this.row, required this.aisleAfter});

  final SeatRow row;
  final Set<int> aisleAfter;

  static const _aisleWidth = 10.0;
  static const _letterWidth = 14.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: _letterWidth,
          child: Text(row.letter, style: AppTextStyles.rowLetter),
        ),
        for (final seat in row.seats) ...[
          Expanded(child: SeatGridItem(seat: seat)),
          if (aisleAfter.contains(seat.number))
            const SizedBox(width: _aisleWidth),
        ],
        const SizedBox(width: _letterWidth),
      ],
    );
  }
}
