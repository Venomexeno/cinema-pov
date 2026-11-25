import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/enums/seat_kind_enum.dart';

class LegendItem extends StatelessWidget {
  const LegendItem._({
    required this.label,
    required this.color,
    this.borderColor,
  });

  factory LegendItem.available() =>
      LegendItem._(label: 'Available', color: SeatKindEnum.standard.color);

  factory LegendItem.taken() => const LegendItem._(
    label: 'Taken',
    color: Colors.transparent,
    borderColor: AppColors.seatTakenBorder,
  );

  factory LegendItem.recliner() =>
      LegendItem._(label: 'Recliner', color: SeatKindEnum.recliner.color);

  factory LegendItem.selected() =>
      const LegendItem._(label: 'Selected', color: AppColors.accent);

  final String label;
  final Color color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: borderColor ?? Colors.transparent),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.micro),
      ],
    );
  }
}
