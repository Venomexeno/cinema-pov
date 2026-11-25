import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../cubit/seat_selection/seat_selection_cubit.dart';
import '../../../cubit/seat_selection/seat_selection_state.dart';
import 'empty_selection_bar.dart';
import 'selected_seats_bar.dart';

class SelectionBarBlocBuilder extends StatelessWidget {
  const SelectionBarBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatSelectionCubit, SeatSelectionState>(
      builder: (context, state) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: state.isEmpty
            ? const EmptySelectionBar()
            : SelectedSeatsBar(
                seatsLabel: state.seatsLabel,
                totalLabel: state.totalLabel,
                request: state.toRequest,
              ),
      ),
    );
  }
}
