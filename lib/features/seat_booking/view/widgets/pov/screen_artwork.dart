import 'dart:ui' as ui;

import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';

abstract final class ScreenArtwork {
  static const size = Size(1700, 890);

  static final _imagePaint = Paint()..filterQuality = FilterQuality.medium;
  static final _blankPaint = Paint()..color = AppColors.screenBlank;

  static void paint(Canvas canvas, ui.Image? image) {
    final target = Offset.zero & size;
    if (image == null) {
      canvas.drawRect(target, _blankPaint);
      return;
    }
    final imageSize = Size(image.width.toDouble(), image.height.toDouble());
    final fitted = applyBoxFit(BoxFit.cover, imageSize, size);
    final source = Alignment.center.inscribe(
      fitted.source,
      Offset.zero & imageSize,
    );
    canvas.drawImageRect(image, source, target, _imagePaint);
  }
}
