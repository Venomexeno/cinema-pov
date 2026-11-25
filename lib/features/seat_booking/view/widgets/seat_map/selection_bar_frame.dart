import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';

class SelectionBarFrame extends StatelessWidget {
  const SelectionBarFrame({
    super.key,
    required this.summary,
    required this.actions,
  });

  final Widget summary;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 16, 14),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(child: summary),
            ...actions,
          ],
        ),
      ),
    );
  }
}
