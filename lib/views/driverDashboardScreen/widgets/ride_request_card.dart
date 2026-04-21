import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_padings.dart';
import '../../../core/app_spacing.dart';
import '../../../core/app_strings.dart';
import '../../../core/app_text_size.dart';
import '../../../core/app_icon_size.dart';
import '../../activeRidScreen/active_rid_screen.dart';
import '../../../models/ride_request_model.dart';

class RideRequestCard extends StatelessWidget {
  final RideRequestModel request;

  const RideRequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return request.isMini ? _buildMiniCard(context) : _buildFullCard(context);
  }

  Widget _buildFullCard(BuildContext context) {
    return Container(
      padding: AppPaddings.allM(context),
      decoration: BoxDecoration(
        color: AppColors.ridesRequestBg,
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
          // Passenger info row
          Row(
            children: [
              CircleAvatar(
                radius: AppIconSize.lg(context),
                backgroundColor: AppColors.homeAvatarBg,
                backgroundImage: request.imageUrl.isNotEmpty
                    ? NetworkImage(request.imageUrl)
                    : null,
                child: request.imageUrl.isEmpty
                    ? Icon(Icons.person, size: AppIconSize.md(context))
                    : null,
              ),
              AppSpacing.hM(context),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.passengerName,
                      style: TextStyle(
                        color: AppColors.homeTitleText,
                        fontSize: AppTextSize.bodySmall(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AppSpacing.vXS(context),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.homeStarColor,
                          size: AppIconSize.star(context),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${request.rating} • ${request.milesAway}',
                          style: TextStyle(
                            color: AppColors.homeSubtitleText,
                            fontSize: AppTextSize.labelMedium(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    request.price,
                    style: TextStyle(
                      color: AppColors.homeTitleText,
                      fontSize: AppTextSize.titleMedium(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.vXS(context),
                  Text(
                    request.estTime,
                    style: TextStyle(
                      color: AppColors.homeSubtitleText,
                      fontSize: AppTextSize.labelSmall(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
          AppSpacing.vM(context),
          const Divider(height: 1, color: Color(0xFFF0F4F8)),
          AppSpacing.vM(context),
          // Pickup
          _addressRow(
            context,
            icon: Icons.circle_outlined,
            iconColor: AppColors.ridesPickupIcon,
            label: AppStrings.pickUp,
            address: request.pickupAddress,
          ),
          AppSpacing.vS(context),
          // Dropoff
          _addressRow(
            context,
            icon: Icons.location_on,
            iconColor: AppColors.ridesDropIcon,
            label: AppStrings.dropOff,
            address: request.dropoffAddress,
          ),
          AppSpacing.vM(context),
          // Buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: AppPaddings.vM(context),
                    decoration: BoxDecoration(
                      color: AppColors.ridesDeclineBtn,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      AppStrings.decline,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.homeTitleText,
                        fontSize: AppTextSize.bodySmall(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              AppSpacing.hM(context),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ActiveRideScreen()),
                  ),
                  child: Container(
                    padding: AppPaddings.vM(context),
                    decoration: BoxDecoration(
                      color: AppColors.ridesAcceptBtn,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      AppStrings.acceptRequest,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: AppTextSize.bodySmall(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _addressRow(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required String address,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: AppIconSize.sm(context)),
        AppSpacing.hS(context),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppColors.homeHintText,
                fontSize: AppTextSize.labelSmall(context),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              address,
              style: TextStyle(
                color: AppColors.homeTitleText,
                fontSize: AppTextSize.bodySmall(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMiniCard(BuildContext context) {
    return Container(
      padding: AppPaddings.symmetric(context, mH: 14, tH: 20, mV: 12, tV: 16),
      decoration: BoxDecoration(
        color: AppColors.ridesMiniCard,
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
          CircleAvatar(
            radius: AppIconSize.md(context),
            backgroundColor: AppColors.homeBackground,
            child: Icon(
              Icons.person,
              color: AppColors.homeSubtitleText,
              size: AppIconSize.md(context),
            ),
          ),
          AppSpacing.hM(context),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.passengerName,
                  style: TextStyle(
                    color: AppColors.homeTitleText,
                    fontSize: AppTextSize.bodySmall(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  request.milesAway,
                  style: TextStyle(
                    color: AppColors.homeSubtitleText,
                    fontSize: AppTextSize.labelMedium(context),
                  ),
                ),
              ],
            ),
          ),
          Text(
            request.price,
            style: TextStyle(
              color: AppColors.homeTitleText,
              fontSize: AppTextSize.titleSmall(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpacing.hS(context),
          const Icon(
            Icons.chevron_right,
            color: AppColors.homeHintText,
            size: 20,
          ),
        ],
      ),
    );
  }
}
