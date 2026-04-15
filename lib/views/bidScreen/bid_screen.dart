import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_icon_size.dart';
import '../../core/app_padings.dart';
import '../../core/app_spacing.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_size.dart';
import '../../models/driver_bid_model.dart';
import '../../view_models/bids_view_model.dart';

class BidScreen extends StatelessWidget {
  const BidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BidsViewModel(),
      child: const _DriverBidsBody(),
    );
  }
}

class _DriverBidsBody extends StatelessWidget {
  const _DriverBidsBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BidsViewModel>();

    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map card
            _buildMapCard(context),
            Padding(
              padding: AppPaddings.hL(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.vL(context),
                  // Tab toggle
                  _buildTabToggle(context, vm),
                  AppSpacing.vXL(context),
                  // Available Bids header
                  _buildBidsHeader(context),
                  AppSpacing.vM(context),
                  // Bid cards
                  ...vm.bids.asMap().entries.map((e) => Padding(
                        padding: EdgeInsets.only(
                            bottom: AppSpacing.isTablet(context) ? 12 : 10),
                        child: _BidCard(bid: e.value, isFirst: e.key == 0),
                      )),
                  AppSpacing.vM(context),
                  // Fixed rate card
                  _buildFixedRateCard(context),
                  AppSpacing.vXL(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  // ── MAP CARD ─────────────────────────────────────────
  Widget _buildMapCard(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    return Container(
      width: screenW,
      height: screenW * 0.45,
      color: AppColors.mapCardBg,
      child: Stack(
        children: [
          // Map grid lines simulation
          CustomPaint(
            size: Size(screenW, screenW * 0.45),
            painter: _MapPainter(),
          ),
          // Pickup info bar at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(
                left: AppPaddings.val(context, mobile: 18, tablet: 28),
                right: AppPaddings.val(context, mobile: 18, tablet: 28),
                bottom: AppPaddings.val(context, mobile: 14, tablet: 20),
              ),
              padding: AppPaddings.symmetric(
                  context, mH: 14, tH: 20, mV: 10, tV: 14),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.homePrimary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.navigation,
                        color: AppColors.whiteColor,
                        size: AppIconSize.sm(context)),
                  ),
                  AppSpacing.hM(context),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.pickupPoint,
                            style: TextStyle(
                              color: AppColors.homeSubtitleText,
                              fontSize: AppTextSize.labelSmall(context),
                              letterSpacing: 0.8,
                            )),
                        Text(AppStrings.pickupLocation,
                            style: TextStyle(
                              color: AppColors.homeTitleText,
                              fontSize: AppTextSize.bodySmall(context),
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(AppStrings.closestDriver,
                          style: TextStyle(
                            color: AppColors.homeSubtitleText,
                            fontSize: AppTextSize.labelSmall(context),
                            letterSpacing: 0.8,
                          )),
                      Text(AppStrings.closestDriverTime,
                          style: TextStyle(
                            color: AppColors.homeTitleText,
                            fontSize: AppTextSize.bodySmall(context),
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── TAB TOGGLE ───────────────────────────────────────
  Widget _buildTabToggle(BuildContext context, BidsViewModel vm) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.homeBackground,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          _tab(context, AppStrings.driverBids, 0, vm),
          _tab(context, AppStrings.fixedPricing, 1, vm),
        ],
      ),
    );
  }

  Widget _tab(BuildContext context, String label, int index, BidsViewModel vm) {
    final selected = vm.selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => vm.selectTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: AppPaddings.symmetric(
              context, mH: 0, tH: 0, mV: 12, tV: 16),
          decoration: BoxDecoration(
            color: selected ? AppColors.bidsTabActiveBg : Colors.transparent,
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
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selected
                    ? AppColors.homeTitleText
                    : AppColors.homeSubtitleText,
                fontSize: AppTextSize.bodySmall(context),
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.w400,
              )),
        ),
      ),
    );
  }

  // ── BIDS HEADER ──────────────────────────────────────
  Widget _buildBidsHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.availableBids,
                  style: TextStyle(
                    color: AppColors.homeTitleText,
                    fontSize: AppTextSize.headlineSmall(context),
                    fontWeight: FontWeight.bold,
                  )),
              Text(AppStrings.choosePreferred,
                  style: TextStyle(
                    color: AppColors.homeSubtitleText,
                    fontSize: AppTextSize.labelMedium(context),
                  )),
            ],
          ),
        ),
        Container(
          padding: AppPaddings.symmetric(
              context, mH: 10, tH: 14, mV: 4, tV: 6),
          decoration: BoxDecoration(
            color: AppColors.newBidsBadgeBg,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(AppStrings.newBids,
              style: TextStyle(
                color: AppColors.newBidsBadgeText,
                fontSize: AppTextSize.labelSmall(context),
                fontWeight: FontWeight.bold,
              )),
        ),
      ],
    );
  }

  // ── FIXED RATE CARD ──────────────────────────────────
  Widget _buildFixedRateCard(BuildContext context) {
    return Container(
      padding: AppPaddings.allM(context),
      decoration: BoxDecoration(
        color: AppColors.fixedRateCardBg,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.fixedRateLockBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.lock,
                        color: AppColors.homePrimary,
                        size: AppIconSize.sm(context)),
                  ),
                  AppSpacing.hM(context),
                  Text(AppStrings.standardFixedRate,
                      style: TextStyle(
                        color: AppColors.homeTitleText,
                        fontSize: AppTextSize.bodySmall(context),
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
              Text(AppStrings.fixedRateAmount,
                  style: TextStyle(
                    color: AppColors.homeTitleText,
                    fontSize: AppTextSize.titleSmall(context),
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          AppSpacing.vM(context),
          Text(AppStrings.fixedRateDesc,
              style: TextStyle(
                color: AppColors.homeSubtitleText,
                fontSize: AppTextSize.labelMedium(context),
                height: 1.5,
              )),
          AppSpacing.vM(context),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: AppPaddings.vM(context),
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppColors.homePrimary, width: 1.5),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(AppStrings.selectFixedPrice,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.homePrimary,
                    fontSize: AppTextSize.bodySmall(context),
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

// ── BID CARD ─────────────────────────────────────────
class _BidCard extends StatelessWidget {
  final DriverBidModel bid;
  final bool isFirst;

  const _BidCard({required this.bid, this.isFirst = false});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Driver info row
          Row(
            children: [
              CircleAvatar(
                radius: AppSpacing.isTablet(context) ? 30 : 24,
                backgroundColor: AppColors.homeAvatarBg,
                backgroundImage: NetworkImage(bid.imageUrl),
              ),
              AppSpacing.hM(context),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(bid.name,
                              style: TextStyle(
                                color: AppColors.homeTitleText,
                                fontSize: AppTextSize.bodySmall(context),
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        if (bid.isFavorite) ...[
                          AppSpacing.hXS(context),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.favoriteBadgeBg,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(AppStrings.favoriteBadge,
                                style: TextStyle(
                                  color: AppColors.favoriteBadgeText,
                                  fontSize:
                                      AppTextSize.labelSmall(context) - 1,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ],
                    ),
                    AppSpacing.vXS(context),
                    Text(bid.car,
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
                        Text(bid.rating,
                            style: TextStyle(
                              color: AppColors.homeSubtitleText,
                              fontSize: AppTextSize.labelMedium(context),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.vM(context),
          // Bid amount + Accept button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.currentBid,
                      style: TextStyle(
                        color: AppColors.homeSubtitleText,
                        fontSize: AppTextSize.labelSmall(context),
                        letterSpacing: 0.8,
                      )),
                  Text(bid.bid,
                      style: TextStyle(
                        color: AppColors.homeTitleText,
                        fontSize: AppTextSize.headlineMedium(context),
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: AppPaddings.symmetric(
                      context, mH: 24, tH: 32, mV: 12, tV: 16),
                  decoration: BoxDecoration(
                    color: isFirst
                        ? AppColors.acceptBtnActive
                        : AppColors.acceptBtnInactive,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(AppStrings.acceptBid,
                      style: TextStyle(
                        color: isFirst
                            ? AppColors.whiteColor
                            : AppColors.homeTitleText,
                        fontSize: AppTextSize.bodySmall(context),
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── MAP PAINTER ──────────────────────────────────────
class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCDD8D2)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Horizontal lines
    for (double y = 0; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Vertical lines
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
