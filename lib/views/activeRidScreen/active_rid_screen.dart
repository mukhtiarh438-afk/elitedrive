import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_icon_size.dart';
import '../../core/app_padings.dart';
import '../../core/app_spacing.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_size.dart';

class ActiveRideScreen extends StatelessWidget {
  const ActiveRideScreen.ActiveRidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.activeRideBg,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: AppPaddings.hL(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.vM(context),
              _buildArrivingSection(context),
              AppSpacing.vL(context),
              _buildRouteCard(context),
              AppSpacing.vM(context),
              _buildDriverCard(context),
              AppSpacing.vXL(context),
              _buildSafetyToolkit(context),
              AppSpacing.vM(context),
              _buildVerificationCard(context),
              AppSpacing.vXL(context),
              _buildStartBanner(context),
              AppSpacing.vXL(context),
            ],
          ),
        ),
      ),
    );
  }

  // ── APP BAR ──────────────────────────────────────────
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.activeRideBg,
      elevation: 0,
      leadingWidth: AppSpacing.isTablet(context) ? 68 : 56,
      leading: Padding(
        padding: EdgeInsets.only(
            left: AppPaddings.val(context, mobile: 16, tablet: 20)),
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
          padding: EdgeInsets.only(
              right: AppPaddings.val(context, mobile: 16, tablet: 20)),
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

  // ── ARRIVING SECTION ─────────────────────────────────
  Widget _buildArrivingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.arrivingIn,
            style: TextStyle(
              color: AppColors.homeSubtitleText,
              fontSize: AppTextSize.labelMedium(context),
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            )),
        AppSpacing.vXS(context),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(AppStrings.arrivingMins,
                style: TextStyle(
                  color: AppColors.arrivingMinColor,
                  fontSize: AppTextSize.displayLarge(context) * 1.8,
                  fontWeight: FontWeight.bold,
                  height: 1,
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 6),
              child: Text(AppStrings.arrivingUnit,
                  style: TextStyle(
                    color: AppColors.homeTitleText,
                    fontSize: AppTextSize.headlineLarge(context),
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ],
        ),
        AppSpacing.vS(context),
        // Traffic badge
        Container(
          padding: AppPaddings.symmetric(
              context, mH: 12, tH: 16, mV: 6, tV: 8),
          decoration: BoxDecoration(
            color: AppColors.trafficBadgeBg,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                  radius: 5, backgroundColor: AppColors.trafficDot),
              const SizedBox(width: 6),
              Text(AppStrings.normalTraffic,
                  style: TextStyle(
                    color: AppColors.homeTitleText,
                    fontSize: AppTextSize.labelMedium(context),
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  // ── ROUTE CARD ───────────────────────────────────────
  Widget _buildRouteCard(BuildContext context) {
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
          _routeRow(context,
              icon: Icons.navigation,
              iconColor: AppColors.routeIconNav,
              iconBg: AppColors.homePrimary,
              label: AppStrings.currentLocation,
              address: AppStrings.currentAddr),
          _routeDivider(),
          _routeRow(context,
              icon: Icons.circle,
              iconColor: AppColors.routeIconStop,
              iconBg: AppColors.homeBackground,
              label: AppStrings.nextStop,
              address: AppStrings.nextStopAddr),
          _routeDivider(),
          _routeRow(context,
              icon: Icons.location_on,
              iconColor: AppColors.whiteColor,
              iconBg: AppColors.homePrimary,
              label: AppStrings.finalDestination,
              address: AppStrings.finalAddr),
        ],
      ),
    );
  }

  Widget _routeRow(BuildContext context,
      {required IconData icon,
      required Color iconColor,
      required Color iconBg,
      required String label,
      required String address}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppSpacing.isTablet(context) ? 10 : 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: AppIconSize.sm(context)),
          ),
          AppSpacing.hM(context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                    color: AppColors.homeSubtitleText,
                    fontSize: AppTextSize.labelSmall(context),
                  )),
              Text(address,
                  style: TextStyle(
                    color: AppColors.homeTitleText,
                    fontSize: AppTextSize.bodySmall(context),
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _routeDivider() {
    return const Padding(
      padding: EdgeInsets.only(left: 17),
      child: SizedBox(
        height: 16,
        child: VerticalDivider(
            width: 2, thickness: 2, color: AppColors.routeLine),
      ),
    );
  }

  // ── DRIVER CARD ──────────────────────────────────────
  Widget _buildDriverCard(BuildContext context) {
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
      child: Row(
        children: [
          // Avatar + PRO badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: AppSpacing.isTablet(context) ? 36 : 28,
                backgroundColor: AppColors.homeAvatarBg,
                backgroundImage:
                    const NetworkImage('https://i.pravatar.cc/150?img=11'),
              ),
              Positioned(
                bottom: -4,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.proBadgeBg,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(AppStrings.proBadge,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: AppTextSize.labelSmall(context) - 1,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.hM(context),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.driverName,
                    style: TextStyle(
                      color: AppColors.homeTitleText,
                      fontSize: AppTextSize.titleSmall(context),
                      fontWeight: FontWeight.bold,
                    )),
                AppSpacing.vXS(context),
                Text(AppStrings.driverCar,
                    style: TextStyle(
                      color: AppColors.homeSubtitleText,
                      fontSize: AppTextSize.labelMedium(context),
                    )),
                AppSpacing.vXS(context),
                Row(
                  children: [
                    Icon(Icons.star,
                        color: AppColors.homeStarColor,
                        size: AppIconSize.star(context)),
                    const SizedBox(width: 3),
                    Text(AppStrings.driverRating,
                        style: TextStyle(
                          color: AppColors.homeSubtitleText,
                          fontSize: AppTextSize.labelMedium(context),
                        )),
                  ],
                ),
              ],
            ),
          ),
          // Action buttons
          Row(
            children: [
              _actionBtn(context,
                  icon: Icons.message_outlined,
                  bg: AppColors.homeBackground),
              AppSpacing.hS(context),
              _actionBtn(context,
                  icon: Icons.phone,
                  bg: AppColors.homePrimary,
                  iconColor: AppColors.whiteColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(BuildContext context,
      {required IconData icon,
      required Color bg,
      Color iconColor = AppColors.homePrimary}) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: AppIconSize.md(context)),
    );
  }

  // ── SAFETY TOOLKIT ───────────────────────────────────
  Widget _buildSafetyToolkit(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.safetyToolkit,
            style: TextStyle(
              color: AppColors.homeTitleText,
              fontSize: AppTextSize.headlineSmall(context),
              fontWeight: FontWeight.bold,
            )),
        AppSpacing.vM(context),
        Row(
          children: [
            // Emergency SOS
            Expanded(
              child: Container(
                padding: AppPaddings.allM(context),
                decoration: BoxDecoration(
                  color: AppColors.sosCardBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.emergency,
                        color: AppColors.sosIconColor,
                        size: AppIconSize.xl(context)),
                    AppSpacing.vM(context),
                    Text(AppStrings.emergencySOS,
                        style: TextStyle(
                          color: AppColors.sosIconColor,
                          fontSize: AppTextSize.bodySmall(context),
                          fontWeight: FontWeight.bold,
                        )),
                    Text(AppStrings.emergencySub,
                        style: TextStyle(
                          color: AppColors.sosIconColor
                              .withValues(alpha: 0.7),
                          fontSize: AppTextSize.labelMedium(context),
                        )),
                  ],
                ),
              ),
            ),
            AppSpacing.hM(context),
            // Share Trip
            Expanded(
              child: Container(
                padding: AppPaddings.allM(context),
                decoration: BoxDecoration(
                  color: AppColors.shareCardBg,
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
                    Icon(Icons.share_location,
                        color: AppColors.homePrimary,
                        size: AppIconSize.xl(context)),
                    AppSpacing.vM(context),
                    Text(AppStrings.shareTrip,
                        style: TextStyle(
                          color: AppColors.homeTitleText,
                          fontSize: AppTextSize.bodySmall(context),
                          fontWeight: FontWeight.bold,
                        )),
                    Text(AppStrings.shareTripSub,
                        style: TextStyle(
                          color: AppColors.homeSubtitleText,
                          fontSize: AppTextSize.labelMedium(context),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── DRIVER VERIFICATION ──────────────────────────────
  Widget _buildVerificationCard(BuildContext context) {
    return Container(
      padding: AppPaddings.allM(context),
      decoration: BoxDecoration(
        color: AppColors.verifyCardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.verifyIconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.verified,
                color: AppColors.verifyIconColor,
                size: AppIconSize.md(context)),
          ),
          AppSpacing.hM(context),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.driverVerification,
                    style: TextStyle(
                      color: AppColors.homeTitleText,
                      fontSize: AppTextSize.bodySmall(context),
                      fontWeight: FontWeight.bold,
                    )),
                Text(AppStrings.driverVerifiedSub,
                    style: TextStyle(
                      color: AppColors.homeSubtitleText,
                      fontSize: AppTextSize.labelMedium(context),
                    )),
              ],
            ),
          ),
          const Icon(Icons.chevron_right,
              color: AppColors.homeHintText, size: 20),
        ],
      ),
    );
  }

  // ── START BANNER ─────────────────────────────────────
  Widget _buildStartBanner(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.startRacingWork,
        style: TextStyle(
          color: AppColors.homeSubtitleText.withValues(alpha: 0.4),
          fontSize: AppTextSize.headlineMedium(context),
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
