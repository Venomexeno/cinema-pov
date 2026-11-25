import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../data/models/requsts/booking_request.dart';
import '../../../data/models/seat.dart';
import '../../../data/models/seat_map.dart';
import '../../../data/models/pov/seat_view_stats.dart';
import '../book_button.dart';
import 'pov_seat_details.dart';

class PovSeatSheet extends StatelessWidget {
  const PovSeatSheet({
    super.key,
    required this.seat,
    required this.stats,
    required this.seatMap,
    required this.request,
    required this.totalLabel,
  });

  final Seat seat;
  final SeatViewStats stats;
  final SeatMap seatMap;
  final BookingRequest request;
  final String totalLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 14),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: PovSeatDetails(
                key: ValueKey(seat.id),
                seat: seat,
                stats: stats,
                seatMap: seatMap,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton.outlined(
                    label: 'Change seat',
                    onPressed: () => Navigator.maybePop(context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: BookButton.book(
                    request: request,
                    totalLabel: totalLabel,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
