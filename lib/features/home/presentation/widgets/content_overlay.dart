import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/post_model.dart';

class ContentOverlay extends StatefulWidget {
  final PostModel post;
  final VoidCallback onProfileTap;
  final VoidCallback onVehicleTap;

  const ContentOverlay({
    super.key,
    required this.post,
    required this.onProfileTap,
    required this.onVehicleTap,
  });

  @override
  State<ContentOverlay> createState() => _ContentOverlayState();
}

class _ContentOverlayState extends State<ContentOverlay> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Creator Handle + Verified + Timestamp
        GestureDetector(
          onTap: widget.onProfileTap,
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                post.creatorUsername,
                style: AppTypography.headlineH3.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.iceWhite,
                  shadows: const [
                    Shadow(color: Colors.black, blurRadius: 4, offset: Offset(0, 1)),
                  ],
                ),
              ),
              if (post.isVerified) ...[
                const SizedBox(width: 4),
                const Icon(
                  Icons.verified,
                  size: 15,
                  color: AppColors.performanceLime,
                ),
              ],
              const SizedBox(width: 6),
              Text(
                '· ${post.timeAgo}',
                style: AppTypography.caption.copyWith(
                  fontSize: 12,
                  color: AppColors.titanium,
                  shadows: const [
                    Shadow(color: Colors.black, blurRadius: 4, offset: Offset(0, 1)),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // 2. Interactive Linked Vehicle Pill Chip (Only when vehicle is linked)
        if (post.linkedVehicleChip.isNotEmpty) ...[
          GestureDetector(
            onTap: widget.onVehicleTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.carbon.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.steel.withValues(alpha: 0.8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    post.linkedVehicleChip,
                    style: AppTypography.bodyStrong.copyWith(
                      fontSize: 12,
                      color: AppColors.iceWhite,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: AppColors.performanceLime,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],

        // 3. Caption + Hashtags
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: RichText(
            maxLines: _isExpanded ? 10 : 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${post.caption} ',
                  style: AppTypography.body.copyWith(
                    fontSize: 13,
                    color: AppColors.iceWhite,
                    shadows: const [
                      Shadow(color: Colors.black, blurRadius: 4, offset: Offset(0, 1)),
                    ],
                  ),
                ),
                TextSpan(
                  text: post.hashtags.join(' '),
                  style: AppTypography.bodyStrong.copyWith(
                    fontSize: 13,
                    color: AppColors.performanceLime,
                    shadows: const [
                      Shadow(color: Colors.black, blurRadius: 4, offset: Offset(0, 1)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 8),

        // 4. Audio Ticker Row
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.music_note,
              size: 14,
              color: AppColors.performanceLime,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                post.musicTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption.copyWith(
                  fontSize: 12,
                  color: AppColors.titanium,
                  shadows: const [
                    Shadow(color: Colors.black, blurRadius: 4, offset: Offset(0, 1)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
