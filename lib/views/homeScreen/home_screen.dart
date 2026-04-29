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
import 'widgets/home_bottom_sheet.dart';
import '../routePreviewScreen/route_preview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedRideIndex = 0;
  final MapController _mapController = MapController();

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
      extendBodyBehindAppBar: true, // Allow map to go under app bar
      appBar: _buildAppBar(context),
      body: vm.isSelectingOnMap
          ? Stack(
              children: [
                Positioned.fill(child: _buildMap(context)),
                _buildMapSelectionOverlay(context, vm),
              ],
            )
          : Stack(
              children: [
                // Full screen Map
                Positioned.fill(
                  child: Listener(
                    onPointerDown: (_) => vm.setBottomSheetVisible(false),
                    onPointerUp: (_) => vm.setBottomSheetVisible(true),
                    onPointerCancel: (_) => vm.setBottomSheetVisible(true),
                    child: _buildMap(context),
                  ),
                ),
                // FAB (Near Me)
                Align(
                  alignment: Alignment.bottomRight,
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.only(
                      right: 16.0,
                      bottom: vm.isBottomSheetVisible ? 340.0 : 16.0,
                    ),
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: AppColors.whiteColor,
                      elevation: 4,
                      onPressed: () {
                        // Center map on user's location
                        _mapController.move(vm.currentLocation, 15.0);
                      },
                      child: Icon(
                        Icons.near_me_outlined,
                        color: AppColors.homeTitleText,
                      ),
                    ),
                  ),
                ),
                // Draggable Bottom Sheet with Animation
                Positioned.fill(
                  child: AnimatedSlide(
                    offset: vm.isBottomSheetVisible
                        ? Offset.zero
                        : const Offset(0, 1),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.42,
                      minChildSize: 0.42, // Prevents going below initial height
                      maxChildSize: 0.95, // Top limit
                      snap: true,
                      snapSizes: const [0.42, 0.95],
                      builder: (context, scrollController) {
                        return HomeBottomSheet(
                          scrollController: scrollController,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // ── APP BAR ──────────────────────────────────────────
  AppBar _buildAppBar(BuildContext context) {
    final leadingPad = AppPaddings.val(context, mobile: 16, tablet: 20);
    final actionPad = AppPaddings.val(context, mobile: 16, tablet: 20);
    final landscape = _isLandscape(context);

    return AppBar(
      backgroundColor: Colors.transparent, // Transparent for map background
      elevation: 0,
      toolbarHeight: landscape ? 48 : kToolbarHeight,
      leadingWidth: _isTablet(context) ? 68 : 56,
      leading: Padding(
        padding: EdgeInsets.only(left: leadingPad, top: 8),
        child: CircleAvatar(
          backgroundColor: AppColors.whiteColor,
          child: Icon(
            Icons.menu,
            color: AppColors.homeTitleText,
            size: AppIconSize.md(context),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: actionPad, top: 8),
          child: CircleAvatar(
            backgroundColor: AppColors.whiteColor,
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
        ),
      ],
    );
  }

  // ── FULL SCREEN MAP ──────────────────────────────────
  Widget _buildMap(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: LatLng(30.1575, 71.5249), // Multan coordinates
        initialZoom: 14.0,
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ],
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
    );
  }

  // ── MAP SELECTION OVERLAY ────────────────────────────
  Widget _buildMapSelectionOverlay(BuildContext context, HomeViewModel vm) {
    return Stack(
      children: [
        // Center Pin
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 40.0,
            ), // Adjust for pin pointing down
            child: Icon(
              Icons.location_on,
              size: 40,
              color: AppColors.homePrimary,
            ),
          ),
        ),
        // Confirm Button
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Move map to select destination',
                  style: TextStyle(
                    fontSize: AppTextSize.bodyMedium(context),
                    color: AppColors.homeSubtitleText,
                  ),
                ),
                AppSpacing.vL(context),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.homePrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Confirm location, return to normal state
                      final mode = vm.mapSelectionMode;
                      vm.setSelectingOnMap(MapSelectionMode.none);

                      // In a real app, you would reverse geocode the map center coordinate here
                      if (mode == MapSelectionMode.pickup) {
                        vm.setPickupAddress("Selected on Map");
                      } else if (mode == MapSelectionMode.dropoff) {
                        vm.setDropoffAddress("Selected on Map");
                        
                        // Navigate to RoutePreviewScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RoutePreviewScreen()),
                        );
                      }
                    },
                    child: const Text(
                      'Confirm Location',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Back Button
        Positioned(
          top: 50,
          left: 16,
          child: CircleAvatar(
            backgroundColor: AppColors.whiteColor,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => vm.setSelectingOnMap(MapSelectionMode.none),
            ),
          ),
        ),
      ],
    );
  }
}
