import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_icon_size.dart';
import '../../core/app_padings.dart';
import '../../core/app_spacing.dart';
import '../../core/app_text_size.dart';

class UserSelectionScreen extends StatelessWidget {
  const UserSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.hXL(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App Logo/Title
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.homePrimary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.homePrimary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.drive_eta,
                  color: AppColors.whiteColor,
                  size: AppIconSize.xl(context) * 1.5,
                ),
              ),
              AppSpacing.vXL(context),
              
              Text(
                'EliteDrive',
                style: TextStyle(
                  fontSize: AppTextSize.displayLarge(context),
                  fontWeight: FontWeight.bold,
                  color: AppColors.homePrimary,
                ),
              ),
              AppSpacing.vM(context),
              
              Text(
                'Choose your journey',
                style: TextStyle(
                  fontSize: AppTextSize.headlineMedium(context),
                  color: AppColors.homeSubtitleText,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppSpacing.vXL(context),
              
              // Customer Option
              _buildUserTypeCard(
                context,
                title: 'I\'m a Customer',
                subtitle: 'Book rides and travel comfortably',
                icon: Icons.person,
                onTap: () => _navigateToCustomerFlow(context),
              ),
              AppSpacing.vL(context),
              
              // Driver Option
              _buildUserTypeCard(
                context,
                title: 'I\'m a Driver',
                subtitle: 'Earn money by driving',
                icon: Icons.drive_eta,
                onTap: () => _navigateToDriverFlow(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserTypeCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: AppPaddings.allL(context),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: AppColors.homePrimary.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.homePrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: AppColors.homePrimary,
                size: AppIconSize.lg(context),
              ),
            ),
            AppSpacing.hL(context),
            
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppTextSize.titleLarge(context),
                      fontWeight: FontWeight.bold,
                      color: AppColors.homeTitleText,
                    ),
                  ),
                  AppSpacing.vXS(context),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: AppTextSize.bodyMedium(context),
                      color: AppColors.homeSubtitleText,
                    ),
                  ),
                ],
              ),
            ),
            
            // Arrow Icon
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.homePrimary,
              size: AppIconSize.sm(context),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCustomerFlow(BuildContext context) {
    Navigator.pushNamed(context, '/customer/home');
  }

  void _navigateToDriverFlow(BuildContext context) {
    Navigator.pushNamed(context, '/driver/dashboard');
  }
}
