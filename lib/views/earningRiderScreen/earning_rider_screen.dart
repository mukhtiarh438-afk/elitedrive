import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_icon_size.dart';
import '../../core/app_padings.dart';
import '../../core/app_spacing.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_size.dart';
import '../../view_models/earnings_view_model.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<EarningsViewModel>();

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
              _buildBalanceSection(context),
              AppSpacing.vL(context),
              _buildLoyaltyRow(context),
              AppSpacing.vXL(context),
              _buildPaymentMethods(context, vm),
              AppSpacing.vXL(context),
              _buildActiveCoupons(context),
              AppSpacing.vXL(context),
              _buildRecentTransactions(context, vm),
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

  // ── BALANCE ──────────────────────────────────────────
  Widget _buildBalanceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.currentBalance,
            style: TextStyle(
              color: AppColors.homeSubtitleText,
              fontSize: AppTextSize.labelMedium(context),
              letterSpacing: 0.8,
            )),
        AppSpacing.vXS(context),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(AppStrings.balanceAmount,
                style: TextStyle(
                  color: AppColors.homeTitleText,
                  fontSize: AppTextSize.displayMedium(context),
                  fontWeight: FontWeight.bold,
                )),
            AppSpacing.hS(context),
            Container(
              padding: AppPaddings.symmetric(
                  context, mH: 8, tH: 12, mV: 3, tV: 5),
              decoration: BoxDecoration(
                color: AppColors.couponGreenBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(AppStrings.balanceGrowth,
                  style: TextStyle(
                    color: AppColors.couponGreenText,
                    fontSize: AppTextSize.labelSmall(context),
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ],
    );
  }

  // ── LOYALTY ROW ──────────────────────────────────────
  Widget _buildLoyaltyRow(BuildContext context) {
    return Row(
      children: [
        // Loyalty Points card
        Expanded(
          child: Container(
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
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.homeBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.star,
                      color: AppColors.homePrimary,
                      size: AppIconSize.md(context)),
                ),
                AppSpacing.vM(context),
                Text(AppStrings.availableLoyalty,
                    style: TextStyle(
                      color: AppColors.homeSubtitleText,
                      fontSize: AppTextSize.labelSmall(context),
                      letterSpacing: 0.5,
                    )),
                AppSpacing.vXS(context),
                Text(AppStrings.loyaltyPoints,
                    style: TextStyle(
                      color: AppColors.homeTitleText,
                      fontSize: AppTextSize.headlineMedium(context),
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
        ),
        AppSpacing.hS(context),
        // Gold Status card
        Expanded(
          child: Container(
            padding: AppPaddings.allM(context),
            decoration: BoxDecoration(
              color: AppColors.goldCardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.emoji_events,
                      color: AppColors.goldProgressColor,
                      size: AppIconSize.md(context)),
                ),
                AppSpacing.vM(context),
                Text(AppStrings.unlockableTiers,
                    style: TextStyle(
                      color: AppColors.whiteColor.withValues(alpha: 0.7),
                      fontSize: AppTextSize.labelSmall(context),
                      letterSpacing: 0.5,
                    )),
                AppSpacing.vXS(context),
                Text(AppStrings.goldStatus,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: AppTextSize.titleSmall(context),
                      fontWeight: FontWeight.bold,
                    )),
                AppSpacing.vS(context),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.65,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor: const AlwaysStoppedAnimation(
                        AppColors.goldProgressColor),
                    minHeight: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── PAYMENT METHODS ──────────────────────────────────
  Widget _buildPaymentMethods(BuildContext context, EarningsViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.paymentMethods,
                style: TextStyle(
                  color: AppColors.homeTitleText,
                  fontSize: AppTextSize.headlineSmall(context),
                  fontWeight: FontWeight.bold,
                )),
            GestureDetector(
              onTap: () {},
              child: Text(AppStrings.addNew,
                  style: TextStyle(
                    color: AppColors.homeLinkBlue,
                    fontSize: AppTextSize.bodySmall(context),
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ],
        ),
        AppSpacing.vM(context),
        Container(
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
              _paymentTile(context,
                  icon: Icons.credit_card,
                  title: AppStrings.card4242,
                  subtitle: AppStrings.cardExp,
                  trailing: const Icon(Icons.circle,
                      color: AppColors.homePrimary, size: 10)),
              const Divider(height: 1, indent: 64, color: Color(0xFFF0F4F8)),
              _paymentTile(context,
                  icon: Icons.apple,
                  title: AppStrings.applePay,
                  subtitle: AppStrings.applePaySub,
                  trailing: const Icon(Icons.chevron_right,
                      color: AppColors.homeHintText, size: 20)),
              const Divider(height: 1, indent: 64, color: Color(0xFFF0F4F8)),
              _paymentTile(context,
                  icon: Icons.money,
                  title: AppStrings.cashPayment,
                  subtitle: '',
                  trailing: Switch(
                    value: vm.cashPaymentEnabled,
                    onChanged: vm.toggleCash,
                    activeColor: AppColors.homePrimary,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _paymentTile(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required Widget trailing}) {
    return ListTile(
      contentPadding:
          AppPaddings.symmetric(context, mH: 16, tH: 20, mV: 4, tV: 6),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.homeBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon,
            color: AppColors.homePrimary,
            size: AppIconSize.md(context)),
      ),
      title: Text(title,
          style: TextStyle(
            color: AppColors.homeTitleText,
            fontSize: AppTextSize.bodySmall(context),
            fontWeight: FontWeight.w600,
          )),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle,
              style: TextStyle(
                color: AppColors.homeSubtitleText,
                fontSize: AppTextSize.labelMedium(context),
              ))
          : null,
      trailing: trailing,
    );
  }

  // ── ACTIVE COUPONS ───────────────────────────────────
  Widget _buildActiveCoupons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.activeCoupons,
            style: TextStyle(
              color: AppColors.homeTitleText,
              fontSize: AppTextSize.headlineSmall(context),
              fontWeight: FontWeight.bold,
            )),
        AppSpacing.vM(context),
        SizedBox(
          height: 130,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              _couponCard(context,
                  bg: AppColors.couponGreenBg,
                  labelColor: AppColors.couponGreenText,
                  title: AppStrings.coupon1Title,
                  expiry: AppStrings.coupon1Expiry,
                  code: AppStrings.coupon1Code),
              AppSpacing.hM(context),
              _couponCard(context,
                  bg: AppColors.advanceBookingBg,
                  labelColor: AppColors.homePrimary,
                  title: '2x Bonus Points',
                  expiry: 'Active',
                  code: 'BONUS2X'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _couponCard(BuildContext context,
      {required Color bg,
      required Color labelColor,
      required String title,
      required String expiry,
      required String code}) {
    final screenW = MediaQuery.of(context).size.width;
    return Container(
      width: screenW * 0.65,
      padding: AppPaddings.allM(context),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.rideDiscount,
              style: TextStyle(
                color: labelColor.withValues(alpha: 0.7),
                fontSize: AppTextSize.labelSmall(context),
                letterSpacing: 0.8,
                fontWeight: FontWeight.w600,
              )),
          AppSpacing.vXS(context),
          Text(title,
              style: TextStyle(
                color: labelColor,
                fontSize: AppTextSize.titleSmall(context),
                fontWeight: FontWeight.bold,
              )),
          AppSpacing.vXS(context),
          Text(expiry,
              style: TextStyle(
                color: labelColor.withValues(alpha: 0.7),
                fontSize: AppTextSize.labelMedium(context),
              )),
          const Spacer(),
          Row(
            children: [
              Container(
                padding: AppPaddings.symmetric(
                    context, mH: 10, tH: 14, mV: 4, tV: 6),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(code,
                    style: TextStyle(
                      color: labelColor,
                      fontSize: AppTextSize.labelSmall(context),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    )),
              ),
              const Spacer(),
              Icon(Icons.copy, color: labelColor, size: AppIconSize.sm(context)),
            ],
          ),
        ],
      ),
    );
  }

  // ── RECENT TRANSACTIONS ──────────────────────────────
  Widget _buildRecentTransactions(
      BuildContext context, EarningsViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.recentTransactions,
                style: TextStyle(
                  color: AppColors.homeTitleText,
                  fontSize: AppTextSize.headlineSmall(context),
                  fontWeight: FontWeight.bold,
                )),
            GestureDetector(
              onTap: () {},
              child: Text(AppStrings.seeAll,
                  style: TextStyle(
                    color: AppColors.homeLinkBlue,
                    fontSize: AppTextSize.bodySmall(context),
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ],
        ),
        AppSpacing.vM(context),
        Container(
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
            children: vm.transactions.asMap().entries.map((e) {
              final isLast = e.key == vm.transactions.length - 1;
              final tx = e.value;
              return Column(
                children: [
                  ListTile(
                    contentPadding: AppPaddings.symmetric(
                        context, mH: 16, tH: 20, mV: 6, tV: 8),
                    leading: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.homeBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(tx.icon,
                          color: tx.isPositive
                              ? AppColors.txPositive
                              : AppColors.homePrimary,
                          size: AppIconSize.md(context)),
                    ),
                    title: Text(tx.title,
                        style: TextStyle(
                          color: AppColors.homeTitleText,
                          fontSize: AppTextSize.bodySmall(context),
                          fontWeight: FontWeight.w600,
                        )),
                    subtitle: Text(tx.date,
                        style: TextStyle(
                          color: AppColors.homeSubtitleText,
                          fontSize: AppTextSize.labelMedium(context),
                        )),
                    trailing: Text(tx.amount,
                        style: TextStyle(
                          color: tx.isPositive
                              ? AppColors.txPositive
                              : AppColors.txNegative,
                          fontSize: AppTextSize.titleSmall(context),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  if (!isLast)
                    const Divider(
                        height: 1,
                        indent: 64,
                        color: Color(0xFFF0F4F8)),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
