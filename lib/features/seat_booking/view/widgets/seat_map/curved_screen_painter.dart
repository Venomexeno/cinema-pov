import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';

final class CurvedScreenPainter extends CustomPainter {
  const CurvedScreenPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(size.width * 0.04, size.height * 0.42);
    final end = Offset(size.width * 0.96, size.height * 0.42);
    final control = Offset(size.width / 2, -size.height * 0.05);
    final arc = Path()
      ..moveTo(start.dx, start.dy)
      ..quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);

    final glow = Path.from(arc)
      ..lineTo(size.width * 0.9, size.height)
      ..lineTo(size.width * 0.1, size.height)
      ..close();
    final glowRect = Offset.zero & size;
    canvas
      ..drawPath(
        glow,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.screenGlow,
              AppColors.screenGlow.withValues(alpha: 0),
            ],
          ).createShader(glowRect),
      )
      ..drawPath(
        arc,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round
          ..color = AppColors.screenArc,
      );
  }

  @override
  bool shouldRepaint(CurvedScreenPainter oldDelegate) => false;
}
