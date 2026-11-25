import '../../../../core/cubit/safe_cubit.dart';
import '../../data/repo/showtime_repo.dart';
import 'seat_map_state.dart';

final class SeatMapCubit extends SafeCubit<SeatMapState> {
  SeatMapCubit(this._repo) : super(const SeatMapInitial());

  final ShowtimeRepo _repo;
  String? _showtimeId;

  Future<void> load(String showtimeId) async {
    _showtimeId = showtimeId;
    emit(const SeatMapLoading());
    await _fetch(showtimeId);
  }

  Future<void> retry() async {
    final showtimeId = _showtimeId;
    if (showtimeId == null) return;
    await load(showtimeId);
  }

  Future<void> refresh() async {
    final showtimeId = _showtimeId;
    if (showtimeId == null) return;
    await _fetch(showtimeId);
  }

  Future<void> _fetch(String showtimeId) async {
    final result = await _repo.getSeatMap(showtimeId);
    // A newer showtime was requested meanwhile.
    if (showtimeId != _showtimeId) return;
    result.fold(
      (failure) => emit(SeatMapFailure(failure.message)),
      (seatMap) => emit(SeatMapSuccess(seatMap)),
    );
  }
}
