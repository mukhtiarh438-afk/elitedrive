import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_icon_size.dart';
import '../../core/app_padings.dart';
import '../../core/app_spacing.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_size.dart';

class FleetOwnerScreen extends StatefulWidget {
  const FleetOwnerScreen({super.key});

  @override
  State<FleetOwnerScreen> createState() => _FleetOwnerScreenState();
}

class _FleetOwnerScreenState extends State<FleetOwnerScreen> {
  int _selectedTab = 0; // 0=Owner, 1=Driver

  final List<double> _chartData = [18, 25, 22, 30, 28, 35, 42];
  final List<String> _chartLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
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
              AppSpacing.vM(context),
              Text(AppStrings.totalFleetPerf,
                  style: TextStyle(
                    color: AppColors.homeTitleText,
                    fontSize: AppTextSize.headlineSmall(context),
                    fontWeight: FontWeight.bold,
                  )),
              AppSpacing.vM(context),
              _buildRevenueChart(context),
              AppSpacing.vM(context),
              _buildStatsRow(context),
              AppSpacing.vXL(context),
              _buildManageFleetHeader(context),
              AppSpacing.vM(context),
              _buildVehicleCard(context,
                  name: AppStrings.vehicle1Name,
                  status: AppStrings.vehicle1Status,
                  isInService: true,
                  badge: AppStrings.vehicle1Badge,
                  showAssign: false),
              AppSpacing.vS(context),
              _buildVehicleCard(context,
                  name: AppStrings.vehicle2Name,
                  status: AppStrings.vehicle2Status,
                  isInService: false,
                  badge: '',
                  showAssign: true),
              AppSpacing.vXL(context),
              Text(AppStrings.driverManagement,
                  style: TextStyle(
                    color: AppColors.homeTitleText,
                    fontSize: AppTextSize.headlineSmall(context),
                    fontWeight: FontWeight.bold,
                  )),
              AppSpacing.vM(context),
              _buildDriversRow(context),
              AppSpacing.vXL(context),
              _buildOwnerDriverToggle(context),
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
      backgroundColor: AppColors.homeBackground,
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

