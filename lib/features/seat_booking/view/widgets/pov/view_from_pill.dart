import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ViewFromPill extends StatelessWidget {
  const ViewFromPill({super.key, required this.seatId});

  final String seatId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: ShapeDecoration(
        color: AppColors.surfaceHigh.withValues(alpha: 0.85),
        shape: const StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
            child: SizedBox.square(dimension: 6),
          ),
          const SizedBox(width: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              'View from $seatId',
              key: ValueKey(seatId),
              style: AppTextStyles.pill,
            ),
          ),
        ],
      ),
    );
  }
}
