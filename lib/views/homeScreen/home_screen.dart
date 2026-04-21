import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/app_colors.dart';
import '../../core/app_padings.dart';
import '../../core/app_spacing.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_size.dart';
import '../../core/app_icon_size.dart';
import '../../view_models/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedRideIndex = 0;

  // ── Helpers ──────────────────────────────────────────
  static bool _isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      appBar: _buildAppBar(context),
      body: _buildPortraitBody(context, vm),
    );
  }

  // ── PORTRAIT BODY ────────────────────────────────────
  Widget _buildPortraitBody(BuildContext context, HomeViewModel vm) {
    final landscape = _isLandscape(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: landscape
            ? AppPaddings.hXL(context) // landscape — wider horizontal padding
            : AppPaddings.hL(context), // portrait — normal
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(context),
            AppSpacing.vL(context),
            _buildMapCard(context),
            AppSpacing.vXL(context),
            _buildRideTypeSelector(context),
            AppSpacing.vL(context),
            _buildRecentPlaces(context),
          ],
        ),
      ),
    );
  }

  // ── APP BAR ──────────────────────────────────────────
  AppBar _buildAppBar(BuildContext context) {
    final leadingPad = AppPaddings.val(context, mobile: 16, tablet: 20);
    final actionPad = AppPaddings.val(context, mobile: 16, tablet: 20);
    final landscape = _isLandscape(context);

    return AppBar(
      backgroundColor: AppColors.homeBackground,
      elevation: 0,
      toolbarHeight: landscape ? 48 : kToolbarHeight,
      leadingWidth: _isTablet(context) ? 68 : 56,
      leading: Padding(
        padding: EdgeInsets.only(left: leadingPad),
        child: CircleAvatar(
          backgroundColor: AppColors.homePrimary,
          child: Icon(
            Icons.person,
            color: AppColors.whiteColor,
            size: AppIconSize.avatar(context),
          ),
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
            icon: Icon(
              Icons.notifications,
              color: AppColors.homeTitleText,
              size: landscape
                  ? AppIconSize.sm(context)
                  : AppIconSize.appBar(context),
            ),
            onPressed: () {},
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
    final vPad = landscape ? 12.0 : 16.0;

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
          hintText: 'Where to & for how much?',
          hintStyle: TextStyle(
            color: AppColors.homeHintText,
            fontSize: AppTextSize.bodySmall(context),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.homeHintText,
            size: AppIconSize.appBar(context),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: vPad),
        ),
      ),
    );
  }

  // ── MAP CARD ─────────────────────────────────────────
  Widget _buildMapCard(BuildContext context) {
    final isTablet = _isTablet(context);
    final cardRadius = isTablet ? 22.0 : 16.0;
    final imageHeight = isTablet ? 220.0 : 174.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(cardRadius),
          child: SizedBox(
            height: imageHeight,
            width: double.infinity,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(30.1575, 71.5249), // Multan, Pakistan coordinates
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.elitedrive',
                ),
                MarkerLayer(
                  markers: [
                    // Current location marker
                    Marker(
                      point: LatLng(30.1575, 71.5249),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.homePrimary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.homePrimary.withValues(alpha: 0.3),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    // Nearby drivers
                    Marker(
                      point: LatLng(30.1605, 71.5279),
                      child: const Icon(
                        Icons.local_taxi,
                        color: Colors.orange,
                        size: 24,
                      ),
                    ),
                    Marker(
                      point: LatLng(30.1545, 71.5219),
                      child: const Icon(
                        Icons.motorcycle,
                        color: Colors.green,
                        size: 24,
                      ),
                    ),
                    Marker(
                      point: LatLng(30.1595, 71.5229),
                      child: const Icon(
                        Icons.electric_rickshaw,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── SECTION HEADER ───────────────────────────────────
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
      child: Container(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${option['label']} selected'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.homePrimary
                        : AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        option['icon'] as IconData,
                        color: selected
                            ? AppColors.whiteColor
                            : AppColors.homePrimary,
                        size: AppIconSize.md(context),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        option['label'] as String,
                        style: TextStyle(
                          color: selected
                              ? AppColors.whiteColor
                              : AppColors.homeTitleText,
                          fontSize: AppTextSize.bodyMedium(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRecentPlaces(BuildContext context) {
    final recentPlaces = [
      {
        'title': 'KK Mart',
        'subtitle': 'Bosan Road, near Te...sman Wala, Multan',
      },
      {'title': 'Link Abdali Rd', 'subtitle': 'Tipu Sultan Colony, Multan'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...recentPlaces.map(
          (place) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                leading: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.homePrimary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.access_time,
                    color: AppColors.homePrimary,
                    size: AppIconSize.sm(context),
                  ),
                ),
                title: Text(
                  place['title'] as String,
                  style: TextStyle(
                    color: AppColors.homeTitleText,
                    fontSize: AppTextSize.bodyLarge(context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  place['subtitle'] as String,
                  style: TextStyle(
                    color: AppColors.homeSubtitleText,
                    fontSize: AppTextSize.bodySmall(context),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
