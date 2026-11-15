import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/vehicle_model.dart';
import 'component_detail_modal.dart';

/// Renders factory specifications card and installed build inventory
/// for the vehicle showcase screen.
class ShowcaseSpecsInventory extends StatelessWidget {
  final VehicleModel vehicle;

  const ShowcaseSpecsInventory({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Factory Specifications Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.carbon,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.steel),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SPESIFIKASI PABRIK',
                      style: AppTypography.micro.copyWith(
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.titanium,
                      ),
                    ),
                    const Icon(Icons.tune, size: 16, color: AppColors.titanium),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(color: AppColors.steel, height: 1),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _specItem('Pabrikan', vehicle.manufacturer),
                    ),
                    Expanded(child: _specItem('Model', vehicle.model)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _specItem(
                        'Mesin',
                        vehicle.specs['Engine'] ?? 'High Performance Spec',
                      ),
                    ),
                    Expanded(
                      child: _specItem(
                        'Tenaga',
                        vehicle.specs['Power'] ?? 'Track Spec',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // 2. Build Inventory Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daftar Modifikasi',
                style: AppTypography.headlineH3.copyWith(
                  fontSize: 16,
                  color: AppColors.iceWhite,
                ),
              ),
              const SizedBox(height: 12),
              _inventoryRow(
                context: context,
                icon: Icons.air,
                category: 'MESIN & KNALPOT',
                title: 'Akrapovič Titanium Full System',
                delta: '+22 HP · -11 kg',
                imageAsset:
                    'assets/images/products/product_titanium_exhaust.jpg',
              ),
              const SizedBox(height: 8),
              _inventoryRow(
                context: context,
                icon: Icons.speed,
                category: 'SUSPENSI & SASIS',
                title: 'KW Clubsport 3-Way Coilovers',
                delta: 'Setelan Seimbang untuk Lintasan',
                imageAsset:
                    'assets/images/products/product_performance_coilover.jpg',
              ),
              const SizedBox(height: 8),
              _inventoryRow(
                context: context,
                icon: Icons.radio_button_checked,
                category: 'VELG & BAN',
                title: 'BBS FI-R Monobloc 20" / Michelin Cup 2',
                delta: 'Velg Tempa Ringan',
                imageAsset: 'assets/images/products/product_forged_wheel.jpg',
              ),
              const SizedBox(height: 8),
              _inventoryRow(
                context: context,
                icon: Icons.album_outlined,
                category: 'SISTEM PENGEREMAN',
                title: 'Brembo Carbon-Ceramic 410mm',
                delta: 'Rotor Karbon & Kaliper Monobloc',
                imageAsset:
                    'assets/images/products/product_carbon_ceramic_brake.jpg',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _specItem(String label, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: AppColors.titanium,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          val,
          style: AppTypography.bodyStrong.copyWith(
            color: AppColors.iceWhite,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _inventoryRow({
    required BuildContext context,
    required IconData icon,
    required String category,
    required String title,
    required String delta,
    String? imageAsset,
  }) {
    return GestureDetector(
      onTap: () => ComponentDetailModal.show(
        context,
        category: category,
        title: title,
        description: 'Telemetri komponen modifikasi terpasang dan rincian peningkatan performa.',
        specs: {
          'Kategori': category,
          'Komponen': title,
          'Peningkatan Performa': delta,
          'Instalasi': 'Terverifikasi Sentul Speed Lab',
        },
        imageAsset: imageAsset,
      ),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.carbon,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.steel),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.graphite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: AppColors.performanceLime),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: AppTypography.micro.copyWith(
                      color: AppColors.titanium,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    title,
                    style: AppTypography.bodyStrong.copyWith(
                      color: AppColors.iceWhite,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    delta,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.performanceLime,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 18,
              color: AppColors.titanium,
            ),
          ],
        ),
      ),
    );
  }
}
