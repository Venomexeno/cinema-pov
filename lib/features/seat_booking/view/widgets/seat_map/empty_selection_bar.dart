import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/primary_button.dart';
import 'selection_bar_frame.dart';

class EmptySelectionBar extends StatelessWidget {
  const EmptySelectionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectionBarFrame(
      summary: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Choose your seats', style: AppTextStyles.caption),
          SizedBox(height: 2),
          Text('—', style: AppTextStyles.price),
        ],
      ),
      actions: [
        SizedBox(width: 120, child: PrimaryButton.filled(label: 'Continue')),
      ],
    );
  }
}
