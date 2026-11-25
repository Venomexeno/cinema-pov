import '../../../../core/cubit/safe_cubit.dart';
import '../../data/repo/showtime_repo.dart';
import 'screening_state.dart';

final class ScreeningCubit extends SafeCubit<ScreeningState> {
  ScreeningCubit(this._repo) : super(const ScreeningInitial());

  final ShowtimeRepo _repo;

  Future<void> load() async {
    emit(const ScreeningLoading());
    final result = await _repo.getScreening();
    result.fold(
      (failure) => emit(ScreeningFailure(failure.message)),
      (screening) => emit(
        ScreeningSuccess(
          screening: screening,
          selectedShowtimeId: screening.defaultShowtimeId,
        ),
      ),
    );
  }

  void selectShowtime(String showtimeId) {
    final current = state;
    if (current is! ScreeningSuccess ||
        current.selectedShowtimeId == showtimeId) {
      return;
    }
    emit(current.withShowtime(showtimeId));
  }
}
