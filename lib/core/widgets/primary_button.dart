import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton._({
    required this.label,
    required this.onPressed,
    required this.background,
    required this.foreground,
    this.borderColor,
    this.isLoading = false,
  });

  factory PrimaryButton.filled({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
  }) => PrimaryButton._(
    label: label,
    onPressed: onPressed,
    isLoading: isLoading,
    background: AppColors.accent,
    foreground: AppColors.onAccent,
  );

  factory PrimaryButton.light({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
  }) => PrimaryButton._(
    label: label,
    onPressed: onPressed,
    isLoading: isLoading,
    background: AppColors.light,
    foreground: AppColors.onLight,
  );

  factory PrimaryButton.outlined({
    required String label,
    VoidCallback? onPressed,
    bool isLoading = false,
  }) => PrimaryButton._(
    label: label,
    onPressed: onPressed,
    isLoading: isLoading,
    background: Colors.transparent,
    foreground: AppColors.textPrimary,
    borderColor: AppColors.border,
  );

  final String label;
  final VoidCallback? onPressed;
  final Color background;
  final Color foreground;
  final Color? borderColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: onPressed == null ? 0.35 : 1,
      child: Material(
        color: background,
        shape: StadiumBorder(
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: enabled ? onPressed : null,
          child: SizedBox(
            height: 48,
            child: Center(
              child: isLoading
                  ? SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: foreground,
                      ),
                    )
                  : Text(
                      label,
                      style: AppTextStyles.button.copyWith(color: foreground),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
