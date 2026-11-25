import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/circle_icon_button.dart';
import 'page_dots.dart';
import 'view_from_pill.dart';

class PovTopBar extends StatelessWidget {
  const PovTopBar({
    super.key,
    required this.seatId,
    required this.index,
    required this.count,
  });

  final String seatId;
  final int index;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        children: [
          Row(
            children: [
              CircleIconButton(
                icon: Icons.chevron_left,
                onPressed: () => Navigator.maybePop(context),
              ),
              Expanded(
                child: Center(child: ViewFromPill(seatId: seatId)),
              ),
              const SizedBox(width: 36),
            ],
          ),
          if (count > 1) ...[
            const SizedBox(height: 12),
            PageDots(count: count, index: index),
            const SizedBox(height: 6),
            const Text('Swipe to switch seats', style: AppTextStyles.micro),
          ],
        ],
      ),
    );
  }
}
