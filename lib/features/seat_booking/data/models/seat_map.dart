import 'seat.dart';
import 'seat_row.dart';

final class SeatMap {
  const SeatMap({
    required this.showtimeId,
    required this.blocks,
    required this.rows,
  });

  factory SeatMap.fromMap(Map<String, dynamic> map) {
    final blocks = List<int>.unmodifiable((map['blocks'] as List).cast<int>());
    final seatCount = blocks.fold<int>(0, (sum, block) => sum + block);
    final rows = (map['rows'] as List).cast<Map<String, dynamic>>();
    return SeatMap(
      showtimeId: map['showtimeId'] as String,
      blocks: blocks,
      rows: List.unmodifiable([
        for (var i = 0; i < rows.length; i++)
          SeatRow.fromMap(rows[i], rowIndex: i, seatCount: seatCount),
      ]),
    );
  }

  final String showtimeId;

  final List<int> blocks;
  final List<SeatRow> rows;

  int get rowCount => rows.length;
  int get seatsPerRow => blocks.fold(0, (sum, block) => sum + block);
  Iterable<Seat> get allSeats => rows.expand((row) => row.seats);

  Set<int> get aisleAfterNumbers {
    final edges = <int>{};
    var edge = 0;
    for (final block in blocks.take(blocks.length - 1)) {
      edge += block;
      edges.add(edge);
    }
    return edges;
  }

  int aislesBefore(int number) {
    var aisles = 0;
    var edge = 0;
    for (final block in blocks.take(blocks.length - 1)) {
      edge += block;
      if (number > edge) aisles++;
    }
    return aisles;
  }
}
