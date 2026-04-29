import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_spacing.dart';
import '../../../core/app_text_size.dart';
import '../../../core/app_icon_size.dart';
import '../../../view_models/home_view_model.dart';
import 'route_selection_sheet.dart';

class HomeBottomSheet extends StatefulWidget {
  final ScrollController? scrollController;
  const HomeBottomSheet({super.key, this.scrollController});

  @override
  State<HomeBottomSheet> createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {
  int _selectedRideIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.homeBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRideTypeSelector(context),
                  AppSpacing.vL(context),
                  _buildSearchBar(context),
                  AppSpacing.vL(context),
                  _buildRecentPlaces(context),
                  const SizedBox(height: 100), // Extra space for better scrolling
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRideTypeSelector(BuildContext context) {
    final rideOptions = [
      {'icon': Icons.motorcycle, 'label': 'Moto'},
      {'icon': Icons.directions_car, 'label': 'Ride'},
      {'icon': Icons.electric_rickshaw, 'label': 'Rickshaw'},
      {'icon': Icons.ac_unit, 'label': 'Ride A/C'},
      {'icon': Icons.location_city, 'label': 'City to City'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: rideOptions.asMap().entries.map((entry) {
          final selected = entry.key == _selectedRideIndex;
          final option = entry.value;
          return Padding(
            padding: EdgeInsets.only(
              right: entry.key == rideOptions.length - 1 ? 0 : 12,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedRideIndex = entry.key;
                });
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.homePrimary.withValues(alpha: 0.1)
                          : AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: selected
                            ? AppColors.homePrimary
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      option['icon'] as IconData,
                      color: selected
                          ? AppColors.homePrimary
                          : AppColors.homeTitleText,
                      size: AppIconSize.md(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    option['label'] as String,
                    style: TextStyle(
                      color: selected
                          ? AppColors.homePrimary
                          : AppColors.homeTitleText,
                      fontSize: AppTextSize.bodySmall(context),
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open the full-screen route selection modal
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const RouteSelectionSheet(),
        );
      },
      child: Container(
        height: 54.0,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: AppColors.homeHintText,
              size: AppIconSize.appBar(context),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Where to & for how much?',
                style: TextStyle(
                  color: AppColors.homeTitleText,
                  fontSize: AppTextSize.bodyLarge(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Open map selection mode
                final vm = context.read<HomeViewModel>();
                vm.setSelectingOnMap(MapSelectionMode.dropoff);
              },
              child: Icon(
                Icons.map_outlined,
                color: AppColors.homePrimary,
                size: AppIconSize.md(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentPlaces(BuildContext context) {
    final recentPlaces = [
      {
        'title': 'Street Number 16',
        'subtitle': 'Osmanabad Usmanabad Colony, Multan',
      },
      {'title': 'Gulgasht Colony', 'subtitle': 'Multan'},
      {
        'title': 'Chase Up Mall',
        'subtitle': 'Education Avenue, North Gulgasht Colony, Multan',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...recentPlaces.map(
          (place) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.access_time,
                color: AppColors.homeSubtitleText,
                size: AppIconSize.md(context),
              ),
              title: Text(
                place['title'] as String,
                style: TextStyle(
                  color: AppColors.homeTitleText,
                  fontSize: AppTextSize.bodyMedium(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                place['subtitle'] as String,
                style: TextStyle(
                  color: AppColors.homeSubtitleText,
                  fontSize: AppTextSize.bodySmall(context),
                ),
              ),
              onTap: () {
                // If a user taps a recent place here, we could immediately open route sheet with destination set
                final vm = context.read<HomeViewModel>();
                vm.setDropoffAddress(place['title'] as String);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const RouteSelectionSheet(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
