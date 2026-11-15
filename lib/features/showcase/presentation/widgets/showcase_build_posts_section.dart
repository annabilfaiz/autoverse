import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/post_model.dart';

/// Renders the milestone log and build update posts linked to the vehicle.
class ShowcaseBuildPostsSection extends StatelessWidget {
  final List<PostModel> linkedPosts;

  const ShowcaseBuildPostsSection({
    super.key,
    required this.linkedPosts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Latest Build Milestone
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Catatan Modifikasi Terkini',
                style: AppTypography.headlineH3.copyWith(
                  fontSize: 16,
                  color: AppColors.iceWhite,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.carbon,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.steel),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: AppColors.limeSoft,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.build_circle,
                        size: 18,
                        color: AppColors.performanceLime,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '18 Okt 2026',
                            style: AppTypography.micro.copyWith(
                              color: AppColors.performanceLime,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Akrapovič Titanium Race Exhaust (+22 HP, -11 kg)',
                            style: AppTypography.bodyStrong.copyWith(color: AppColors.iceWhite),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Pemasangan header titanium dan race cat di Sentul Speed Lab. Hasil dyno terverifikasi.',
                            style: AppTypography.caption.copyWith(color: AppColors.titanium),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 2. Build Posts & Updates List
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'POSTINGAN MODIFIKASI',
                      style: AppTypography.micro.copyWith(
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.performanceLime,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.performanceLime.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${linkedPosts.length} Pembaruan',
                      style: AppTypography.micro.copyWith(
                        color: AppColors.performanceLime,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (linkedPosts.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.carbon,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.steel),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.directions_car_filled_rounded,
                        color: AppColors.mutedSteel,
                        size: 28,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Belum ada postingan untuk kendaraan ini',
                        style: AppTypography.bodyStrong.copyWith(
                          color: AppColors.iceWhite,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Buat postingan dan pilih kendaraan ini untuk membagikan pembaruan.',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.mutedSteel,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                ...linkedPosts.map(
                  (post) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.carbon,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.steel),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 56,
                            height: 56,
                            color: AppColors.graphite,
                            child: Image.asset(
                              post.mediaAsset,
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
                              Row(
                                children: [
                                  Text(
                                    post.creatorUsername,
                                    style: AppTypography.bodyStrong.copyWith(
                                      color: AppColors.iceWhite,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.verified,
                                    size: 12,
                                    color: AppColors.performanceLime,
                                  ),
                                  const Spacer(),
                                  Text(
                                    post.timeAgo,
                                    style: AppTypography.micro.copyWith(
                                      color: AppColors.mutedSteel,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                post.caption,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.titanium,
                                  fontSize: 12,
                                  height: 1.3,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.favorite_rounded,
                                    size: 13,
                                    color: AppColors.error,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${post.likeCount}',
                                    style: AppTypography.micro.copyWith(
                                      color: AppColors.iceWhite,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  const Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    size: 13,
                                    color: AppColors.mutedSteel,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${post.commentCount}',
                                    style: AppTypography.micro.copyWith(
                                      color: AppColors.iceWhite,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
