import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_spacing.dart';
import '../../../core/app_text_size.dart';
import '../../../core/app_icon_size.dart';
import '../../../models/driver_model.dart';

class DriverAvatar extends StatelessWidget {
  final DriverModel driver;

  const DriverAvatar({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    final screenW      = MediaQuery.of(context).size.width;
    final isLandscape  = MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet     = AppSpacing.isTablet(context);

    final avatarRadius = isLandscape
        ? (screenW * 0.06).clamp(32.0, 56.0)   // landscape — width based, bada
        : (screenW * (isTablet ? 0.07 : 0.09)).clamp(24.0, 50.0);
    final spacing = isLandscape
        ? (screenW * 0.05).clamp(20.0, 40.0)
        : (screenW * 0.06).clamp(16.0, 36.0);

    return Padding(
      padding: EdgeInsets.only(right: spacing),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.homeAvatarRing, width: 1.5),
            ),
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundColor: AppColors.homeAvatarBg,
              backgroundImage: NetworkImage(driver.imageUrl),
            ),
          ),
          AppSpacing.vS(context),
          Text(
            driver.name,
            style: TextStyle(
              color: AppColors.homeTitleText,
              fontSize: AppTextSize.labelLarge(context),
              fontWeight: FontWeight.w500,
            ),
          ),
          AppSpacing.vXS(context),
          Row(
            children: [
              Icon(Icons.star,
                  color: AppColors.homeStarColor,
                  size: AppIconSize.star(context)),
              SizedBox(width: isTablet ? 3 : 2),
              Text(
                driver.rating,
                style: TextStyle(
                  color: AppColors.homeSubtitleText,
                  fontSize: AppTextSize.labelMedium(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
