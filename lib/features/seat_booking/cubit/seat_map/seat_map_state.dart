import '../../data/models/seat_map.dart';

sealed class SeatMapState {
  const SeatMapState();
}

final class SeatMapInitial extends SeatMapState {
  const SeatMapInitial();
}

final class SeatMapLoading extends SeatMapState {
  const SeatMapLoading();
}

final class SeatMapSuccess extends SeatMapState {
  const SeatMapSuccess(this.seatMap);

  final SeatMap seatMap;
}

final class SeatMapFailure extends SeatMapState {
  const SeatMapFailure(this.message);

  final String message;
}
