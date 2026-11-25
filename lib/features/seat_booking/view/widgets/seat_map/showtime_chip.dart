import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ShowtimeChip extends StatelessWidget {
  const ShowtimeChip({
    super.key,
    required this.time,
    required this.format,
    required this.isSelected,
    required this.onTap,
  });

  final String time;
  final String format;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = isSelected ? AppColors.onLight : AppColors.textSecondary;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: ShapeDecoration(
          color: isSelected ? AppColors.light : Colors.transparent,
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(time, style: AppTextStyles.chip.copyWith(color: foreground)),
            const SizedBox(width: 4),
            Text(
              format,
              style: AppTextStyles.chipTag.copyWith(
                color: foreground.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
