import 'package:material_ui/material_ui.dart';

class PovSwipeArea extends StatelessWidget {
  const PovSwipeArea({
    super.key,
    required this.controller,
    required this.pageCount,
    required this.onPageChanged,
  });

  final PageController controller;
  final int pageCount;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: pageCount,
      onPageChanged: onPageChanged,
      itemBuilder: (_, _) => const SizedBox.expand(),
    );
  }
}
