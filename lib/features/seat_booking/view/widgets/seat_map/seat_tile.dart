import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/models/seat.dart';

class SeatTile extends StatelessWidget {
  const SeatTile._({
    required this.color,
    this.borderColor,
    this.label,
    this.onTap,
  });

  factory SeatTile.available({required Seat seat, VoidCallback? onTap}) =>
      SeatTile._(color: seat.kind.color, onTap: onTap);

  factory SeatTile.taken({required Seat seat, VoidCallback? onTap}) =>
      const SeatTile._(
        color: Colors.transparent,
        borderColor: AppColors.seatTakenBorder,
      );

  factory SeatTile.selected({required Seat seat, VoidCallback? onTap}) =>
      SeatTile._(
        color: AppColors.accent,
        label: '${seat.number}',
        onTap: onTap,
      );

  final Color color;
  final Color? borderColor;
  final String? label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final label = this.label;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: AspectRatio(
          aspectRatio: 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: borderColor ?? Colors.transparent),
            ),
            alignment: Alignment.center,
            child: label == null
                ? null
                : FittedBox(
                    child: Text(label, style: AppTextStyles.seatNumber),
                  ),
          ),
        ),
      ),
    );
  }
}
