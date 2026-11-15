import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Category shortcut icon chip for automotive component categories.
class MarketplaceCategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const MarketplaceCategoryChip({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.performanceLime.withValues(alpha: 0.18)
                    : AppColors.carbon,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? AppColors.performanceLime : AppColors.steel,
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: Icon(
                icon,
                size: 24,
                color: isSelected ? AppColors.performanceLime : AppColors.titanium,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTypography.micro.copyWith(
                color: isSelected ? AppColors.performanceLime : AppColors.titanium,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
