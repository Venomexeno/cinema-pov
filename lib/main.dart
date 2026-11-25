import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'features/seat_booking/cubit/booking/booking_cubit.dart';
import 'features/seat_booking/cubit/screening/screening_cubit.dart';
import 'features/seat_booking/cubit/seat_map/seat_map_cubit.dart';
import 'features/seat_booking/cubit/seat_selection/seat_selection_cubit.dart';
import 'features/seat_booking/view/screens/seat_map_screen.dart';

void main() {
  setupDependencies();
  runApp(const CinemaApp());
}

class CinemaApp extends StatelessWidget {
  const CinemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema Seat Preview',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<ScreeningCubit>()..load()),
          BlocProvider(create: (_) => sl<SeatMapCubit>()),
          BlocProvider(create: (_) => sl<SeatSelectionCubit>()),
          BlocProvider(create: (_) => sl<BookingCubit>()),
        ],
        child: const SeatMapScreen(),
      ),
    );
  }
}
