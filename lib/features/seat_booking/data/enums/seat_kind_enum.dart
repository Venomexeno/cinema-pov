import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_colors.dart';

enum SeatKindEnum {
  standard('Standard', 12.50, AppColors.seatStandard),
  recliner('Recliner', 16.00, AppColors.seatRecliner);

  const SeatKindEnum(this.label, this.price, this.color);

  final String label;
  final double price;
  final Color color;
}
