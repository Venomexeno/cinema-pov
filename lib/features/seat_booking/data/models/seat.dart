import '../enums/seat_kind_enum.dart';
import '../enums/seat_status_enum.dart';
import '../enums/seat_zone_enum.dart';

final class Seat {
  const Seat({
    required this.row,
    required this.rowIndex,
    required this.number,
    required this.kind,
    required this.status,
  });

  final String row;
  final int rowIndex;
  final int number;
  final SeatKindEnum kind;
  final SeatStatusEnum status;

  String get id => '$row$number';
  String get title => 'Row $row, Seat $number';
  double get price => kind.price;
  SeatZoneEnum get zone => SeatZoneEnum.ofRow(rowIndex);

  @override
  bool operator ==(Object other) => other is Seat && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
