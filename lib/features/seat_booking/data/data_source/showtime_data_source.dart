import '../../../../core/result/failure.dart';
import '../models/booking_confirmation.dart';
import '../models/requsts/booking_request.dart';
import '../models/screening.dart';
import '../models/seat_map.dart';

abstract interface class ShowtimeDataSource {
  Future<Screening> getScreening();
  Future<SeatMap> getSeatMap(String showtimeId);
  Future<BookingConfirmation> book(BookingRequest request);
}

final class ShowtimeLocalDataSource implements ShowtimeDataSource {
  static const _latency = Duration(milliseconds: 600);

  static const _screening = {
    'movie': 'Avengers: Doomsday',
    'hall': 'Hall 3 · Fri 14 Nov',
    'defaultShowtimeId': 'st-1945',
    'showtimes': [
      {'id': 'st-1730', 'time': '17:30', 'format': '2D'},
      {'id': 'st-1945', 'time': '19:45', 'format': 'IMAX'},
      {'id': 'st-2215', 'time': '22:15', 'format': '2D'},
    ],
  };

  static const _blocks = [3, 8, 3];

  static const _rows = [
    ('A', 'standard'),
    ('B', 'standard'),
    ('C', 'standard'),
    ('D', 'standard'),
    ('E', 'standard'),
    ('F', 'standard'),
    ('G', 'standard'),
    ('H', 'recliner'),
    ('I', 'recliner'),
  ];

  final Map<String, Set<String>> _takenByShowtime = {
    'st-1730': {
      'A2',
      'A3',
      'C6',
      'C7',
      'D5',
      'E9',
      'E10',
      'F1',
      'G12',
      'H4',
      'H5',
      'I13',
    },
    'st-1945': {
      'A1',
      'A4',
      'A13',
      'B1',
      'C2',
      'C3',
      'D7',
      'D8',
      'E4',
      'F4',
      'F5',
      'G9',
      'G10',
      'H3',
      'H7',
      'I2',
      'I5',
      'I10',
    },
    'st-2215': {
      'B6',
      'B7',
      'B8',
      'D2',
      'E11',
      'F6',
      'F7',
      'G3',
      'H10',
      'I6',
      'I7',
    },
  };

  @override
  Future<Screening> getScreening() async {
    await Future<void>.delayed(_latency);
    return Screening.fromMap(_screening);
  }

  @override
  Future<SeatMap> getSeatMap(String showtimeId) async {
    await Future<void>.delayed(_latency);
    final taken = _takenFor(showtimeId);
    return SeatMap.fromMap({
      'showtimeId': showtimeId,
      'blocks': _blocks,
      'rows': [
        for (final (letter, kind) in _rows)
          {
            'letter': letter,
            'kind': kind,
            'taken': [
              for (final id in taken)
                if (id.substring(0, 1) == letter) int.parse(id.substring(1)),
            ],
          },
      ],
    });
  }

  @override
  Future<BookingConfirmation> book(BookingRequest request) async {
    await Future<void>.delayed(_latency * 2);
    final taken = _takenFor(request.showtimeId);
    final clash = request.seatIds.where(taken.contains);
    if (clash.isNotEmpty) {
      throw AppException(
        'Seat ${clash.join(', ')} was just taken. Pick another one.',
      );
    }
    taken.addAll(request.seatIds);
    return BookingConfirmation.fromMap({'seatIds': request.seatIds});
  }

  Set<String> _takenFor(String showtimeId) {
    final taken = _takenByShowtime[showtimeId];
    if (taken == null) {
      throw const AppException('This showtime is no longer available.');
    }
    return taken;
  }
}
