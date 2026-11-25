import 'seat.dart';
import '../enums/seat_kind_enum.dart';
import '../enums/seat_status_enum.dart';

final class SeatRow {
  const SeatRow({required this.letter, required this.seats});

  factory SeatRow.fromMap(
    Map<String, dynamic> map, {
    required int rowIndex,
    required int seatCount,
  }) {
    final letter = map['letter'] as String;
    final kind = SeatKindEnum.values.byName(map['kind'] as String);
    final taken = (map['taken'] as List).cast<int>().toSet();
    return SeatRow(
      letter: letter,
      seats: List.unmodifiable([
        for (var number = 1; number <= seatCount; number++)
          Seat(
            row: letter,
            rowIndex: rowIndex,
            number: number,
            kind: kind,
            status: taken.contains(number)
                ? SeatStatusEnum.taken
                : SeatStatusEnum.available,
          ),
      ]),
    );
  }

  final String letter;
  final List<Seat> seats;
}
