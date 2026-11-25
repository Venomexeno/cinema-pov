import 'package:material_ui/material_ui.dart';

import '../seat.dart';
import 'hall_geometry.dart';
import 'pov_camera.dart';

final class PovCameraRig {
  PovCameraRig({
    required HallGeometry hall,
    required List<Seat> seats,
    required this._pageController,
    required this._intro,
  }) : _hall = hall,
       _seatIds = List.unmodifiable(seats.map((seat) => seat.id)),
       _seatCameras = List.unmodifiable(seats.map(hall.cameraFor));

  final HallGeometry _hall;
  final PageController _pageController;
  final Animation<double> _intro;
  final List<String> _seatIds;
  final List<PovCamera> _seatCameras;

  static const _holdThenFly = Interval(0.2, 1);

  static const _hideOwnSeatFrom = 0.55;

  Listenable get changes => Listenable.merge([_pageController, _intro]);

  PovCamera get camera =>
      PovCamera.lerp(_hall.overview, _seatedCamera, _flight);

  String? get hiddenSeatId =>
      _flight < _hideOwnSeatFrom ? null : _seatIds[_page.round()];

  double get _flight =>
      Curves.easeInOutCubic.transform(_holdThenFly.transform(_intro.value));

  PovCamera get _seatedCamera {
    final page = _page;
    final from = page.floor();
    final to = page.ceil();
    final t = Curves.easeInOut.transform(page - from);
    return PovCamera.lerp(_seatCameras[from], _seatCameras[to], t);
  }

  double get _page {
    final position = _pageController.hasClients
        ? _pageController.position
        : null;
    final page = position == null || !position.hasContentDimensions
        ? _pageController.initialPage.toDouble()
        : _pageController.page ?? 0;
    return page.clamp(0.0, _seatCameras.length - 1.0);
  }
}
