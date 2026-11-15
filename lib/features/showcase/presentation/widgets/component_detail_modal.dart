import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Modal bottom sheet presenting verified technical telemetry and specifications
/// for an automotive component or upgrade.
class ComponentDetailModal extends StatelessWidget {
  final String category;
  final String title;
  final String description;
  final Map<String, String> specs;

  const ComponentDetailModal({
    super.key,
    required this.category,
    required this.title,
    required this.description,
    required this.specs,
  });

  static void show(
    BuildContext context, {
    required String category,
    required String title,
    required String description,
    required Map<String, String> specs,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ComponentDetailModal(
        category: category,
        title: title,
        description: description,
        specs: specs,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.carbon,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(top: BorderSide(color: AppColors.steel)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.mutedSteel.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.performanceLime.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    category,
                    style: AppTypography.micro.copyWith(
                      color: AppColors.performanceLime,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.verified, size: 16, color: AppColors.performanceLime),
                const SizedBox(width: 4),
                Text(
                  'Verified Upgrade',
                  style: AppTypography.micro.copyWith(color: AppColors.titanium),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: AppTypography.headlineH2.copyWith(color: AppColors.iceWhite),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: AppTypography.caption.copyWith(
                color: AppColors.titanium,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.graphite,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.steel),
              ),
              child: Column(
                children: specs.entries
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.key,
                              style: AppTypography.caption.copyWith(color: AppColors.titanium),
                            ),
                            Text(
                              e.value,
                              style: AppTypography.bodyStrong.copyWith(
                                color: AppColors.iceWhite,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
