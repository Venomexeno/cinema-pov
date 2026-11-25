import '../../../../core/cubit/safe_cubit.dart';
import '../../data/models/seat.dart';
import 'seat_selection_state.dart';

final class SeatSelectionCubit extends SafeCubit<SeatSelectionState> {
  SeatSelectionCubit()
    : super(SeatSelectionChanged(showtimeId: '', seats: const []));

  static const maxSeats = 6;

  void toggle(Seat seat) {
    if (!seat.status.isBookable) return;
    final seats = state.seats;
    if (seats.contains(seat)) {
      emit(
        SeatSelectionChanged(
          showtimeId: state.showtimeId,
          seats: [...seats]..remove(seat),
        ),
      );
      return;
    }
    if (seats.length >= maxSeats) {
      emit(
        SeatSelectionLimitReached(
          showtimeId: state.showtimeId,
          seats: seats,
          limit: maxSeats,
        ),
      );
      return;
    }
    emit(
      SeatSelectionChanged(
        showtimeId: state.showtimeId,
        seats: [...seats, seat],
      ),
    );
  }

  void reset(String showtimeId) =>
      emit(SeatSelectionChanged(showtimeId: showtimeId, seats: const []));
}
