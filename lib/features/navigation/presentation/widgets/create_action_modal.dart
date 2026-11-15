import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../create/presentation/screens/create_post_screen.dart';
import '../../../home/state/feed_controller.dart';
import '../../../marketplace/presentation/screens/create_listing_screen.dart';
import '../../../marketplace/state/marketplace_controller.dart';

/// Modal bottom sheet presented when user taps the central (+) action in the navigation bar.
class CreateActionModal extends StatelessWidget {
  final FeedController feedController;
  final MarketplaceController marketplaceController;

  const CreateActionModal({
    super.key,
    required this.feedController,
    required this.marketplaceController,
  });

  static void show(
    BuildContext context, {
    required FeedController feedController,
    required MarketplaceController marketplaceController,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => CreateActionModal(
        feedController: feedController,
        marketplaceController: marketplaceController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.carbon,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: AppColors.steel)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.mutedSteel,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              Text(
                'Buat di AutoVerse',
                style: AppTypography.headlineH3.copyWith(
                  color: AppColors.iceWhite,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 20),

              // Option 1: Buat Postingan
              _createActionOption(
                icon: Icons.post_add_rounded,
                title: 'Buat Postingan',
                subtitle: 'Bagikan foto dan pembaruan modifikasi kendaraan',
                color: AppColors.performanceLime,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CreatePostScreen(feedController: feedController),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Option 2: Jual Komponen Otomotif
              _createActionOption(
                icon: Icons.storefront_rounded,
                title: 'Jual Komponen Otomotif',
                subtitle: 'Jual velg, knalpot, dan perlengkapan performa',
                color: AppColors.iceWhite,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreateListingScreen(
                        controller: marketplaceController,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createActionOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.graphite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.steel),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.carbon,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.steel),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyStrong.copyWith(
                      color: AppColors.iceWhite,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.titanium,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.titanium,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
