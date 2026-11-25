import '../../../../core/result/guard.dart';
import '../../../../core/result/result.dart';
import '../data_source/showtime_data_source.dart';
import '../models/booking_confirmation.dart';
import '../models/requsts/booking_request.dart';
import '../models/screening.dart';
import '../models/seat_map.dart';

abstract interface class ShowtimeRepo {
  Future<Result<Screening>> getScreening();

  Future<Result<SeatMap>> getSeatMap(String showtimeId);

  Future<Result<BookingConfirmation>> book(BookingRequest request);
}

final class ShowtimeRepoImpl implements ShowtimeRepo {
  const ShowtimeRepoImpl(this._dataSource);

  final ShowtimeDataSource _dataSource;

  @override
  Future<Result<Screening>> getScreening() => guard(
    () async => await _dataSource.getScreening(),
  );

  @override
  Future<Result<SeatMap>> getSeatMap(String showtimeId) => guard(
    () async => await _dataSource.getSeatMap(showtimeId),
  );

  @override
  Future<Result<BookingConfirmation>> book(BookingRequest request) => guard(
    () async => await _dataSource.book(request),
  );
}
