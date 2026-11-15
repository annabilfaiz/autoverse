import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../state/marketplace_controller.dart';

/// Vehicle compatibility filter panel for automotive parts in Marketplace.
class MarketplaceFilterPanel extends StatelessWidget {
  final MarketplaceController controller;

  const MarketplaceFilterPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final compatOptions = [
      '',
      'Porsche 911',
      'Mazda RX-7',
      'Honda Civic Type R',
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.carbon,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.steel),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kompatibilitas Kendaraan',
            style: AppTypography.caption.copyWith(
              color: AppColors.titanium,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: compatOptions.map((opt) {
              final isSelected = controller.compatibilityFilter == opt;
              final label = opt.isEmpty ? 'Semua Kendaraan' : opt;
              return GestureDetector(
                onTap: () => controller.setCompatibilityFilter(opt),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.performanceLime.withValues(alpha: 0.15)
                        : AppColors.graphite,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.performanceLime
                          : AppColors.steel,
                    ),
                  ),
                  child: Text(
                    label,
                    style: AppTypography.caption.copyWith(
                      color: isSelected
                          ? AppColors.performanceLime
                          : AppColors.iceWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
