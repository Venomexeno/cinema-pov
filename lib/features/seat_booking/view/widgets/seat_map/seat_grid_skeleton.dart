import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_colors.dart';

class SeatGridSkeleton extends StatelessWidget {
  const SeatGridSkeleton({super.key});

  static const _rows = 9;
  static const _blocks = [3, 8, 3];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var row = 0; row < _rows; row++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  for (final (index, block) in _blocks.indexed) ...[
                    if (index > 0) const SizedBox(width: 10),
                    for (var seat = 0; seat < block; seat++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(1.5),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.surfaceHigh,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
