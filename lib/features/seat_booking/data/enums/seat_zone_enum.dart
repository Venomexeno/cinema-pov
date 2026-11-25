enum SeatZoneEnum {
  upClose('Up close', lastRowIndex: 2),
  sweetSpot('Sweet spot', lastRowIndex: 6),
  fullPicture('Full picture', lastRowIndex: 1 << 30);

  const SeatZoneEnum(this.label, {required this.lastRowIndex});

  final String label;
  final int lastRowIndex;

  static SeatZoneEnum ofRow(int rowIndex) =>
      values.firstWhere((zone) => rowIndex <= zone.lastRowIndex);
}
