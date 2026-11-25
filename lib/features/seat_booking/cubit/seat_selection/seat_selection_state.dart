import '../../../../core/extensions/price_format.dart';
import '../../data/models/requsts/booking_request.dart';
import '../../data/models/seat.dart';

sealed class SeatSelectionState {
  SeatSelectionState({required this.showtimeId, required List<Seat> seats})
    : seats = List<Seat>.unmodifiable(<Seat>[...seats]..sort(_frontToBack));

  final String showtimeId;

  final List<Seat> seats;

  bool get isEmpty => seats.isEmpty;
  bool contains(Seat seat) => seats.contains(seat);
  double get total => seats.fold(0, (sum, seat) => sum + seat.price);
  String get totalLabel => total.euro;
  String get seatsLabel => seats.map((seat) => seat.id).join(' · ');

  BookingRequest get toRequest => BookingRequest(
    showtimeId: showtimeId,
    seatIds: seats.map((seat) => seat.id).toList(),
  );

  static int _frontToBack(Seat a, Seat b) {
    final byRow = a.rowIndex.compareTo(b.rowIndex);
    return byRow != 0 ? byRow : a.number.compareTo(b.number);
  }
}

final class SeatSelectionChanged extends SeatSelectionState {
  SeatSelectionChanged({required super.showtimeId, required super.seats});
}

final class SeatSelectionLimitReached extends SeatSelectionState {
  SeatSelectionLimitReached({
    required super.showtimeId,
    required super.seats,
    required this.limit,
  });

  final int limit;

  String get message => 'You can pick up to $limit seats.';
}
