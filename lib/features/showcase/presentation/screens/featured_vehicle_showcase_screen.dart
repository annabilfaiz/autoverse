import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/vehicle_model.dart';
import '../../../../data/vehicles_data.dart';
import '../../../home/state/feed_controller.dart';
import '../widgets/showcase_build_posts_section.dart';
import '../widgets/showcase_hero_section.dart';
import '../widgets/showcase_specs_inventory.dart';

/// Featured Vehicle Showcase Screen
/// Displays the full vehicle profile, interactive component callouts,
/// verified specifications, build inventory, and linked build update posts.
class FeaturedVehicleShowcaseScreen extends StatefulWidget {
  final VehicleModel? vehicle;
  final FeedController? feedController;

  const FeaturedVehicleShowcaseScreen({
    super.key,
    this.vehicle,
    this.feedController,
  });

  @override
  State<FeaturedVehicleShowcaseScreen> createState() => _FeaturedVehicleShowcaseScreenState();
}

class _FeaturedVehicleShowcaseScreenState extends State<FeaturedVehicleShowcaseScreen> {
  late final FeedController _controller;
  late final bool _internalController;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    if (widget.feedController != null) {
      _controller = widget.feedController!;
      _internalController = false;
    } else {
      _controller = FeedController();
      _internalController = true;
    }
  }

  @override
  void dispose() {
    if (_internalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentVehicle = widget.vehicle ?? VehiclesData.getAdityaGarageVehicles().first;
    final isPorsche = currentVehicle.model.contains('911') || currentVehicle.model.contains('GT3');
    final linkedPosts = _controller.getPostsForVehicle(currentVehicle.id);

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      body: CustomScrollView(
        slivers: [
          // 1. Top App Bar
          SliverAppBar(
            backgroundColor: AppColors.voidBlack.withValues(alpha: 0.9),
            pinned: true,
            leading: IconButton(
              icon: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.graphite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.steel),
                ),
                child: const Icon(Icons.chevron_left, size: 22, color: AppColors.iceWhite),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(
              'FEATURED VEHICLE',
              style: AppTypography.micro.copyWith(
                letterSpacing: 2.0,
                fontWeight: FontWeight.w700,
                color: AppColors.titanium,
              ),
            ),
            actions: [
              IconButton(
                icon: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.graphite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.steel),
                  ),
                  child: const Icon(Icons.share_outlined, size: 18, color: AppColors.iceWhite),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vehicle showcase link copied'),
                      backgroundColor: AppColors.carbon,
                    ),
                  );
                },
              ),
              IconButton(
                icon: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.graphite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _isSaved ? AppColors.performanceLime : AppColors.steel),
                  ),
                  child: Icon(
                    _isSaved ? Icons.bookmark : Icons.bookmark_outline,
                    size: 18,
                    color: _isSaved ? AppColors.performanceLime : AppColors.iceWhite,
                  ),
                ),
                onPressed: () {
                  setState(() => _isSaved = !_isSaved);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_isSaved ? 'Vehicle saved to garage bookmarks' : 'Vehicle removed from bookmarks'),
                      backgroundColor: AppColors.carbon,
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),

          // 2. Hero Photography & Interactive Hotspots
          ShowcaseHeroSection(vehicle: currentVehicle),

          // 3. Vehicle Title & Telemetry Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FEATURED VEHICLE',
                    style: AppTypography.micro.copyWith(
                      color: AppColors.performanceLime,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${currentVehicle.year} ${currentVehicle.manufacturer} ${currentVehicle.model}',
                    style: AppTypography.headlineH1.copyWith(
                      color: AppColors.iceWhite,
                      letterSpacing: -0.5,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Generation ${currentVehicle.generation} · Signature Build · ${currentVehicle.status}',
                    style: AppTypography.body.copyWith(
                      color: AppColors.titanium,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Telemetry Specification Pill
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.carbon,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.steel),
                    ),
                    child: Text(
                      isPorsche
                          ? '4.0L Naturally Aspirated Boxer-6 · 7-speed PDK'
                          : '${currentVehicle.specs['Engine'] ?? 'High Performance'} · Track Spec',
                      style: AppTypography.bodyStrong.copyWith(
                        color: AppColors.iceWhite,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.carbon,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.steel),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            isPorsche
                                ? '502 HP (+22 HP Akrapovič)'
                                : (currentVehicle.specs['Power'] ?? '300+ HP Track Tune'),
                            style: AppTypography.bodyStrong.copyWith(
                              color: AppColors.performanceLime,
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          ' • ${currentVehicle.status} • ${linkedPosts.length} Updates',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.titanium,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. Factory Specifications & Installed Build Inventory
          SliverToBoxAdapter(
            child: ShowcaseSpecsInventory(vehicle: currentVehicle),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // 5. Build Posts & Modifications Timeline
          SliverToBoxAdapter(
            child: ShowcaseBuildPostsSection(linkedPosts: linkedPosts),
          ),
        ],
      ),
    );
  }
}
