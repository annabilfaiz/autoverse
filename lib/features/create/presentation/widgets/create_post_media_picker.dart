import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class CreatePostMediaPicker extends StatelessWidget {
  final String? selectedMediaAsset;
  final List<String> mediaGallery;
  final ValueChanged<String> onSelectMedia;
  final VoidCallback onRemoveMedia;

  const CreatePostMediaPicker({
    super.key,
    required this.selectedMediaAsset,
    required this.mediaGallery,
    required this.onSelectMedia,
    required this.onRemoveMedia,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMediaPreview(),
        const SizedBox(height: 14),
        _buildGallerySelector(),
      ],
    );
  }

  Widget _buildMediaPreview() {
    if (selectedMediaAsset == null) {
      return GestureDetector(
        onTap: () {
          if (mediaGallery.isNotEmpty) {
            onSelectMedia(mediaGallery.first);
          }
        },
        child: Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.carbon,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.steel,
              width: 1.2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.graphite,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.steel),
                ),
                child: const Icon(
                  Icons.add_photo_alternate_rounded,
                  color: AppColors.performanceLime,
                  size: 26,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Select Vehicle Media',
                style: AppTypography.bodyStrong.copyWith(
                  color: AppColors.iceWhite,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tap to pick an automotive photo below',
                style: AppTypography.caption.copyWith(
                  color: AppColors.mutedSteel,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          height: 240,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.carbon,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.steel),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            selectedMediaAsset!,
            fit: BoxFit.cover,
            errorBuilder: (ctx, err, stk) => Container(
              color: AppColors.graphite,
              child: const Center(
                child: Icon(
                  Icons.broken_image_rounded,
                  color: AppColors.mutedSteel,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: onRemoveMedia,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.voidBlack.withValues(alpha: 0.75),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.steel),
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 16,
                color: AppColors.iceWhite,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.voidBlack.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.steel.withValues(alpha: 0.6)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.photo_camera_rounded,
                  size: 12,
                  color: AppColors.performanceLime,
                ),
                const SizedBox(width: 4),
                Text(
                  'Automotive Photo',
                  style: AppTypography.micro.copyWith(
                    color: AppColors.iceWhite,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGallerySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'MEDIA LIBRARY',
              style: AppTypography.micro.copyWith(
                color: AppColors.mutedSteel,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                fontSize: 10,
              ),
            ),
            Text(
              '${mediaGallery.length} Photos available',
              style: AppTypography.micro.copyWith(
                color: AppColors.mutedSteel,
                fontSize: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 64,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: mediaGallery.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final asset = mediaGallery[index];
              final isSelected = selectedMediaAsset == asset;

              return GestureDetector(
                onTap: () => onSelectMedia(asset),
                child: Container(
                  width: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.performanceLime
                          : AppColors.steel,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        asset,
                        fit: BoxFit.cover,
                      ),
                      if (isSelected)
                        Container(
                          color: AppColors.performanceLime.withValues(alpha: 0.2),
                          child: const Center(
                            child: Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.performanceLime,
                              size: 18,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
