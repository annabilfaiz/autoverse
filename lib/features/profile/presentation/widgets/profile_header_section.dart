import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Top profile identity header showing user avatar, verified tag,
/// followers/following/posts stats, bio, and quick profile actions.
class ProfileHeaderSection extends StatelessWidget {
  final int totalPostCount;
  final VoidCallback? onBackToHome;

  const ProfileHeaderSection({
    super.key,
    required this.totalPostCount,
    this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Top App Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (onBackToHome != null)
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.iceWhite),
                      onPressed: onBackToHome,
                      padding: const EdgeInsets.only(right: 8),
                      constraints: const BoxConstraints(),
                    ),
                  Text(
                    '@aditya_gt3',
                    style: AppTypography.headlineH3.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.iceWhite,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.verified, size: 16, color: AppColors.performanceLime),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.ios_share, size: 20, color: AppColors.titanium),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile link copied to clipboard'),
                          backgroundColor: AppColors.carbon,
                        ),
                      );
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined, size: 20, color: AppColors.titanium),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Settings opened'),
                          backgroundColor: AppColors.carbon,
                        ),
                      );
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ),

        // 2. Profile Identity (Avatar + Stats)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Avatar with Online Badge
                  Stack(
                    children: [
                      Container(
                        width: 76,
                        height: 76,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.steel, width: 2),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/avatar_aditya.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: AppColors.performanceLime,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.voidBlack, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Stats Counters
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statCounter('$totalPostCount', 'Posts'),
                        _statCounter('14.8k', 'Followers'),
                        _statCounter('420', 'Following'),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Full Name & Pro Badge
              Text(
                'Aditya Pratama',
                style: AppTypography.headlineH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.iceWhite,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.limeSoft,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'PRO BUILDER',
                      style: AppTypography.micro.copyWith(
                        color: AppColors.performanceLime,
                        fontWeight: FontWeight.w700,
                        fontSize: 9,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Jakarta, Indonesia',
                    style: AppTypography.caption.copyWith(color: AppColors.titanium),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '992 GT3 track build and vintage air-cooled projects. Driving fast, wrenching slow.',
                style: AppTypography.body.copyWith(fontSize: 13, color: AppColors.iceWhite),
              ),

              const SizedBox(height: 14),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.graphite,
                          foregroundColor: AppColors.iceWhite,
                          side: const BorderSide(color: AppColors.steel),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Edit Profile opening...'),
                              backgroundColor: AppColors.carbon,
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit, size: 15, color: AppColors.iceWhite),
                        label: Text('Edit Profile', style: AppTypography.button.copyWith(fontSize: 12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Share profile link copied'),
                          backgroundColor: AppColors.carbon,
                        ),
                      );
                    },
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.graphite,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.steel),
                      ),
                      child: const Icon(Icons.share, size: 16, color: AppColors.iceWhite),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statCounter(String val, String label) {
    return Column(
      children: [
        Text(
          val,
          style: AppTypography.headlineH2.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: AppColors.iceWhite,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: AppColors.titanium,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
