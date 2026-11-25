import 'package:material_ui/material_ui.dart';

import '../../../data/models/seat.dart';
import '../../../data/enums/seat_status_enum.dart';
import 'seat_tile.dart';

typedef SeatTileBuilder = SeatTile Function({
  required Seat seat,
  VoidCallback? onTap,
});

extension SeatStatusTile on SeatStatusEnum {
  SeatTileBuilder get tile => switch (this) {
    SeatStatusEnum.available => SeatTile.available,
    SeatStatusEnum.taken => SeatTile.taken,
  };
}
