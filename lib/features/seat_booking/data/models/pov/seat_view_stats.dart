final class SeatViewStats {
  const SeatViewStats({
    required this.distance,
    required this.fieldOfView,
    required this.offset,
  });

  final double distance;

  final double fieldOfView;

  final double offset;

  static const _centredTolerance = 0.2;

  String get distanceLabel => '${distance.toStringAsFixed(1)} m';
  String get fieldOfViewLabel => '${fieldOfView.round()}°';
  String get offsetLabel => '${offset.abs().toStringAsFixed(1)} m';

  String get offsetCaption => offset.abs() < _centredTolerance
      ? 'dead centre'
      : offset < 0
      ? 'left of centre'
      : 'right of centre';
}