  // ── REVENUE CHART ────────────────────────────────────
  Widget _buildRevenueChart(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.monthlyRevenue,
              style: TextStyle(
                color: AppColors.homeSubtitleText,
                fontSize: AppTextSize.labelMedium(context),
              )),
          AppSpacing.vXS(context),
          Text(AppStrings.fleetRevenue,
              style: TextStyle(
                color: AppColors.homeTitleText,
                fontSize: AppTextSize.displayMedium(context),
                fontWeight: FontWeight.bold,
              )),
          AppSpacing.vXS(context),
          Container(
            padding: AppPaddings.symmetric(
                context, mH: 8, tH: 12, mV: 3, tV: 5),
            decoration: BoxDecoration(
              color: AppColors.couponGreenBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.trending_up,
                    color: AppColors.couponGreenText, size: 14),
                const SizedBox(width: 4),
                Text(AppStrings.fleetGrowth,
                    style: TextStyle(
                      color: AppColors.couponGreenText,
                      fontSize: AppTextSize.labelSmall(context),
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          AppSpacing.vL(context),
          SizedBox(
            height: 140,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 50,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (val, meta) {
                        final idx = val.toInt();
                        if (idx < 0 || idx >= _chartLabels.length) {
                          return const SizedBox.shrink();
                        }
                        return Text(_chartLabels[idx],
                            style: TextStyle(
                              color: AppColors.homeSubtitleText,
                              fontSize: AppTextSize.labelSmall(context) - 1,
                            ));
                      },
                      reservedSize: 22,
                    ),
                  ),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: _chartData.asMap().entries.map((e) {
                  final isLast = e.key == _chartData.length - 1;
                  return BarChartGroupData(
                    x: e.key,
                    barRods: [
                      BarChartRodData(
                        toY: e.value,
                        color: isLast
                            ? AppColors.fleetChartBarActive
                            : AppColors.fleetChartBarInactive,
                        width: 22,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(6)),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── STATS ROW ────────────────────────────────────────
  Widget _buildStatsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _statCard(context,
              icon: Icons.directions_car,
              label: AppStrings.activeFleet,
              value: AppStrings.activeFleetVal),
        ),
        AppSpacing.hS(context),
        Expanded(
          child: _statCard(context,
              icon: Icons.bolt,
              label: AppStrings.avgEfficiency,
              value: AppStrings.avgEfficiencyVal),
        ),
      ],
    );
  }

  Widget _statCard(BuildContext context,
      {required IconData icon,
      required String label,
      required String value}) {
    return Container(
      padding: AppPaddings.allM(context),
      decoration: BoxDecoration(
        color: AppColors.fleetStatCardBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,
              color: AppColors.homePrimary,
              size: AppIconSize.md(context)),
          AppSpacing.vS(context),
          Text(label,
              style: TextStyle(
                color: AppColors.homeSubtitleText,
                fontSize: AppTextSize.labelMedium(context),
              )),
          AppSpacing.vXS(context),
          Text(value,
              style: TextStyle(
                color: AppColors.homeTitleText,
                fontSize: AppTextSize.headlineSmall(context),
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

  // ── MANAGE FLEET HEADER ──────────────────────────────
  Widget _buildManageFleetHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.manageFleet,
                style: TextStyle(
                  color: AppColors.homeTitleText,
                  fontSize: AppTextSize.headlineSmall(context),
                  fontWeight: FontWeight.bold,
                )),
            Text(AppStrings.manageFleetSub,
                style: TextStyle(
                  color: AppColors.homeSubtitleText,
                  fontSize: AppTextSize.labelMedium(context),
                )),
          ],
        ),
        Text(AppStrings.viewAll,
            style: TextStyle(
              color: AppColors.homeLinkBlue,
              fontSize: AppTextSize.bodySmall(context),
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }

  // ── VEHICLE CARD ─────────────────────────────────────
  Widget _buildVehicleCard(BuildContext context,
      {required String name,
      required String status,
      required bool isInService,
      required String badge,
      required bool showAssign}) {
    return Container(
      padding: AppPaddings.allM(context),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
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
          // Car image placeholder
          Container(
            width: 70,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.homeBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.directions_car,
                color: AppColors.homePrimary,
                size: AppIconSize.xl(context)),
          ),
          AppSpacing.hM(context),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                      color: AppColors.homeTitleText,
                      fontSize: AppTextSize.bodySmall(context),
                      fontWeight: FontWeight.w600,
                    )),
                AppSpacing.vXS(context),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: isInService
                          ? AppColors.vehicleInService
                          : AppColors.vehicleMaintenance,
                    ),
                    const SizedBox(width: 5),
                    Text(status,
                        style: TextStyle(
                          color: AppColors.homeSubtitleText,
                          fontSize: AppTextSize.labelMedium(context),
                        )),
                  ],
                ),
              ],
            ),
          ),
          if (badge.isNotEmpty)
            Container(
              padding: AppPaddings.symmetric(
                  context, mH: 8, tH: 12, mV: 3, tV: 5),
              decoration: BoxDecoration(
                color: AppColors.homeBackground,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Text(badge,
                      style: TextStyle(
                        color: AppColors.homeSubtitleText,
                        fontSize: AppTextSize.labelSmall(context),
                        fontWeight: FontWeight.w600,
                      )),
                  AppSpacing.hXS(context),
                  const CircleAvatar(
                    radius: 10,
                    backgroundImage:
                        NetworkImage('https://i.pravatar.cc/150?img=5'),
                  ),
                ],
              ),
            ),
          if (showAssign)
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: AppPaddings.symmetric(
                    context, mH: 14, tH: 20, mV: 6, tV: 8),
                decoration: BoxDecoration(
                  color: AppColors.assignBtnBg,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(AppStrings.assignDriver,
                    style: TextStyle(
                      color: AppColors.assignBtnText,
                      fontSize: AppTextSize.labelMedium(context),
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
        ],
      ),
    );
  }

  // ── DRIVERS ROW ──────────────────────────────────────
  Widget _buildDriversRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _driverCard(context,
              name: AppStrings.fleetDriver1,
              rating: AppStrings.fleetDriver1Rating,
              rides: AppStrings.fleetDriver1Rides,
              shift: AppStrings.fleetDriver1Shift,
              imageUrl: 'https://i.pravatar.cc/150?img=11'),
        ),
        AppSpacing.hS(context),
        Expanded(
          child: _driverCard(context,
              name: AppStrings.fleetDriver2,
              rating: AppStrings.fleetDriver2Rating,
              rides: AppStrings.fleetDriver2Rides,
              shift: AppStrings.fleetDriver2Shift,
              imageUrl: 'https://i.pravatar.cc/150?img=5'),
        ),
      ],
    );
  }

  Widget _driverCard(BuildContext context,
      {required String name,
      required String rating,
      required String rides,
      required String shift,
      required String imageUrl}) {
    return Container(
      padding: AppPaddings.allM(context),
      decoration: BoxDecoration(
        color: AppColors.driverCardBg,
        borderRadius: BorderRadius.circular(14),
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
          Row(
            children: [
              CircleAvatar(
                radius: AppSpacing.isTablet(context) ? 24 : 20,
                backgroundImage: NetworkImage(imageUrl),
              ),
              AppSpacing.hS(context),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                          color: AppColors.homeTitleText,
                          fontSize: AppTextSize.bodySmall(context),
                          fontWeight: FontWeight.w600,
                        )),
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: AppColors.homeStarColor,
                            size: AppIconSize.star(context)),
                        const SizedBox(width: 2),
                        Text(rating,
                            style: TextStyle(
                              color: AppColors.homeSubtitleText,
                              fontSize: AppTextSize.labelSmall(context),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.vM(context),
          _driverStat(context, AppStrings.ridesLabel, rides),
          AppSpacing.vXS(context),
          _driverStat(context, AppStrings.shiftEndLabel, shift),
        ],
      ),
    );
  }

  Widget _driverStat(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              color: AppColors.homeSubtitleText,
              fontSize: AppTextSize.labelMedium(context),
            )),
        Text(value,
            style: TextStyle(
              color: AppColors.homeTitleText,
              fontSize: AppTextSize.labelMedium(context),
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }

  // ── OWNER / DRIVER TOGGLE ────────────────────────────
  Widget _buildOwnerDriverToggle(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.homeBackground,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _toggleTab(context, AppStrings.ownerTab, 0),
            _toggleTab(context, AppStrings.driverTab, 1),
          ],
        ),
      ),
    );
  }

  Widget _toggleTab(BuildContext context, String label, int index) {
    final selected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: AppPaddings.symmetric(
            context, mH: 28, tH: 40, mV: 12, tV: 16),
        decoration: BoxDecoration(
          color: selected ? AppColors.ownerTabActive : Colors.transparent,
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
        child: Text(label,
            style: TextStyle(
              color: selected
                  ? AppColors.homeTitleText
                  : AppColors.homeSubtitleText,
              fontSize: AppTextSize.bodySmall(context),
              fontWeight:
                  selected ? FontWeight.w600 : FontWeight.w400,
            )),
      ),
    );
  }
}
