import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../cubit/seat_selection/seat_selection_cubit.dart';
import '../../../cubit/seat_selection/seat_selection_state.dart';
import '../../../data/models/seat.dart';
import 'seat_status_tile.dart';
import 'seat_tile.dart';

class SeatGridItem extends StatelessWidget {
  const SeatGridItem({super.key, required this.seat});

  final Seat seat;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SeatSelectionCubit, SeatSelectionState, bool>(
      selector: (state) => state.contains(seat),
      builder: (context, isSelected) {
        void toggle() => context.read<SeatSelectionCubit>().toggle(seat);
        return isSelected
            ? SeatTile.selected(seat: seat, onTap: toggle)
            : seat.status.tile(seat: seat, onTap: toggle);
      },
    );
  }
}
