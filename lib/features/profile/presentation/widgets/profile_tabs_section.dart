import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/post_model.dart';
import '../../../../data/vehicles_data.dart';
import '../../../home/state/feed_controller.dart';
import '../../../marketplace/presentation/screens/product_detail_screen.dart';
import '../../../marketplace/state/marketplace_controller.dart';
import '../../../messages/state/messages_controller.dart';
import '../../../showcase/presentation/screens/featured_vehicle_showcase_screen.dart';
import '../../state/saved_items_controller.dart';
import 'profile_post_detail_modal.dart';

/// Renders the profile tabs (Postingan, Modifikasi, Tersimpan) and their respective dynamic contents.
class ProfileTabsSection extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabSelected;
  final List<PostModel> authorPosts;
  final FeedController? feedController;
  final SavedItemsController? savedController;
  final MarketplaceController? marketplaceController;
  final MessagesController? messagesController;

  const ProfileTabsSection({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    required this.authorPosts,
    this.feedController,
    this.savedController,
    this.marketplaceController,
    this.messagesController,
  });

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

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
                _tabButton(0, Icons.grid_view, 'Postingan'),
                _tabButton(1, Icons.tune, 'Modifikasi'),
                _tabButton(2, Icons.bookmark_border, 'Tersimpan'),
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
          _buildSavedSection(context),
        ],

        const SizedBox(height: 100), // Spacing for persistent bottom nav
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
                color: isSelected
                    ? AppColors.performanceLime
                    : Colors.transparent,
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
                color: isSelected
                    ? AppColors.performanceLime
                    : AppColors.titanium,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  color: isSelected
                      ? AppColors.performanceLime
                      : AppColors.titanium,
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

  // ─────────────────────────────────────────────────────────────
  // 1. POSTS GRID (STANDARDIZED VIEW COUNTS ONLY)
  // ─────────────────────────────────────────────────────────────
  Widget _buildPostsGrid(BuildContext context) {
    // 12 items for generous scrolling and realistic viewport fill
    final fallbackImages = [
      'assets/images/posts/video_thumbnail/post_porsche_gt3_thumbnail.jpg',
      'assets/images/posts/video_thumbnail/post_mazda_rx7_thumbnail.jpg',
      'assets/images/posts/video_thumbnail/post_civic_fk8_thumbnail.jpg',
      'assets/images/vehicles/vehicle_porsche_911_gt3_hero.jpg',
      'assets/images/vehicles/vehicle_mazda_rx7_fd3s_hero.jpg',
      'assets/images/vehicles/vehicle_honda_civic_type_r_fk8_hero.jpg',
      'assets/images/products/product_titanium_exhaust.jpg',
      'assets/images/products/product_forged_wheel.jpg',
      'assets/images/products/product_performance_coilover.jpg',
      'assets/images/products/product_carbon_ceramic_brake.jpg',
      'assets/images/posts/video_thumbnail/post_porsche_gt3_thumbnail.jpg',
      'assets/images/posts/video_thumbnail/post_civic_fk8_thumbnail.jpg',
    ];

    // Explicit dummy view counts for fallback tiles (separate from likes)
    final fallbackViewCounts = [
      94200,
      82500,
      76100,
      64800,
      55300,
      48900,
      41200,
      37600,
      29400,
      22800,
      18500,
      14200,
    ];

    final displayCount = authorPosts.length > 12 ? authorPosts.length : 12;

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
            final viewCount = post.viewCount > 0 ? post.viewCount : 128400;

            return GestureDetector(
              onTap: () => ProfilePostDetailModal.show(context, post),
              behavior: HitTestBehavior.opaque,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.steel.withValues(alpha: 0.5),
                  ),
                  image: DecorationImage(
                    image: AssetImage(post.mediaAsset),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Consistent view counter pill with visibility icon
                    Positioned(
                      bottom: 5,
                      left: 5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.voidBlack.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.visibility_outlined,
                              size: 11,
                              color: AppColors.performanceLime,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              _formatCount(viewCount),
                              style: AppTypography.micro.copyWith(
                                fontSize: 9,
                                color: AppColors.iceWhite,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
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

          final fallbackIdx =
              (index - authorPosts.length) % fallbackImages.length;
          final img = fallbackImages[fallbackIdx];
          final viewCount = fallbackViewCounts[fallbackIdx];

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.steel.withValues(alpha: 0.5)),
              image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 5,
                  left: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.voidBlack.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.visibility_outlined,
                          size: 11,
                          color: AppColors.performanceLime,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          _formatCount(viewCount),
                          style: AppTypography.micro.copyWith(
                            fontSize: 9,
                            color: AppColors.iceWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // 2. BUILDS / GARAGE LIST
  // ─────────────────────────────────────────────────────────────
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
                          Text(
                            v.displayName,
                            style: AppTypography.bodyStrong.copyWith(
                              color: AppColors.iceWhite,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Generasi ${v.generation} · ${v.nickname}',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.titanium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.limeSoft,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _vehicleStatusLabel(v.status),
                        style: AppTypography.micro.copyWith(
                          color: AppColors.performanceLime,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 38,
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
                            savedController: savedController,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Lihat Detail Kendaraan',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.iceWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  String _vehicleStatusLabel(String status) {
    switch (status) {
      case 'Active Build':
        return 'Sedang Dimodifikasi';
      case 'In Progress':
        return 'Dalam Proses';
      case 'Active Daily':
        return 'Harian';
      default:
        return status;
    }
  }

  // ─────────────────────────────────────────────────────────────
  // 3. CENTRALIZED SAVED SECTION (POSTS, MARKETPLACE, VEHICLES)
  // ─────────────────────────────────────────────────────────────
  Widget _buildSavedSection(BuildContext context) {
    if (savedController == null) {
      return _buildLegacySavedGrid(context);
    }

    return ListenableBuilder(
      listenable: savedController!,
      builder: (context, _) {
        final currentCat = savedController!.selectedCategory;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Chips Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Row(
                children: [
                  _categoryChip(
                    label: 'Postingan',
                    count: savedController!.savedPostsCount,
                    isSelected: currentCat == SavedCategory.posts,
                    onTap: () => savedController!.setSelectedCategory(
                      SavedCategory.posts,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _categoryChip(
                    label: 'Marketplace',
                    count: savedController!.savedProductsCount,
                    isSelected: currentCat == SavedCategory.marketplace,
                    onTap: () => savedController!.setSelectedCategory(
                      SavedCategory.marketplace,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _categoryChip(
                    label: 'Kendaraan',
                    count: savedController!.savedVehiclesCount,
                    isSelected: currentCat == SavedCategory.vehicles,
                    onTap: () => savedController!.setSelectedCategory(
                      SavedCategory.vehicles,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Source Category Dynamic Content
            if (currentCat == SavedCategory.posts)
              _buildSavedPostsContent(context)
            else if (currentCat == SavedCategory.marketplace)
              _buildSavedMarketplaceContent(context)
            else
              _buildSavedVehiclesContent(context),
          ],
        );
      },
    );
  }

  Widget _categoryChip({
    required String label,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.limeSoft : AppColors.carbon,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.performanceLime : AppColors.steel,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  color: isSelected
                      ? AppColors.performanceLime
                      : AppColors.titanium,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 11,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.performanceLime
                      : AppColors.graphite,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$count',
                  style: AppTypography.micro.copyWith(
                    color: isSelected
                        ? AppColors.voidBlack
                        : AppColors.titanium,
                    fontWeight: FontWeight.w700,
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── A. Saved Posts Content ──
  Widget _buildSavedPostsContent(BuildContext context) {
    final posts = savedController!.savedPosts;

    if (posts.isEmpty) {
      return _buildEmptyState(
        icon: Icons.bookmark_border_rounded,
        title: 'Belum ada postingan tersimpan.',
        subtitle: 'Simpan postingan dan pembaruan modifikasi dari Beranda untuk melihatnya di sini.',
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
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return GestureDetector(
            onTap: () => ProfilePostDetailModal.show(context, post),
            behavior: HitTestBehavior.opaque,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.steel.withValues(alpha: 0.5),
                ),
                image: DecorationImage(
                  image: AssetImage(post.mediaAsset),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Instant Unsave Button on top-right
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () => savedController!.toggleSavePost(post.id),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.voidBlack.withValues(alpha: 0.8),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.bookmark_rounded,
                          size: 13,
                          color: AppColors.performanceLime,
                        ),
                      ),
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

  // ── B. Saved Marketplace Content ──
  Widget _buildSavedMarketplaceContent(BuildContext context) {
    final products = savedController!.savedProducts;

    if (products.isEmpty) {
      return _buildEmptyState(
        icon: Icons.storefront_outlined,
        title: 'Belum ada produk tersimpan.',
        subtitle: 'Simpan suku cadang dan perlengkapan performa dari Marketplace untuk melihatnya di sini.',
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: products.map((product) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.carbon,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.steel),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(
                      productId: product.id,
                      controller:
                          marketplaceController ?? MarketplaceController(),
                      messagesController: messagesController,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 58,
                      height: 58,
                      color: AppColors.graphite,
                      child: Image.asset(
                        product.imageAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.build_rounded,
                          color: AppColors.titanium,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: AppTypography.bodyStrong.copyWith(
                            color: AppColors.iceWhite,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          product.formattedPrice,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.performanceLime,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${product.brand} · ${product.condition}',
                          style: AppTypography.micro.copyWith(
                            color: AppColors.titanium,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.bookmark_rounded,
                      color: AppColors.performanceLime,
                      size: 20,
                    ),
                    onPressed: () =>
                        savedController!.toggleSaveProduct(product.id),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── C. Saved Vehicles Content ──
  Widget _buildSavedVehiclesContent(BuildContext context) {
    final vehicles = savedController!.savedVehicles;

    if (vehicles.isEmpty) {
      return _buildEmptyState(
        icon: Icons.directions_car_outlined,
        title: 'Belum ada kendaraan tersimpan.',
        subtitle: 'Simpan kendaraan modifikasi dari Vehicle Showcase untuk melihatnya di sini.',
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: vehicles.map((v) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.carbon,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.steel),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FeaturedVehicleShowcaseScreen(
                      vehicle: v,
                      feedController: feedController,
                      savedController: savedController,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 64,
                      height: 50,
                      color: AppColors.graphite,
                      child: Image.asset(
                        v.imageAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.directions_car_rounded,
                          color: AppColors.titanium,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          v.displayName,
                          style: AppTypography.bodyStrong.copyWith(
                            color: AppColors.iceWhite,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Generasi ${v.generation} · ${v.nickname}',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.titanium,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.bookmark_rounded,
                      color: AppColors.performanceLime,
                      size: 20,
                    ),
                    onPressed: () => savedController!.toggleSaveVehicle(v.id),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 44, color: AppColors.mutedSteel),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTypography.headlineH3.copyWith(
              color: AppColors.titanium,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: AppTypography.caption.copyWith(
              color: AppColors.mutedSteel,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Fallback if savedController is not provided
  Widget _buildLegacySavedGrid(BuildContext context) {
    final savedPosts =
        feedController?.allPosts.where((p) => p.isSaved).toList() ?? [];

    if (savedPosts.isEmpty) {
      return _buildEmptyState(
        icon: Icons.bookmark_border_rounded,
        title: 'Belum ada postingan tersimpan.',
        subtitle: 'Simpan postingan dan pembaruan modifikasi dari Beranda untuk melihatnya di sini.',
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
                border: Border.all(
                  color: AppColors.steel.withValues(alpha: 0.5),
                ),
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
                      child: const Icon(
                        Icons.bookmark_rounded,
                        size: 10,
                        color: AppColors.performanceLime,
                      ),
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
