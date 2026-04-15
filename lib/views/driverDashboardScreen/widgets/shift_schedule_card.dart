import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_padings.dart';
import '../../../core/app_spacing.dart';
import '../../../core/app_text_size.dart';
import '../../../models/shift_day_model.dart';

class ShiftScheduleCard extends StatelessWidget {
  final List<ShiftDayModel> days;

  const ShiftScheduleCard({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.allM(context),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
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
        children: [
          // Days row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days.map((d) => _DayChip(day: d)).toList(),
          ),
          AppSpacing.vM(context),
          const Divider(height: 1, color: Color(0xFFF0F4F8)),
          AppSpacing.vM(context),
          // Shift slot
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.multiStopBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.calendar_today,
                    color: AppColors.multiStopIcon, size: 18),
              ),
              AppSpacing.hM(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Morning Peak',
                      style: TextStyle(
                        color: AppColors.homeTitleText,
                        fontSize: AppTextSize.bodySmall(context),
                        fontWeight: FontWeight.w600,
                      )),
                  Text('08:00 AM – 12:00 PM',
                      style: TextStyle(
                        color: AppColors.homeSubtitleText,
                        fontSize: AppTextSize.labelMedium(context),
                      )),
                ],
              ),
              const Spacer(),
              const Icon(Icons.chevron_right,
                  color: AppColors.homeHintText, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  final ShiftDayModel day;
  const _DayChip({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.symmetric(context, mH: 10, tH: 14, mV: 6, tV: 8),
      decoration: BoxDecoration(
        color: day.isSelected ? AppColors.homePrimary : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: day.isSelected
            ? null
            : Border.all(color: Colors.transparent),
      ),
      child: Column(
        children: [
          Text(day.day,
              style: TextStyle(
                color: day.isSelected
                    ? AppColors.whiteColor.withValues(alpha: 0.7)
                    : AppColors.homeSubtitleText,
                fontSize: AppTextSize.labelSmall(context),
              )),
          const SizedBox(height: 2),
          Text('${day.date}',
              style: TextStyle(
                color: day.isSelected
                    ? AppColors.whiteColor
                    : AppColors.homeTitleText,
                fontSize: AppTextSize.bodySmall(context),
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}
