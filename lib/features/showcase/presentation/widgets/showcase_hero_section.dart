import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/vehicle_model.dart';
import 'component_detail_modal.dart';

/// Hero visual component for vehicle showcase, rendering vehicle photography
/// and interactive hotspot callouts for upgraded components.
class ShowcaseHeroSection extends StatelessWidget {
  final VehicleModel vehicle;

  const ShowcaseHeroSection({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final isPorsche =
        vehicle.model.contains('911') || vehicle.model.contains('GT3');
    final wheelsTitle = isPorsche
        ? 'BBS FI-R Monobloc 20"'
        : 'Volk Racing TE37 Ultra 18"';
    final exhaustTitle = isPorsche
        ? 'Akrapovič Titanium Race'
        : 'HKS Hi-Power Spec-L';
    final brakesTitle = isPorsche
        ? 'Brembo Carbon 410mm'
        : 'AP Racing Radi-CAL 6-Pot';

    return SliverToBoxAdapter(
      child: Container(
        height: 290,
        color: AppColors.voidBlack,
        child: Stack(
          children: [
            // Vehicle Hero Image
            Positioned.fill(
              child: Image.asset(
                vehicle.imageAsset.isNotEmpty
                    ? vehicle.imageAsset
                    : 'assets/images/vehicles/vehicle_porsche_911_gt3_hero.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.carbon,
                  child: const Center(
                    child: Icon(
                      Icons.directions_car,
                      size: 64,
                      color: AppColors.steel,
                    ),
                  ),
                ),
              ),
            ),

            // Subtle Vignette Gradient
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.voidBlack.withValues(alpha: 0.5),
                      Colors.transparent,
                      AppColors.voidBlack,
                    ],
                    stops: const [0.0, 0.55, 1.0],
                  ),
                ),
              ),
            ),

            // Callout A: Velg & Ban
            Positioned(
              top: 60,
              left: 16,
              child: _buildCalloutChip(
                context,
                category: 'VELG & BAN',
                title: wheelsTitle,
                alignRight: false,
                description: isPorsche
                    ? 'Velg tempa aluminium monobloc berbobot sangat ringan berstandar dirgantara, dirancang untuk ketahanan di sirkuit.'
                    : 'Velg tempa monobloc untuk sirkuit yang memberikan kekakuan maksimal dan mereduksi bobot unsprung mass.',
                specs: isPorsche
                    ? {
                        'Ukuran': '20" x 9.5J depan, 21" x 12J belakang',
                        'Material': 'Paduan Aluminium Tempa (Forged)',
                        'Bobot': '7.9 kg / velg',
                        'Spesifikasi Ban': 'Michelin Pilot Sport Cup 2 R',
                      }
                    : {
                        'Ukuran': '18" x 9.5J track spec',
                        'Material': 'Aluminium Tempa 6061-T6',
                        'Bobot': '8.2 kg',
                      },
              ),
            ),

            // Callout B: Knalpot & Performa
            Positioned(
              top: 70,
              right: 16,
              child: _buildCalloutChip(
                context,
                category: 'KNALPOT & PERFORMA',
                title: exhaustTitle,
                alignRight: true,
                description: isPorsche
                    ? 'Sistem knalpot sport titanium murni dengan header khusus dan katup valvetronic aktif.'
                    : 'Sistem knalpot performa tinggi untuk memaksimalkan aliran gas buang dan resonansi akustik.',
                specs: isPorsche
                    ? {
                        'Material': 'Full Grade 1 Titanium',
                        'Peningkatan Tenaga': '+22 HP @ 8.400 RPM',
                        'Reduksi Bobot': '-11.2 kg',
                        'Karakter Suara': '108 dB (Mode Sirkuit)',
                      }
                    : {
                        'Material': 'Stainless Steel SUS304',
                        'Diameter': '76 mm ke ujung tip 115 mm',
                        'Peningkatan Tenaga': '+14 WHP',
                      },
              ),
            ),

            // Callout C: Pengereman
            Positioned(
              bottom: 30,
              left: 24,
              child: _buildCalloutChip(
                context,
                category: 'PENGEREMAN',
                title: brakesTitle,
                alignRight: false,
                description: isPorsche
                    ? 'Sistem rem keramik karbon 6-piston monobloc dengan kampas rem balap tahan suhu ekstrem.'
                    : 'Sistem kaliper rem multi-piston berperforma tinggi dengan piringan rotor slotted floating.',
                specs: isPorsche
                    ? {
                        'Diameter Rotor': '410 mm depan / 390 mm belakang',
                        'Kaliper': '6-Piston Monobloc Brembo',
                        'Minyak Rem': 'Motul RBF 660 Factory Line',
                        'Batas Suhu': '900°C Thermal Limit',
                      }
                    : {
                        'Diameter Rotor': '355 mm floating rotor',
                        'Kaliper': '6-Piston Radi-CAL',
                        'Kampas Rem': 'Endless ME20 Compound',
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalloutChip(
    BuildContext context, {
    required String category,
    required String title,
    required bool alignRight,
    required String description,
    required Map<String, String> specs,
  }) {
    return GestureDetector(
      onTap: () => ComponentDetailModal.show(
        context,
        category: category,
        title: title,
        description: description,
        specs: specs,
      ),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.graphite.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.steel),
          boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: alignRight
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!alignRight) ...[
                  const Icon(
                    Icons.touch_app_rounded,
                    size: 10,
                    color: AppColors.performanceLime,
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  category,
                  style: AppTypography.micro.copyWith(
                    color: AppColors.performanceLime,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (alignRight) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.touch_app_rounded,
                    size: 10,
                    color: AppColors.performanceLime,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: AppTypography.caption.copyWith(
                color: AppColors.iceWhite,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
