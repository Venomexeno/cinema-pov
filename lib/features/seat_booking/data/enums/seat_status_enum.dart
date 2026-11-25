enum SeatStatusEnum {
  available(isBookable: true),
  taken(isBookable: false);

  const SeatStatusEnum({required this.isBookable});

  final bool isBookable;
}
