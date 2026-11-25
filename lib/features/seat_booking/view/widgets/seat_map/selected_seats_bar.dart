import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../cubit/booking/booking_cubit.dart';
import '../../../cubit/seat_map/seat_map_cubit.dart';
import '../../../cubit/seat_map/seat_map_state.dart';
import '../../../cubit/seat_selection/seat_selection_cubit.dart';
import '../../../data/models/requsts/booking_request.dart';
import '../../screens/pov_screen.dart';
import '../../view_values/pov_view_values.dart';
import '../book_button.dart';
import 'selection_bar_frame.dart';

class SelectedSeatsBar extends StatelessWidget {
  const SelectedSeatsBar({
    super.key,
    required this.seatsLabel,
    required this.totalLabel,
    required this.request,
  });

  final String seatsLabel;
  final String totalLabel;
  final BookingRequest request;

  @override
  Widget build(BuildContext context) {
    return SelectionBarFrame(
      summary: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            seatsLabel,
            style: AppTextStyles.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(totalLabel, style: AppTextStyles.price),
        ],
      ),
      actions: [
        SizedBox(
          width: 104,
          child: PrimaryButton.outlined(
            label: 'See POV',
            onPressed: () => _openPov(context),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 104,
          child: BookButton.continueAction(request: request),
        ),
      ],
    );
  }

  void _openPov(BuildContext context) {
    final selection = context.read<SeatSelectionCubit>().state;
    final seatMapState = context.read<SeatMapCubit>().state;
    if (selection.isEmpty || seatMapState is! SeatMapSuccess) return;
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 380),
        reverseTransitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, _, _) => MultiBlocProvider(
          providers: [
            BlocProvider<BookingCubit>.value(
              value: context.read<BookingCubit>(),
            ),
            BlocProvider<SeatSelectionCubit>.value(
              value: context.read<SeatSelectionCubit>(),
            ),
          ],
          child: PovScreen(
            values: PovViewValues(),
            selection: selection,
            seatMap: seatMapState.seatMap,
          ),
        ),
        transitionsBuilder: (_, animation, _, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }
}
