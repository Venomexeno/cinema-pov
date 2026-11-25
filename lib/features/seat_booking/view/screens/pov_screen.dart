import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_colors.dart';
import '../../cubit/seat_selection/seat_selection_state.dart';
import '../../data/models/seat_map.dart';
import '../../data/models/pov/hall_geometry.dart';
import '../../data/models/pov/pov_camera_rig.dart';
import '../view_values/pov_view_values.dart';
import '../widgets/pov/pov_screen_body.dart';

class PovScreen extends StatefulWidget {
  const PovScreen({
    super.key,
    required this.values,
    required this.selection,
    required this.seatMap,
  });

  final PovViewValues values;
  final SeatSelectionState selection;
  final SeatMap seatMap;

  @override
  State<PovScreen> createState() => _PovScreenState();
}

class _PovScreenState extends State<PovScreen>
    with SingleTickerProviderStateMixin {
  late final HallGeometry _hall = HallGeometry(widget.seatMap);
  late final PovCameraRig _rig;

  PovViewValues get _values => widget.values;

  @override
  void initState() {
    super.initState();
    _values.init(this);
    _rig = PovCameraRig(
      hall: _hall,
      seats: widget.selection.seats,
      pageController: _values.pageController,
      intro: _values.introController,
    );
  }

  @override
  void dispose() {
    _values.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.hallBottom,
      body: PovScreenBody(
        values: _values,
        rig: _rig,
        hall: _hall,
        selection: widget.selection,
        seatMap: widget.seatMap,
      ),
    );
  }
}
