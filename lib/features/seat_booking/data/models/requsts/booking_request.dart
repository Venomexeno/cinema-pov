final class BookingRequest {
  const BookingRequest({required this.showtimeId, required this.seatIds});

  final String showtimeId;
  final List<String> seatIds;

  Map<String, dynamic> toMap() => {
    'showtimeId': showtimeId,
    'seatIds': seatIds,
  };
}
