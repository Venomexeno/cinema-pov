import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../cubit/screening/screening_cubit.dart';
import '../../../cubit/screening/screening_state.dart';
import '../../../cubit/seat_map/seat_map_cubit.dart';
import '../../../cubit/seat_selection/seat_selection_cubit.dart';

class ShowtimeChangeBlocListener
    extends BlocListener<ScreeningCubit, ScreeningState> {
  const ShowtimeChangeBlocListener({
    super.key,
    super.child,
  }) : super(listenWhen: _showtimeChanged, listener: _loadSeats);

  static bool _showtimeChanged(
    ScreeningState previous,
    ScreeningState current,
  ) =>
      current.selectedShowtimeId != null &&
      previous.selectedShowtimeId != current.selectedShowtimeId;

  static void _loadSeats(BuildContext context, ScreeningState state) {
    final showtimeId = state.selectedShowtimeId;
    if (showtimeId == null) return;
    context.read<SeatSelectionCubit>().reset(showtimeId);
    context.read<SeatMapCubit>().load(showtimeId);
  }
}
