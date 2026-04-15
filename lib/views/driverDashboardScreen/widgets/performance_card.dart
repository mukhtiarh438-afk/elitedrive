import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_padings.dart';
import '../../../core/app_spacing.dart';
import '../../../core/app_strings.dart';
import '../../../core/app_text_size.dart';

class PerformanceCard extends StatelessWidget {
  const PerformanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Earnings — dark card
        Expanded(
          flex: 5,
          child: Container(
            padding: AppPaddings.allM(context),
            decoration: BoxDecoration(
              color: AppColors.ridesEarningsBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.earnings,
                    style: TextStyle(
                      color: AppColors.whiteColor.withValues(alpha: 0.7),
                      fontSize: AppTextSize.labelMedium(context),
                    )),
                AppSpacing.vXS(context),
                Text(AppStrings.earningsAmount,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: AppTextSize.displaySmall(context),
                      fontWeight: FontWeight.bold,
                    )),
                AppSpacing.vS(context),
                Row(
                  children: [
                    const Icon(Icons.trending_up,
                        color: AppColors.ridesPositive, size: 14),
                    const SizedBox(width: 4),
                    Text(AppStrings.earningsGrowth,
                        style: TextStyle(
                          color: AppColors.ridesPositive,
                          fontSize: AppTextSize.labelSmall(context),
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
        AppSpacing.hS(context),
        // Rides + Hours — light card
        Expanded(
          flex: 4,
          child: Container(
            padding: AppPaddings.allM(context),
            decoration: BoxDecoration(
              color: AppColors.ridesStatsBg,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.rides,
                    style: TextStyle(
                      color: AppColors.homeSubtitleText,
                      fontSize: AppTextSize.labelMedium(context),
                    )),
                AppSpacing.vXS(context),
                Text(AppStrings.ridesCount,
                    style: TextStyle(
                      color: AppColors.homeTitleText,
                      fontSize: AppTextSize.displaySmall(context),
                      fontWeight: FontWeight.bold,
                    )),
                AppSpacing.vS(context),
                Text(AppStrings.hoursOnline,
                    style: TextStyle(
                      color: AppColors.homeSubtitleText,
                      fontSize: AppTextSize.labelSmall(context),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
