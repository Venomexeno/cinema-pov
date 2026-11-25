import '../../../../core/cubit/safe_cubit.dart';
import '../../data/models/requsts/booking_request.dart';
import '../../data/repo/showtime_repo.dart';
import 'booking_state.dart';

final class BookingCubit extends SafeCubit<BookingState> {
  BookingCubit(this._repo) : super(const BookingInitial());

  final ShowtimeRepo _repo;

  Future<void> book(BookingRequest request) async {
    if (state.isLoading) return;
    emit(const BookingLoading());
    final result = await _repo.book(request);
    result.fold(
      (failure) => emit(BookingFailure(failure.message)),
      (confirmation) => emit(BookingSuccess(confirmation)),
    );
  }
}
