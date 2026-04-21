import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/app_colors.dart';
import '../../core/app_icon_size.dart';
import '../../core/app_padings.dart';
import '../../core/app_spacing.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_size.dart';
import '../../view_models/rides_view_model.dart';
import 'widgets/online_toggle.dart';
import 'widgets/performance_card.dart';
import 'widgets/ride_request_card.dart';
import 'widgets/shift_schedule_card.dart';

class DriverDashboardScreen extends StatelessWidget {
  const DriverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RidesViewModel>();

    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: AppPaddings.hL(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.vS(context),
              // Today's Performance label
              Text(AppStrings.todaysPerformance,
                  style: TextStyle(
                    color: AppColors.homeSubtitleText,
                    fontSize: AppTextSize.labelMedium(context),
                  )),
              AppSpacing.vS(context),
              const PerformanceCard(),
              AppSpacing.vL(context),
              // Online / Offline toggle
              OnlineToggle(
                isOnline: vm.isOnline,
                onToggle: vm.toggleStatus,
              ),
              AppSpacing.vXL(context),
              // Shift Schedule
              _buildSectionHeader(context, AppStrings.shiftSchedule, AppStrings.viewAll),
              AppSpacing.vM(context),
              ShiftScheduleCard(days: vm.shiftDays),
              AppSpacing.vXL(context),
              // Live Requests
              _buildLiveRequestsHeader(context),
              AppSpacing.vM(context),
              ...vm.requests.map((r) => Padding(
                    padding: EdgeInsets.only(
                        bottom: AppSpacing.isTablet(context) ? 14 : 10),
                    child: RideRequestCard(request: r),
                  )),
              AppSpacing.vXL(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final leadingPad = AppPaddings.val(context, mobile: 16, tablet: 20);
    final actionPad  = AppPaddings.val(context, mobile: 16, tablet: 20);

    return AppBar(
      backgroundColor: AppColors.homeBackground,
      elevation: 0,
      leadingWidth: AppSpacing.isTablet(context) ? 68 : 56,
      leading: Padding(
        padding: EdgeInsets.only(left: leadingPad),
        child: CircleAvatar(
          backgroundColor: AppColors.homePrimary,
          child: Icon(Icons.person,
              color: AppColors.whiteColor,
              size: AppIconSize.avatar(context)),
        ),
      ),
      title: Text(AppStrings.appTitle,
          style: TextStyle(
            color: AppColors.homeTitleText,
            fontSize: AppTextSize.titleLarge(context),
            fontWeight: FontWeight.w600,
          )),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: actionPad),
          child: IconButton(
            icon: Icon(Icons.notifications,
                color: AppColors.homeTitleText,
                size: AppIconSize.appBar(context)),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
              color: AppColors.homeTitleText,
              fontSize: AppTextSize.headlineSmall(context),
              fontWeight: FontWeight.bold,
            )),
        GestureDetector(
          onTap: () {},
          child: Text(action,
              style: TextStyle(
                color: AppColors.homeLinkBlue,
                fontSize: AppTextSize.bodySmall(context),
                fontWeight: FontWeight.w600,
              )),
        ),
      ],
    );
  }

  Widget _buildLiveRequestsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppStrings.liveRequests,
            style: TextStyle(
              color: AppColors.homeTitleText,
              fontSize: AppTextSize.headlineSmall(context),
              fontWeight: FontWeight.bold,
            )),
        Container(
          padding: AppPaddings.symmetric(context, mH: 10, tH: 14, mV: 4, tV: 6),
          decoration: BoxDecoration(
            color: AppColors.ridesHighDemand,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(AppStrings.highDemand,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: AppTextSize.labelSmall(context),
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              )),
        ),
      ],
    );
  }
}
