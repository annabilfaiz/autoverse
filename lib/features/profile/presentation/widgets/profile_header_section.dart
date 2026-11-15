import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Top profile identity header showing user avatar, verified tag,
/// followers/following/posts stats, and bio.
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
        // 1. Top Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
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
        ),

        // 2. Profile Identity (Avatar + Stats)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Clean Avatar
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

                  // Stats Counters
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statCounter('$totalPostCount', 'Postingan'),
                        _statCounter('14.8k', 'Pengikut'),
                        _statCounter('420', 'Mengikuti'),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Full Name & Location
              Text(
                'Aditya Pratama',
                style: AppTypography.headlineH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.iceWhite,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Jakarta, Indonesia',
                style: AppTypography.caption.copyWith(color: AppColors.titanium),
              ),
              const SizedBox(height: 6),
              Text(
                '992 GT3 track build and vintage air-cooled projects. Driving fast, wrenching slow.',
                style: AppTypography.body.copyWith(fontSize: 13, color: AppColors.iceWhite),
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
