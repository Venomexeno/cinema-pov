import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../../core/widgets/error_view.dart';
import '../../../cubit/screening/screening_cubit.dart';
import '../../../cubit/screening/screening_state.dart';
import '../../../data/models/screening.dart';
import 'seat_grid_skeleton.dart';

class ScreeningBlocBuilder extends StatelessWidget {
  const ScreeningBlocBuilder({super.key, required this.successBuilder});

  final Widget Function(Screening screening, String selectedShowtimeId)
  successBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreeningCubit, ScreeningState>(
      builder: (context, state) => switch (state) {
        ScreeningInitial() || ScreeningLoading() => const Center(
          child: SeatGridSkeleton(),
        ),

        ScreeningSuccess(:final screening, :final selectedShowtimeId) =>
          successBuilder(
            screening,
            selectedShowtimeId,
          ),

        ScreeningFailure(:final message) => ErrorView(
          message: message,
          onRetry: context.read<ScreeningCubit>().load,
        ),
      },
    );
  }
}
