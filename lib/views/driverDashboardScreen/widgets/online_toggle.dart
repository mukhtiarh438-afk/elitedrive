import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_padings.dart';
import '../../../core/app_text_size.dart';
import '../../../core/app_strings.dart';

class OnlineToggle extends StatelessWidget {
  final bool isOnline;
  final ValueChanged<bool> onToggle;

  const OnlineToggle({
    super.key,
    required this.isOnline,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _tab(context, AppStrings.online, true, showDot: true),
          _tab(context, AppStrings.offline, false),
        ],
      ),
    );
  }

  Widget _tab(BuildContext context, String label, bool value,
      {bool showDot = false}) {
    final selected = isOnline == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => onToggle(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: AppPaddings.symmetric(context, mH: 0, tH: 0, mV: 12, tV: 16),
          decoration: BoxDecoration(
            color: selected ? AppColors.whiteColor : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 1),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showDot && selected) ...[
                const CircleAvatar(
                    radius: 5, backgroundColor: AppColors.ridesOnlineDot),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selected
                      ? AppColors.homeTitleText
                      : AppColors.homeSubtitleText,
                  fontSize: AppTextSize.bodySmall(context),
                  fontWeight:
                      selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
