import '../../data/models/screening.dart';

sealed class ScreeningState {
  const ScreeningState();

  String? get selectedShowtimeId => null;
}

final class ScreeningInitial extends ScreeningState {
  const ScreeningInitial();
}

final class ScreeningLoading extends ScreeningState {
  const ScreeningLoading();
}

final class ScreeningSuccess extends ScreeningState {
  const ScreeningSuccess({
    required this.screening,
    required this.selectedShowtimeId,
  });

  final Screening screening;

  @override
  final String selectedShowtimeId;

  ScreeningSuccess withShowtime(String showtimeId) =>
      ScreeningSuccess(screening: screening, selectedShowtimeId: showtimeId);
}

final class ScreeningFailure extends ScreeningState {
  const ScreeningFailure(this.message);

  final String message;
}
