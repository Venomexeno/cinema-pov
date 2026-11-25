import '../../data/models/booking_confirmation.dart';

sealed class BookingState {
  const BookingState();

  bool get isLoading => false;
}

final class BookingInitial extends BookingState {
  const BookingInitial();
}

final class BookingLoading extends BookingState {
  const BookingLoading();

  @override
  bool get isLoading => true;
}

final class BookingSuccess extends BookingState {
  const BookingSuccess(this.confirmation);

  final BookingConfirmation confirmation;
}

final class BookingFailure extends BookingState {
  const BookingFailure(this.message);

  final String message;
}
