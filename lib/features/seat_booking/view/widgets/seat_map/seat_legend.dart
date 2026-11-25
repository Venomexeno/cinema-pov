import 'package:material_ui/material_ui.dart';

import 'legend_item.dart';

class SeatLegend extends StatelessWidget {
  const SeatLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 18,
        runSpacing: 8,
        children: [
          LegendItem.available(),
          LegendItem.taken(),
          LegendItem.recliner(),
          LegendItem.selected(),
        ],
      ),
    );
  }
}
