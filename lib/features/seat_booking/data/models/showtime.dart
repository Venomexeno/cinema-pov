final class Showtime {
  const Showtime({required this.id, required this.time, required this.format});

  factory Showtime.fromMap(Map<String, dynamic> map) => Showtime(
    id: map['id'] as String,
    time: map['time'] as String,
    format: map['format'] as String,
  );

  final String id;
  final String time;
  final String format;
}
