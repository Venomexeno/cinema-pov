import 'dart:ui' as ui;

import 'package:flutter/services.dart' show rootBundle;
import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_assets.dart';

final class PovViewValues {
  late final PageController pageController;
  late final AnimationController introController;
  late final ValueNotifier<int> currentIndex;

  late final ValueNotifier<ui.Image?> screenImage;

  late final CurvedAnimation sheetEntrance;

  bool _disposed = false;

  void init(TickerProvider vsync) {
    pageController = PageController();
    introController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1800),
    )..forward();
    currentIndex = ValueNotifier(0);
    screenImage = ValueNotifier(null);
    sheetEntrance = CurvedAnimation(
      parent: introController,
      curve: const Interval(0.75, 1, curve: Curves.easeOutCubic),
    );
    _loadScreenImage();
  }

  void dispose() {
    _disposed = true;
    sheetEntrance.dispose();
    introController.dispose();
    pageController.dispose();
    currentIndex.dispose();
    screenImage.value?.dispose();
    screenImage.dispose();
  }

  void onPageChanged(int index) => currentIndex.value = index;

  Future<void> _loadScreenImage() async {
    final data = await rootBundle.load(AppAssets.screenImage);
    final image = await decodeImageFromList(data.buffer.asUint8List());
    if (_disposed) {
      image.dispose(); // the screen closed while decoding
      return;
    }
    screenImage.value = image;
  }
}
