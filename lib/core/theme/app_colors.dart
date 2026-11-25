import 'package:material_ui/material_ui.dart';

abstract final class AppColors {
  // Surfaces
  static const background = Color(0xFF0A0A0C);
  static const surface = Color(0xFF151518);
  static const surfaceHigh = Color(0xFF1E1E23);
  static const border = Color(0xFF2A2A30);
  static const scrim = Color(0xCC000000);

  // Text
  static const textPrimary = Color(0xFFF4F4F5);
  static const textSecondary = Color(0xFF9A9AA2);
  static const textMuted = Color(0xFF5E5E66);

  // Actions
  static const accent = Color(0xFF7DDBA3);
  static const onAccent = Color(0xFF07140C);
  static const light = Color(0xFFF2F2F2);
  static const onLight = Color(0xFF111113);

  // Seat map
  static const seatStandard = Color(0xFF34343B);
  static const seatRecliner = Color(0xFF6B2B3B);
  static const seatTakenBorder = Color(0xFF2C2C33);
  static const screenArc = Color(0xFFE8E8EC);
  static const screenGlow = Color(0x33FFFFFF);

  // Hall (POV scene)
  static const hallTop = Color(0xFF0D0907);
  static const hallBottom = Color(0xFF050303);
  static const hallSeat = Color(0xFFA3161F);
  static const hallSeatShadow = Color(0xFF3A0508);
  static const hallSeatHighlight = Color(0xFFD23A40);
  static const hallScreenFrame = Color(0xFF020202);
  static const hallScreenSpill = Color(0x40E8CFAE);

  static const screenBlank = Color(0xFF1A1A1E);
}
