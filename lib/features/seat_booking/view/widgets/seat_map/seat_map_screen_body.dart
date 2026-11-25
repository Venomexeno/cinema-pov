import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../cubit/screening/screening_cubit.dart';
import '../../../data/models/screening.dart';
import 'curved_screen.dart';
import 'screening_header.dart';
import 'seat_grid_bloc_builder.dart';
import 'seat_legend.dart';
import 'selection_bar_bloc_builder.dart';
import 'showtime_chips.dart';

class SeatMapScreenBody extends StatelessWidget {
  const SeatMapScreenBody({
    super.key,
    required this.screening,
    required this.selectedShowtimeId,
  });

  final Screening screening;
  final String selectedShowtimeId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScreeningHeader(screening: screening),

        ShowtimeChips(
          showtimes: screening.showtimes,
          selectedShowtimeId: selectedShowtimeId,
          onSelected: context.read<ScreeningCubit>().selectShowtime,
        ),

        const SizedBox(height: 16),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CurvedScreen(),
        ),

        const Expanded(
          child: Align(
            alignment: Alignment(0, -0.4),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SeatGridBlocBuilder(),
            ),
          ),
        ),

        const SeatLegend(),

        const SelectionBarBlocBuilder(),
      ],
    );
  }
}
