import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/widgets/error_view.dart';
import '../../../cubit/seat_map/seat_map_cubit.dart';
import '../../../cubit/seat_map/seat_map_state.dart';
import 'seat_grid.dart';
import 'seat_grid_skeleton.dart';

class SeatGridBlocBuilder extends StatelessWidget {
  const SeatGridBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatMapCubit, SeatMapState>(
      builder: (context, state) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: switch (state) {
          SeatMapInitial() || SeatMapLoading() => const SeatGridSkeleton(),
          SeatMapSuccess(:final seatMap) => SeatGrid(seatMap: seatMap),
          SeatMapFailure(:final message) => ErrorView(
            message: message,
            onRetry: context.read<SeatMapCubit>().retry,
          ),
        },
      ),
    );
  }
}
