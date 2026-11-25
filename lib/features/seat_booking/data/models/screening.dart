import 'showtime.dart';

final class Screening {
  const Screening({
    required this.movieTitle,
    required this.hallLabel,
    required this.showtimes,
    required this.defaultShowtimeId,
  });

  factory Screening.fromMap(Map<String, dynamic> map) => Screening(
    movieTitle: map['movie'] as String,
    hallLabel: map['hall'] as String,
    showtimes: List.unmodifiable(
      (map['showtimes'] as List).cast<Map<String, dynamic>>().map(
        Showtime.fromMap,
      ),
    ),
    defaultShowtimeId: map['defaultShowtimeId'] as String,
  );

  final String movieTitle;
  final String hallLabel;
  final List<Showtime> showtimes;
  final String defaultShowtimeId;
}
