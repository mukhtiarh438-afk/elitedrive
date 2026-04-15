import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_padings.dart';
import '../../../core/app_spacing.dart';
import '../../../core/app_text_size.dart';
import '../../../core/app_icon_size.dart';

class BookingOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color iconColor;
  final Color titleColor;
  final double extraBottom;
  final VoidCallback? onTap;

  const BookingOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.iconColor,
    required this.titleColor,
    this.extraBottom = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconBoxSize = AppSpacing.isTablet(context) ? 54.0 : 44.0;
    final cardRadius  = AppSpacing.isTablet(context) ? 20.0 : 16.0;
    final iconRadius  = AppSpacing.isTablet(context) ? 14.0 : 10.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppPaddings.allM(context),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(cardRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: iconBoxSize,
              height: iconBoxSize,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(iconRadius),
              ),
              child: Icon(icon, color: iconColor, size: AppIconSize.cardSmall(context)),
            ),
            AppSpacing.vM(context),
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: AppTextSize.titleSmall(context),
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            AppSpacing.vXS(context),
            Text(
              subtitle,
              style: TextStyle(
                color: titleColor.withValues(alpha: 0.7),
                fontSize: AppTextSize.labelMedium(context),
              ),
            ),
            if (extraBottom > 0) SizedBox(height: extraBottom),
          ],
        ),
      ),
    );
  }
}
