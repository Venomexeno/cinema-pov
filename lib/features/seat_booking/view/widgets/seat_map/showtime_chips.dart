import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/showtime.dart';
import 'showtime_chip.dart';

class ShowtimeChips extends StatelessWidget {
  const ShowtimeChips({
    super.key,
    required this.showtimes,
    required this.selectedShowtimeId,
    required this.onSelected,
  });

  final List<Showtime> showtimes;
  final String selectedShowtimeId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.all(3),
        decoration: const ShapeDecoration(
          color: AppColors.surface,
          shape: StadiumBorder(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final showtime in showtimes)
              ShowtimeChip(
                time: showtime.time,
                format: showtime.format,
                isSelected: showtime.id == selectedShowtimeId,
                onTap: () => onSelected(showtime.id),
              ),
          ],
        ),
      ),
    );
  }
}
