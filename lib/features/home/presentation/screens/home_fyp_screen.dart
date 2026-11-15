import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/vehicles_data.dart';
import '../../../marketplace/state/marketplace_controller.dart';
import '../../../messages/state/messages_controller.dart';
import '../../../profile/presentation/screens/my_profile_screen.dart';
import '../../../profile/state/saved_items_controller.dart';
import '../../../showcase/presentation/screens/featured_vehicle_showcase_screen.dart';
import '../../state/feed_controller.dart';
import '../widgets/video_feed_item.dart';
import 'search_screen.dart';

class HomeFypScreen extends StatefulWidget {
  final FeedController controller;
  final VoidCallback onOpenProfileTab;
  final SavedItemsController? savedController;
  final MarketplaceController? marketplaceController;
  final MessagesController? messagesController;
  final bool isActiveTab;

  const HomeFypScreen({
    super.key,
    required this.controller,
    required this.onOpenProfileTab,
    this.savedController,
    this.marketplaceController,
    this.messagesController,
    this.isActiveTab = true,
  });

  @override
  State<HomeFypScreen> createState() => _HomeFypScreenState();
}

class _HomeFypScreenState extends State<HomeFypScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.controller.activePostIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToVehicleShowcase([String? vehicleId]) {
    final vId =
        vehicleId ??
        widget.controller.currentPost?.linkedVehicleId ??
        'veh_porsche_gt3';
    final vehicle = VehiclesData.getAdityaGarageVehicles().firstWhere(
      (v) => v.id == vId,
      orElse: () => VehiclesData.getAdityaGarageVehicles().first,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FeaturedVehicleShowcaseScreen(
          vehicle: vehicle,
          feedController: widget.controller,
          savedController: widget.savedController,
        ),
      ),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MyProfileScreen(
          onBackToHome: () => Navigator.pop(context),
          feedController: widget.controller,
          savedController: widget.savedController,
          marketplaceController: widget.marketplaceController,
          messagesController: widget.messagesController,
        ),
      ),
    );
  }

  void _navigateToSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchScreen(
          onSelectVehicle: (_) => _navigateToVehicleShowcase(),
          onSelectUser: (_) => _navigateToProfile(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final posts = widget.controller.currentPosts;

        return Scaffold(
          backgroundColor: AppColors.voidBlack,
          body: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Vertical Video Feed PageView
              posts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.people_outline,
                            size: 54,
                            color: AppColors.mutedSteel,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Belum ada postingan dari kreator yang Anda ikuti',
                            style: AppTypography.headlineH3.copyWith(
                              color: AppColors.titanium,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.performanceLime,
                              foregroundColor: AppColors.voidBlack,
                            ),
                            onPressed: () =>
                                widget.controller.setActiveTab(FeedTab.forYou),
                            child: const Text('Jelajahi Beranda'),
                          ),
                        ],
                      ),
                    )
                  : PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.vertical,
                      itemCount: posts.length,
                      onPageChanged: (idx) {
                        widget.controller.setActivePostIndex(idx);
                      },
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        final isCurrent =
                            index == widget.controller.activePostIndex;
                        return VideoFeedItem(
                          key: ValueKey(post.id),
                          post: post,
                          controller: widget.controller,
                          isCurrentPost: isCurrent,
                          isActiveTab: widget.isActiveTab,
                          onProfileTap: _navigateToProfile,
                          onVehicleTap: () =>
                              _navigateToVehicleShowcase(post.linkedVehicleId),
                        );
                      },
                    ),

              // 2. Floating Top Header (Live, Following / For You, Search)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left placeholder for symmetrical centering (passes touches to top-left Volume button below)
                        const IgnorePointer(
                          child: SizedBox(width: 40, height: 40),
                        ),

                        // Center: Segmented Feed Switcher
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Following Tab
                            GestureDetector(
                              onTap: () {
                                widget.controller.setActiveTab(
                                  FeedTab.following,
                                );
                                _pageController.jumpToPage(0);
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                child: Text(
                                  'Mengikuti',
                                  style: AppTypography.headlineH3.copyWith(
                                    fontSize: 16,
                                    fontWeight:
                                        widget.controller.activeTab ==
                                            FeedTab.following
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color:
                                        widget.controller.activeTab ==
                                            FeedTab.following
                                        ? AppColors.iceWhite
                                        : AppColors.titanium.withValues(
                                            alpha: 0.8,
                                          ),
                                    shadows: const [
                                      Shadow(
                                        color: Colors.black87,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // For You Tab
                            GestureDetector(
                              onTap: () {
                                widget.controller.setActiveTab(FeedTab.forYou);
                                _pageController.jumpToPage(0);
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Untuk Anda',
                                      style: AppTypography.headlineH3.copyWith(
                                        fontSize: 16,
                                        fontWeight:
                                            widget.controller.activeTab ==
                                                FeedTab.forYou
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color:
                                            widget.controller.activeTab ==
                                                FeedTab.forYou
                                            ? AppColors.iceWhite
                                            : AppColors.titanium.withValues(
                                                alpha: 0.8,
                                              ),
                                        shadows: const [
                                          Shadow(
                                            color: Colors.black87,
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (widget.controller.activeTab ==
                                        FeedTab.forYou)
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        width: 24,
                                        height: 2.5,
                                        decoration: BoxDecoration(
                                          color: AppColors.performanceLime,
                                          borderRadius: BorderRadius.circular(
                                            2,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Right: Search Button
                        GestureDetector(
                          onTap: _navigateToSearch,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.voidBlack.withValues(
                                alpha: 0.35,
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                            ),
                            child: const Icon(
                              Icons.search_rounded,
                              size: 20,
                              color: AppColors.iceWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
