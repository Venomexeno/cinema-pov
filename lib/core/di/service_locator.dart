import 'package:get_it/get_it.dart';

import '../../features/seat_booking/cubit/booking/booking_cubit.dart';
import '../../features/seat_booking/cubit/screening/screening_cubit.dart';
import '../../features/seat_booking/cubit/seat_map/seat_map_cubit.dart';
import '../../features/seat_booking/cubit/seat_selection/seat_selection_cubit.dart';
import '../../features/seat_booking/data/data_source/showtime_data_source.dart';
import '../../features/seat_booking/data/repo/showtime_repo.dart';

final sl = GetIt.instance;

void setupDependencies() {
  sl
    ..registerLazySingleton<ShowtimeDataSource>(ShowtimeLocalDataSource.new)
    ..registerLazySingleton<ShowtimeRepo>(() => ShowtimeRepoImpl(sl()))
    ..registerFactory(() => ScreeningCubit(sl()))
    ..registerFactory(() => SeatMapCubit(sl()))
    ..registerFactory(SeatSelectionCubit.new)
    ..registerFactory(() => BookingCubit(sl()));
}
