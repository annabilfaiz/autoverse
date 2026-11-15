import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/post_model.dart';

/// Modal bottom sheet displaying detailed post view, high-resolution media,
/// caption, linked vehicle badge, and engagement counters.
class ProfilePostDetailModal extends StatelessWidget {
  final PostModel post;

  const ProfilePostDetailModal({
    super.key,
    required this.post,
  });

  static void show(BuildContext context, PostModel post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ProfilePostDetailModal(post: post),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.carbon,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(top: BorderSide(color: AppColors.steel)),
      ),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 12),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.mutedSteel.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Author Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(post.creatorAvatarAsset),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.creatorName,
                            style: AppTypography.bodyStrong.copyWith(color: AppColors.iceWhite),
                          ),
                          if (post.isVerified) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.verified, size: 14, color: AppColors.performanceLime),
                          ],
                        ],
                      ),
                      Text(
                        '${post.creatorUsername} • ${post.timeAgo}',
                        style: AppTypography.caption.copyWith(color: AppColors.titanium, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: AppColors.titanium),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.steel, height: 16),

          // Media and Post Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 240,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.graphite,
                        border: Border.all(color: AppColors.steel),
                      ),
                      child: Image.asset(
                        post.mediaAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const Center(
                          child: Icon(Icons.image_not_supported, color: AppColors.titanium),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Linked Vehicle Badge
                  if (post.linkedVehicleChip.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.performanceLime.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.performanceLime.withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.directions_car_rounded, size: 14, color: AppColors.performanceLime),
                          const SizedBox(width: 6),
                          Text(
                            post.linkedVehicleChip,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.performanceLime,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Caption
                  Text(
                    post.caption,
                    style: AppTypography.body.copyWith(
                      color: AppColors.iceWhite,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Engagement Counters
                  Row(
                    children: [
                      _modalStat(Icons.favorite_rounded, '${post.likeCount} Suka', AppColors.error),
                      const SizedBox(width: 20),
                      _modalStat(Icons.chat_bubble_rounded, '${post.commentCount} Komentar', AppColors.titanium),
                      const SizedBox(width: 20),
                      _modalStat(Icons.share_rounded, '${post.shareCount} Dibagikan', AppColors.titanium),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _modalStat(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Text(text, style: AppTypography.caption.copyWith(color: AppColors.titanium, fontSize: 12)),
      ],
    );
  }
}
