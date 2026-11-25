import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/widgets/app_toast.dart';
import '../../../cubit/booking/booking_cubit.dart';
import '../../../cubit/booking/booking_state.dart';
import '../../../cubit/seat_map/seat_map_cubit.dart';
import '../../../cubit/seat_selection/seat_selection_cubit.dart';

class BookingResultBlocListener
    extends BlocListener<BookingCubit, BookingState> {
  const BookingResultBlocListener({super.key, super.child})
    : super(listener: _onResult);

  static void _onResult(BuildContext context, BookingState state) {
    switch (state) {
      case BookingSuccess(:final confirmation):
        AppToast.show(context, confirmation.message);
        final selection = context.read<SeatSelectionCubit>();
        selection.reset(selection.state.showtimeId);
        context.read<SeatMapCubit>().refresh();
      case BookingFailure(:final message):
        AppToast.show(context, message);
      case BookingInitial() || BookingLoading():
        break;
    }
  }
}
