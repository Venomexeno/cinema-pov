final class BookingConfirmation {
  const BookingConfirmation({required this.seatIds});

  factory BookingConfirmation.fromMap(Map<String, dynamic> map) =>
      BookingConfirmation(
        seatIds: List.unmodifiable((map['seatIds'] as List).cast<String>()),
      );

  final List<String> seatIds;

  String get message => 'Booked ${seatIds.join(', ')}. Enjoy the movie!';
}
