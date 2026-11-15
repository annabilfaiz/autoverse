import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/vehicle_model.dart';

class CreatePostVehicleSelector extends StatelessWidget {
  final List<VehicleModel> availableVehicles;
  final VehicleModel? selectedVehicle;
  final ValueChanged<VehicleModel> onVehicleToggled;
  final VoidCallback onClearVehicle;

  const CreatePostVehicleSelector({
    super.key,
    required this.availableVehicles,
    required this.selectedVehicle,
    required this.onVehicleToggled,
    required this.onClearVehicle,
  });

  @override
  Widget build(BuildContext context) {
    final hasVehicle = selectedVehicle != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'LINK TO VEHICLE',
                  style: AppTypography.micro.copyWith(
                    color: AppColors.mutedSteel,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: AppColors.graphite,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.steel),
                  ),
                  child: Text(
                    'OPTIONAL',
                    style: AppTypography.micro.copyWith(
                      color: AppColors.titanium,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            if (hasVehicle)
              GestureDetector(
                onTap: onClearVehicle,
                child: Text(
                  'Clear Link',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.performanceLime,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Attach this update to your signature build or garage car showcase.',
          style: AppTypography.caption.copyWith(
            color: AppColors.mutedSteel,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 12),

        // Vehicles list
        ...availableVehicles.map((vehicle) {
          final isSelected = selectedVehicle?.id == vehicle.id;

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onVehicleToggled(vehicle),
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.performanceLime.withValues(alpha: 0.08)
                        : AppColors.carbon,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.performanceLime
                          : AppColors.steel,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Vehicle thumbnail
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 48,
                          height: 48,
                          color: AppColors.graphite,
                          child: Image.asset(
                            vehicle.imageAsset,
                            fit: BoxFit.cover,
                            errorBuilder: (ctx, err, stk) => const Icon(
                              Icons.directions_car_rounded,
                              color: AppColors.titanium,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Vehicle details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  vehicle.displayName,
                                  style: AppTypography.bodyStrong.copyWith(
                                    color: isSelected
                                        ? AppColors.performanceLime
                                        : AppColors.iceWhite,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '(${vehicle.generation})',
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.mutedSteel,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${vehicle.nickname} • ${vehicle.status}',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.titanium,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Selection Indicator
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.performanceLime
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.performanceLime
                                : AppColors.steel,
                            width: 1.5,
                          ),
                        ),
                        child: isSelected
                            ? const Center(
                                child: Icon(
                                  Icons.check_rounded,
                                  size: 14,
                                  color: AppColors.voidBlack,
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
