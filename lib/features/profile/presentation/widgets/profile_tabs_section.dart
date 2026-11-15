import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/post_model.dart';
import '../../../../data/vehicles_data.dart';
import '../../../home/state/feed_controller.dart';
import '../../../showcase/presentation/screens/featured_vehicle_showcase_screen.dart';
import 'profile_post_detail_modal.dart';

/// Renders the profile tabs (Posts, Builds, Saved) and their respective dynamic contents.
class ProfileTabsSection extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabSelected;
  final List<PostModel> authorPosts;
  final FeedController? feedController;

  const ProfileTabsSection({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    required this.authorPosts,
    this.feedController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab Selector Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.steel)),
            ),
            child: Row(
              children: [
                _tabButton(0, Icons.grid_view, 'Posts'),
                _tabButton(1, Icons.tune, 'Builds'),
                _tabButton(2, Icons.bookmark_border, 'Saved'),
              ],
            ),
          ),
        ),

        // Dynamic Tab Content
        if (selectedTab == 0) ...[
          _buildPostsGrid(context),
        ] else if (selectedTab == 1) ...[
          _buildBuildsList(context),
        ] else ...[
          _buildSavedGrid(context),
        ],

        const SizedBox(height: 100), // Spacing for floating bottom nav
      ],
    );
  }

  Widget _tabButton(int index, IconData icon, String label) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTabSelected(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.performanceLime : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? AppColors.performanceLime : AppColors.titanium,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  color: isSelected ? AppColors.performanceLime : AppColors.titanium,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostsGrid(BuildContext context) {
    final fallbackImages = [
      'assets/images/feed_porsche_dusk.png',
      'assets/images/feed_rx7_track.png',
      'assets/images/feed_porsche_gt3.png',
      'assets/images/feed_porsche_911.png',
      'assets/images/feed_porsche_dusk.png',
      'assets/images/feed_rx7_track.png',
    ];
    final displayCount = authorPosts.length > 6 ? authorPosts.length : 6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          childAspectRatio: 1.0,
        ),
        itemCount: displayCount,
        itemBuilder: (context, index) {
          if (index < authorPosts.length) {
            final post = authorPosts[index];
            return GestureDetector(
              onTap: () => ProfilePostDetailModal.show(context, post),
              behavior: HitTestBehavior.opaque,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.steel.withValues(alpha: 0.5)),
                  image: DecorationImage(
                    image: AssetImage(post.mediaAsset),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 4,
                      left: 4,
                      child: Row(
                        children: [
                          const Icon(Icons.favorite_rounded, size: 10, color: AppColors.performanceLime),
                          const SizedBox(width: 2),
                          Text(
                            '${post.likeCount}',
                            style: AppTypography.micro.copyWith(
                              fontSize: 9,
                              color: AppColors.iceWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (post.linkedVehicleChip.isNotEmpty)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColors.voidBlack.withValues(alpha: 0.8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.directions_car_filled_rounded,
                            size: 10,
                            color: AppColors.performanceLime,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }

          final fallbackIdx = (index - authorPosts.length) % fallbackImages.length;
          final img = fallbackImages[fallbackIdx];

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.steel.withValues(alpha: 0.5)),
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 4,
                  left: 4,
                  child: Row(
                    children: [
                      const Icon(Icons.play_arrow, size: 12, color: AppColors.performanceLime),
                      const SizedBox(width: 2),
                      Text(
                        '${(12.4 - index * 1.5).clamp(1.0, 99.0).toStringAsFixed(1)}k',
                        style: AppTypography.micro.copyWith(
                          fontSize: 9,
                          color: AppColors.iceWhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBuildsList(BuildContext context) {
    final vehicles = VehiclesData.getAdityaGarageVehicles();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: vehicles.map((v) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.carbon,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.steel),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        v.imageAsset,
                        width: 54,
                        height: 54,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(v.displayName, style: AppTypography.bodyStrong.copyWith(color: AppColors.iceWhite)),
                          const SizedBox(height: 2),
                          Text('Generation ${v.generation} • ${v.nickname}',
                              style: AppTypography.caption.copyWith(color: AppColors.titanium, fontSize: 11)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.graphite,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(v.status,
                                style: AppTypography.micro.copyWith(color: AppColors.performanceLime, fontSize: 10)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.graphite,
                      foregroundColor: AppColors.iceWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: AppColors.steel),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FeaturedVehicleShowcaseScreen(
                            vehicle: v,
                            feedController: feedController,
                          ),
                        ),
                      );
                    },
                    child: Text('View Vehicle Showcase',
                        style: AppTypography.caption.copyWith(color: AppColors.iceWhite)),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSavedGrid(BuildContext context) {
    final savedPosts = feedController?.allPosts.where((p) => p.isSaved).toList() ?? [];

    if (savedPosts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            const Icon(Icons.bookmark_border_rounded, size: 48, color: AppColors.mutedSteel),
            const SizedBox(height: 12),
            Text(
              'No Saved Posts Yet',
              style: AppTypography.headlineH3.copyWith(color: AppColors.titanium),
            ),
            const SizedBox(height: 6),
            Text(
              'Bookmark automotive posts and build logs from Home FYP to view them here.',
              style: AppTypography.caption.copyWith(color: AppColors.mutedSteel),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          childAspectRatio: 1.0,
        ),
        itemCount: savedPosts.length,
        itemBuilder: (context, index) {
          final post = savedPosts[index];
          return GestureDetector(
            onTap: () => ProfilePostDetailModal.show(context, post),
            behavior: HitTestBehavior.opaque,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.steel.withValues(alpha: 0.5)),
                image: DecorationImage(
                  image: AssetImage(post.mediaAsset),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: AppColors.voidBlack.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.bookmark_rounded, size: 10, color: AppColors.performanceLime),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
