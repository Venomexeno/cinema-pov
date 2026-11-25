import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:material_ui/material_ui.dart';

import '../../../data/models/seat.dart';

class CurrentSeatBuilder extends StatelessWidget {
  const CurrentSeatBuilder({
    super.key,
    required this.currentIndex,
    required this.seats,
    required this.builder,
  });

  final ValueListenable<int> currentIndex;
  final List<Seat> seats;
  final Widget Function(Seat seat, int index) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (context, index, _) => builder(seats[index], index),
    );
  }
}
