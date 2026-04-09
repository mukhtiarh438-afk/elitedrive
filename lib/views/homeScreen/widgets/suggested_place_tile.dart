import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_padings.dart';
import '../../../core/app_spacing.dart';
import '../../../core/app_text_size.dart';
import '../../../core/app_icon_size.dart';
import '../../../models/suggested_place_model.dart';

class SuggestedPlaceTile extends StatelessWidget {
  final SuggestedPlaceModel place;

  const SuggestedPlaceTile({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final iconSize = AppSpacing.isTablet(context) ? 52.0 : 42.0;

    return ListTile(
      contentPadding: AppPaddings.symmetric(context, mH: 16, tH: 20, mV: 6, tV: 10),
      leading: Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          color: place.iconBg,
          shape: BoxShape.circle,
        ),
        child: Icon(place.icon, color: place.iconColor, size: AppIconSize.listTile(context)),
      ),
      title: Text(
        place.title,
        style: TextStyle(
          color: AppColors.homeTitleText,
          fontSize: AppTextSize.titleSmall(context),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        place.address,
        style: TextStyle(
          color: AppColors.homeSubtitleText,
          fontSize: AppTextSize.labelMedium(context),
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: AppColors.homeHintText, size:28),
      onTap: () {},
    );
  }
}
