import 'package:material_ui/material_ui.dart';

import '../../../cubit/seat_selection/seat_selection_state.dart';
import '../../../data/models/seat_map.dart';
import '../../../data/models/pov/hall_geometry.dart';
import '../../../data/models/pov/pov_camera_rig.dart';
import '../../view_values/pov_view_values.dart';
import 'current_seat_builder.dart';
import 'pov_booking_bloc_listener.dart';
import 'pov_scene.dart';
import 'pov_seat_sheet.dart';
import 'pov_sheet_entrance.dart';
import 'pov_swipe_area.dart';
import 'pov_top_bar.dart';

class PovScreenBody extends StatelessWidget {
  const PovScreenBody({
    super.key,
    required this.values,
    required this.rig,
    required this.hall,
    required this.selection,
    required this.seatMap,
  });

  final PovViewValues values;
  final PovCameraRig rig;
  final HallGeometry hall;
  final SeatSelectionState selection;
  final SeatMap seatMap;

  @override
  Widget build(BuildContext context) {
    final seats = selection.seats;

    return PovBookingBlocListener(
      child: Stack(
        fit: StackFit.expand,
        children: [
          PovScene(
            rig: rig,
            hall: hall,
            highlightedSeatIds: {for (final seat in seats) seat.id},
            screenImage: values.screenImage,
          ),

          PovSwipeArea(
            controller: values.pageController,
            pageCount: seats.length,
            onPageChanged: values.onPageChanged,
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: CurrentSeatBuilder(
                currentIndex: values.currentIndex,
                seats: seats,
                builder: (seat, index) => PovTopBar(
                  seatId: seat.id,
                  index: index,
                  count: seats.length,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: PovSheetEntrance(
              animation: values.sheetEntrance,
              child: CurrentSeatBuilder(
                currentIndex: values.currentIndex,
                seats: seats,
                builder: (seat, _) => PovSeatSheet(
                  seat: seat,
                  stats: hall.statsFor(seat),
                  seatMap: seatMap,
                  request: selection.toRequest,
                  totalLabel: selection.totalLabel,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
