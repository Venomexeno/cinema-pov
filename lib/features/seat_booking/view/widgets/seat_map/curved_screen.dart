import 'package:material_ui/material_ui.dart';

import '../../../../../core/theme/app_text_styles.dart';
import 'curved_screen_painter.dart';

class CurvedScreen extends StatelessWidget {
  const CurvedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 70,
      child: CustomPaint(
        painter: CurvedScreenPainter(),
        child: Align(
          alignment: Alignment(0, 0.45),
          child: Text('SCREEN', style: AppTextStyles.screenLabel),
        ),
      ),
    );
  }
}
