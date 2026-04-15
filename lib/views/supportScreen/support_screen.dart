import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_icon_size.dart';
import '../../core/app_padings.dart';
import '../../core/app_spacing.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_size.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

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
              AppSpacing.vS(context),
              // HOW CAN WE HELP?
              Text(AppStrings.supportTagline,
                  style: TextStyle(
                    color: AppColors.homeSubtitleText,
                    fontSize: AppTextSize.labelMedium(context),
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w500,
                  )),
              AppSpacing.vXS(context),
              Text(AppStrings.support,
                  style: TextStyle(
                    color: AppColors.homeTitleText,
                    fontSize: AppTextSize.displaySmall(context),
                    fontWeight: FontWeight.bold,
                  )),
              AppSpacing.vL(context),
              // Search bar
              _buildSearchBar(context),
              AppSpacing.vXL(context),
              // Quick Help
              Text(AppStrings.quickHelp,
                  style: TextStyle(
                    color: AppColors.homeTitleText,
                    fontSize: AppTextSize.headlineSmall(context),
                    fontWeight: FontWeight.bold,
                  )),
              AppSpacing.vM(context),
              _buildQuickHelpGrid(context),
              AppSpacing.vXL(context),
              // Live Chat card
              _buildLiveChatCard(context),
              AppSpacing.vXL(context),
              // File a Complaint
              _buildComplaintCard(context),
              AppSpacing.vXL(context),
              // Help Center Articles
              _buildArticlesSection(context),
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

  // ── SEARCH BAR ───────────────────────────────────────
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: AppSpacing.isTablet(context) ? 56 : 48,
      decoration: BoxDecoration(
        color: AppColors.supportSearchBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: AppStrings.searchHelp,
          hintStyle: TextStyle(
            color: AppColors.homeHintText,
            fontSize: AppTextSize.bodySmall(context),
          ),
          prefixIcon: Icon(Icons.search,
              color: AppColors.homeHintText,
              size: AppIconSize.appBar(context)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  // ── QUICK HELP GRID ──────────────────────────────────
  Widget _buildQuickHelpGrid(BuildContext context) {
    final items = [
      (Icons.directions_car, AppStrings.tripIssues),
      (Icons.account_balance_wallet, AppStrings.payment),
      (Icons.manage_accounts, AppStrings.account),
      (Icons.shield, AppStrings.safety),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: AppSpacing.isTablet(context) ? 2.2 : 2.0,
      children: items
          .map((item) => _quickHelpCard(context, item.$1, item.$2))
          .toList(),
    );
  }

  Widget _quickHelpCard(
      BuildContext context, IconData icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.quickHelpCardBg,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: AppColors.homePrimary,
                size: AppIconSize.md(context)),
            AppSpacing.vXS(context),
            Text(label,
                style: TextStyle(
                  color: AppColors.homeTitleText,
                  fontSize: AppTextSize.labelMedium(context),
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      ),
    );
  }

  // ── LIVE CHAT CARD ───────────────────────────────────
  Widget _buildLiveChatCard(BuildContext context) {
    return Container(
      padding: AppPaddings.allM(context),
      decoration: BoxDecoration(
        color: AppColors.liveChatCardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.needInstantAnswer,
                    style: TextStyle(
                      color: AppColors.homeTitleText,
                      fontSize: AppTextSize.titleSmall(context),
                      fontWeight: FontWeight.bold,
                    )),
                AppSpacing.vXS(context),
                Text(AppStrings.instantAnswerSub,
                    style: TextStyle(
                      color: AppColors.homeSubtitleText,
                      fontSize: AppTextSize.labelMedium(context),
                      height: 1.4,
                    )),
              ],
            ),
          ),
          AppSpacing.hM(context),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: AppPaddings.symmetric(
                  context, mH: 14, tH: 20, mV: 10, tV: 14),
              decoration: BoxDecoration(
                color: AppColors.liveChatBtnBg,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.chat_bubble,
                      color: AppColors.whiteColor,
                      size: AppIconSize.sm(context)),
                  AppSpacing.hXS(context),
                  Text(AppStrings.liveChat,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: AppTextSize.labelMedium(context),
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── FILE A COMPLAINT ─────────────────────────────────
  Widget _buildComplaintCard(BuildContext context) {
    return Container(
      padding: AppPaddings.allM(context),
      decoration: BoxDecoration(
        color: AppColors.complaintCardBg,
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
          Text(AppStrings.fileComplaint,
              style: TextStyle(
                color: AppColors.homeTitleText,
                fontSize: AppTextSize.headlineSmall(context),
                fontWeight: FontWeight.bold,
              )),
          AppSpacing.vXS(context),
          Text(AppStrings.complaintSub,
              style: TextStyle(
                color: AppColors.homeSubtitleText,
                fontSize: AppTextSize.labelMedium(context),
              )),
          AppSpacing.vL(context),
          // SELECT RECENT RIDE
          _fieldLabel(context, AppStrings.selectRecentRide),
          AppSpacing.vXS(context),
          _inputField(context,
              hint: AppStrings.recentRideHint,
              suffix: const Icon(Icons.keyboard_arrow_down,
                  color: AppColors.homeHintText)),
          AppSpacing.vM(context),
          // ISSUE TYPE
          _fieldLabel(context, AppStrings.issueType),
          AppSpacing.vXS(context),
          _inputField(context,
              hint: AppStrings.issueHint,
              suffix: const Icon(Icons.keyboard_arrow_down,
                  color: AppColors.homeHintText)),
          AppSpacing.vM(context),
          // MESSAGE
          _fieldLabel(context, AppStrings.messageLabel),
          AppSpacing.vXS(context),
          Container(
            height: 100,
            padding: AppPaddings.allM(context),
            decoration: BoxDecoration(
              color: AppColors.inputFieldBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                hintText: AppStrings.messageHint,
                hintStyle: TextStyle(
                  color: AppColors.homeHintText,
                  fontSize: AppTextSize.bodySmall(context),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          AppSpacing.vL(context),
          // Submit button
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: AppPaddings.vM(context),
              decoration: BoxDecoration(
                color: AppColors.submitBtnBg,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(AppStrings.submitReport,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: AppTextSize.bodySmall(context),
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(BuildContext context, String label) {
    return Text(label,
        style: TextStyle(
          color: AppColors.homeSubtitleText,
          fontSize: AppTextSize.labelSmall(context),
          letterSpacing: 0.8,
          fontWeight: FontWeight.w600,
        ));
  }

  Widget _inputField(BuildContext context,
      {required String hint, Widget? suffix}) {
    return Container(
      padding: AppPaddings.symmetric(
          context, mH: 14, tH: 18, mV: 12, tV: 16),
      decoration: BoxDecoration(
        color: AppColors.inputFieldBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(hint,
                style: TextStyle(
                  color: AppColors.homeHintText,
                  fontSize: AppTextSize.bodySmall(context),
                )),
          ),
          if (suffix != null) suffix,
        ],
      ),
    );
  }

  // ── HELP CENTER ARTICLES ─────────────────────────────
  Widget _buildArticlesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.helpCenterArticles,
                style: TextStyle(
                  color: AppColors.homeTitleText,
                  fontSize: AppTextSize.headlineSmall(context),
                  fontWeight: FontWeight.bold,
                )),
            Text(AppStrings.viewAll,
                style: TextStyle(
                  color: AppColors.homeLinkBlue,
                  fontSize: AppTextSize.bodySmall(context),
                  fontWeight: FontWeight.w600,
                )),
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
              _articleTile(context,
                  iconBg: AppColors.articleIconBg1,
                  icon: Icons.help,
                  iconColor: AppColors.homePrimary,
                  title: AppStrings.article1Title,
                  meta: AppStrings.article1Meta),
              const Divider(height: 1, indent: 64, color: Color(0xFFF0F4F8)),
              _articleTile(context,
                  iconBg: AppColors.articleIconBg2,
                  icon: Icons.receipt,
                  iconColor: AppColors.homePrimary,
                  title: AppStrings.article2Title,
                  meta: AppStrings.article2Meta),
              const Divider(height: 1, indent: 64, color: Color(0xFFF0F4F8)),
              _articleTile(context,
                  iconBg: AppColors.articleIconBg3,
                  icon: Icons.business_center,
                  iconColor: AppColors.multiStopIcon,
                  title: AppStrings.article3Title,
                  meta: AppStrings.article3Meta),
            ],
          ),
        ),
      ],
    );
  }

  Widget _articleTile(BuildContext context,
      {required Color iconBg,
      required IconData icon,
      required Color iconColor,
      required String title,
      required String meta}) {
    return ListTile(
      contentPadding: AppPaddings.symmetric(
          context, mH: 16, tH: 20, mV: 6, tV: 8),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: AppIconSize.md(context)),
      ),
      title: Text(title,
          style: TextStyle(
            color: AppColors.homeTitleText,
            fontSize: AppTextSize.bodySmall(context),
            fontWeight: FontWeight.w600,
          )),
      subtitle: Text(meta,
          style: TextStyle(
            color: AppColors.homeSubtitleText,
            fontSize: AppTextSize.labelMedium(context),
          )),
      trailing: const Icon(Icons.chevron_right,
          color: AppColors.homeHintText, size: 20),
      onTap: () {},
    );
  }
}
