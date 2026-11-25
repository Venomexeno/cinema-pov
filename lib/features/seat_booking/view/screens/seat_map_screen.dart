import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../widgets/seat_map/booking_result_bloc_listener.dart';
import '../widgets/seat_map/screening_bloc_builder.dart';
import '../widgets/seat_map/selection_limit_bloc_listener.dart';
import '../widgets/seat_map/showtime_change_bloc_listener.dart';
import '../widgets/seat_map/seat_map_screen_body.dart';

class SeatMapScreen extends StatelessWidget {
  const SeatMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Must wrap the builder, otherwise the first showtime load is missed.
      body: MultiBlocListener(
        listeners: const [
          ShowtimeChangeBlocListener(),
          SelectionLimitBlocListener(),
          BookingResultBlocListener(),
        ],
        child: SafeArea(
          bottom: false,
          child: ScreeningBlocBuilder(
            successBuilder: (screening, selectedShowtimeId) =>
                SeatMapScreenBody(
                  screening: screening,
                  selectedShowtimeId: selectedShowtimeId,
                ),
          ),
        ),
      ),
    );
  }
}
