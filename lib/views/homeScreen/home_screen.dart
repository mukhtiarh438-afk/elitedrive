import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_padings.dart';
import '../../core/app_spacing.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_size.dart';
import '../../core/app_icon_size.dart';
import '../../view_models/home_view_model.dart';
import 'widgets/booking_option_card.dart';
import 'widgets/driver_avatar.dart';
import 'widgets/fleet_card.dart';
import 'widgets/suggested_place_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ── Helpers ──────────────────────────────────────────
  static bool _isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  @override
  Widget build(BuildContext context) {
    final vm        = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      appBar: _buildAppBar(context),
      body: _buildPortraitBody(context, vm),
      bottomNavigationBar: _buildBottomNavBar(context, vm),
    );
  }

  // ── PORTRAIT BODY ────────────────────────────────────
  Widget _buildPortraitBody(BuildContext context, HomeViewModel vm) {
    final landscape = _isLandscape(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: landscape
            ? AppPaddings.hXL(context)   // landscape — wider horizontal padding
            : AppPaddings.hL(context),   // portrait — normal
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.vS(context),
            _buildGreeting(context),
            AppSpacing.vXL(context),
            _buildSearchBar(context),
            AppSpacing.vL(context),
            _buildBookingCards(context),
            AppSpacing.vXL(context),
            _buildSectionHeader(context, AppStrings.ourFleet, AppStrings.fleetAction),
            AppSpacing.vM(context),
            _buildFleetList(context, vm),
            AppSpacing.vXL(context),
            _buildSuggestedSection(context, vm),
            AppSpacing.vXL(context),
            _buildFavoriteDrivers(context, vm),
            AppSpacing.vXL(context),
          ],
        ),
      ),
    );
  }

  // ── APP BAR ──────────────────────────────────────────
  AppBar _buildAppBar(BuildContext context) {
    final leadingPad = AppPaddings.val(context, mobile: 16, tablet: 20);
    final actionPad  = AppPaddings.val(context, mobile: 16, tablet: 20);
    final landscape  = _isLandscape(context);

    return AppBar(
      backgroundColor: AppColors.homeBackground,
      elevation: 0,
      toolbarHeight: landscape ? 48 : kToolbarHeight,
      leadingWidth: _isTablet(context) ? 68 : 56,
      leading: Padding(
        padding: EdgeInsets.only(left: leadingPad),
        child: CircleAvatar(
          backgroundColor: AppColors.homePrimary,
          child: Icon(Icons.person, color: AppColors.whiteColor,
              size: AppIconSize.avatar(context)),
        ),
      ),
      title: Text(
        AppStrings.appTitle,
        style: TextStyle(
          color: AppColors.homeTitleText,
          fontSize: landscape
              ? AppTextSize.titleSmall(context)
              : AppTextSize.titleLarge(context),
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: actionPad),
          child: IconButton(
            icon: Icon(Icons.notifications,
                color: AppColors.homeTitleText,
                size: landscape
                    ? AppIconSize.sm(context)
                    : AppIconSize.appBar(context)),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  // ── GREETING ─────────────────────────────────────────
  Widget _buildGreeting(BuildContext context) {
    final landscape = _isLandscape(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.greeting,
          style: TextStyle(
            color: AppColors.homeTitleText,
            fontSize: landscape
                ? AppTextSize.headlineLarge(context)
                : AppTextSize.displayMedium(context),
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        AppSpacing.vXS(context),
        Text(
          AppStrings.greetingSubtitle,
          style: TextStyle(
            color: AppColors.homeSubtitleText,
            fontSize: AppTextSize.bodySmall(context),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // ── SEARCH BAR ───────────────────────────────────────
  Widget _buildSearchBar(BuildContext context) {
    final landscape = _isLandscape(context);
    final barHeight = _isTablet(context) ? 62.0 : (landscape ? 46.0 : 54.0);
    final barRadius = _isTablet(context) ? 18.0 : 14.0;
    final vPad      = landscape ? 12.0 : 16.0;

    return Container(
      height: barHeight,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(barRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: AppStrings.searchHint,
          hintStyle: TextStyle(
            color: AppColors.homeHintText,
            fontSize: AppTextSize.bodySmall(context),
          ),
          prefixIcon: Icon(Icons.search,
              color: AppColors.homeHintText,
              size: AppIconSize.appBar(context)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: vPad),
        ),
      ),
    );
  }

  // ── BOOKING CARDS ────────────────────────────────────
  Widget _buildBookingCards(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: BookingOptionCard(
            icon: Icons.calendar_today,
            title: AppStrings.advanceBooking,
            subtitle: AppStrings.advanceBookingSubtitle,
            backgroundColor: AppColors.advanceBookingBg,
            iconColor: AppColors.homePrimary,
            titleColor: AppColors.advanceBookingTitle,
          ),
        ),
        AppSpacing.hM(context),
        Expanded(
          child: BookingOptionCard(
            icon: Icons.alt_route,
            title: AppStrings.multiStop,
            subtitle: AppStrings.multiStopSubtitle,
            backgroundColor: AppColors.multiStopBg,
            iconColor: AppColors.multiStopIcon,
            titleColor: AppColors.multiStopTitle,
            extraBottom: AppTextSize.titleSmall(context) * 1.3,
          ),
        ),
      ],
    );
  }

  // ── SECTION HEADER ───────────────────────────────────
  Widget _buildSectionHeader(BuildContext context, String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.homeTitleText,
            fontSize: AppTextSize.headlineSmall(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            action,
            style: TextStyle(
              color: AppColors.homeSubtitleText,
              fontSize: AppTextSize.labelSmall(context),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    );
  }

  // ── FLEET LIST ───────────────────────────────────────
  Widget _buildFleetList(BuildContext context, HomeViewModel vm) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: vm.fleetOptions.asMap().entries.map((entry) {
          final isLast = entry.key == vm.fleetOptions.length - 1;
          return Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : AppSpacing.isTablet(context) ? 16 : 12),
            child: FleetCard(
              fleet: entry.value,
              onTap: () => vm.selectFleet(entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── SUGGESTED SECTION ────────────────────────────────
  Widget _buildSuggestedSection(BuildContext context, HomeViewModel vm) {
    final cardRadius = _isTablet(context) ? 20.0 : 16.0;
    final cardGap    = _isTablet(context) ? 14.0 : 10.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.suggestedForYou,
          style: TextStyle(
            color: AppColors.homeTitleText,
            fontSize: AppTextSize.headlineSmall(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.vM(context),
        ...vm.suggestedPlaces.map((place) => Padding(
          padding: EdgeInsets.only(bottom: cardGap),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(cardRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SuggestedPlaceTile(place: place),
          ),
        )),
      ],
    );
  }

  // ── FAVORITE DRIVERS ─────────────────────────────────
  Widget _buildFavoriteDrivers(BuildContext context, HomeViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.favoriteDrivers,
              style: TextStyle(
                color: AppColors.homeTitleText,
                fontSize: AppTextSize.headlineSmall(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                AppStrings.viewAll,
                style: TextStyle(
                  color: AppColors.homeLinkBlue,
                  fontSize: AppTextSize.bodySmall(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        AppSpacing.vL(context),
        Row(
          children: vm.drivers
              .map((driver) => DriverAvatar(driver: driver))
              .toList(),
        ),
      ],
    );
  }

  // ── BOTTOM NAV BAR ───────────────────────────────────
  Widget _buildBottomNavBar(BuildContext context, HomeViewModel vm) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: vm.selectedNavIndex,
        onTap: vm.onNavTap,
        backgroundColor: AppColors.whiteColor,
        selectedItemColor: AppColors.homePrimary,
        unselectedItemColor: AppColors.homeHintText,
        selectedLabelStyle: TextStyle(
          fontSize: AppTextSize.labelSmall(context),
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: AppTextSize.labelSmall(context),
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home),
              label: AppStrings.navHome),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              activeIcon: Icon(Icons.directions_car),
              label: AppStrings.navRides),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: AppStrings.navEarnings),
          BottomNavigationBarItem(
              icon: Icon(Icons.help),
              activeIcon: Icon(Icons.help),
              label: AppStrings.navSupport),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              activeIcon: Icon(Icons.person),
              label: AppStrings.navProfile),
        ],
      ),
    );
  }
}
