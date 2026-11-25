import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/widgets/app_toast.dart';
import '../../../cubit/seat_selection/seat_selection_cubit.dart';
import '../../../cubit/seat_selection/seat_selection_state.dart';

class SelectionLimitBlocListener
    extends BlocListener<SeatSelectionCubit, SeatSelectionState> {
  const SelectionLimitBlocListener({super.key, super.child})
    : super(listener: _showLimit);

  static void _showLimit(BuildContext context, SeatSelectionState state) {
    if (state case SeatSelectionLimitReached(:final message)) {
      AppToast.show(context, message);
    }
  }
}
