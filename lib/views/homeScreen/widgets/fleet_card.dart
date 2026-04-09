import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_padings.dart';
import '../../../core/app_spacing.dart';
import '../../../core/app_text_size.dart';
import '../../../core/app_icon_size.dart';
import '../../../models/fleet_model.dart';

class FleetCard extends StatelessWidget {
  final FleetModel fleet;
  final VoidCallback onTap;

  const FleetCard({super.key, required this.fleet, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isTablet    = AppSpacing.isTablet(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final screenW     = MediaQuery.of(context).size.width;
    final cardWidth   = screenW * (isTablet ? 0.28 : (isLandscape ? 0.30 : 0.36));
    final cardRadius  = isTablet ? 18.0 : 14.0;

    return GestureDetector(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: cardWidth, maxWidth: cardWidth),
        child: Card(
          elevation: fleet.isSelected ? 3 : 0,
          color: fleet.isSelected
              ? AppColors.fleetCardBg       // selected — color same 
              : AppColors.fleetCardBg,     // unselected — same color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cardRadius),
            side: fleet.isSelected
                ? const BorderSide(color: AppColors.homePrimary, width: 1.5)
                : BorderSide.none,
          ),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: AppPaddings.symmetric(context, mH: 12, tH: 18, mV: 10, tV: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  fleet.icon,
                  color: AppColors.fleetIconColor,
                  size: AppIconSize.card(context),
                ),
                AppSpacing.vS(context),
                Text(
                  fleet.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.homeTitleText,
                    fontSize: AppTextSize.titleSmall(context),
                    fontWeight: fleet.isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
                AppSpacing.vXS(context),
                Text(
                  fleet.price,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.homeSubtitleText,
                    fontSize: AppTextSize.labelSmall(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
