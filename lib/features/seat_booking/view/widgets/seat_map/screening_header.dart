import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/circle_icon_button.dart';
import '../../../data/models/screening.dart';

class ScreeningHeader extends StatelessWidget {
  const ScreeningHeader({super.key, required this.screening});

  final Screening screening;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          CircleIconButton(
            icon: Icons.chevron_left,
            onPressed: () => Navigator.maybePop(context),
          ),
          Expanded(
            child: Column(
              children: [
                Text(screening.movieTitle, style: AppTextStyles.title),
                const SizedBox(height: 2),
                Text(screening.hallLabel, style: AppTextStyles.subtitle),
              ],
            ),
          ),
          const SizedBox.square(
            dimension: 36,
            child: Icon(
              Icons.info_outline,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
