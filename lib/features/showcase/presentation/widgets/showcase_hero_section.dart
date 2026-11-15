import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/vehicle_model.dart';
import 'component_detail_modal.dart';

/// Hero visual component for vehicle showcase, rendering vehicle photography
/// and interactive hotspot callouts for upgraded components.
class ShowcaseHeroSection extends StatelessWidget {
  final VehicleModel vehicle;

  const ShowcaseHeroSection({
    super.key,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    final isPorsche = vehicle.model.contains('911') || vehicle.model.contains('GT3');
    final wheelsTitle = isPorsche ? 'BBS FI-R Monobloc 20"' : 'Volk Racing TE37 Ultra 18"';
    final exhaustTitle = isPorsche ? 'Akrapovič Titanium Race' : 'HKS Hi-Power Spec-L';
    final brakesTitle = isPorsche ? 'Brembo Carbon 410mm' : 'AP Racing Radi-CAL 6-Pot';

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
                    : 'assets/images/feed_porsche_gt3.png',
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.carbon,
                  child: const Center(
                    child: Icon(Icons.directions_car, size: 64, color: AppColors.steel),
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

            // Callout A: Wheels & Tires
            Positioned(
              top: 60,
              left: 16,
              child: _buildCalloutChip(
                context,
                category: 'WHEELS & TIRES',
                title: wheelsTitle,
                alignRight: false,
                description: isPorsche
                    ? 'Ultra-lightweight aerospace-grade forged aluminum monobloc wheels engineered for track endurance.'
                    : 'Forged monobloc track wheels offering maximum rigidity and unsprung mass reduction.',
                specs: isPorsche
                    ? {
                        'Size': '20" x 9.5J front, 21" x 12J rear',
                        'Material': 'Forged Aluminum Alloy',
                        'Weight': '7.9 kg / wheel',
                        'Tire Spec': 'Michelin Pilot Sport Cup 2 R',
                      }
                    : {
                        'Size': '18" x 9.5J track spec',
                        'Material': 'Forged 6061-T6 Aluminum',
                        'Weight': '8.2 kg',
                      },
              ),
            ),

            // Callout B: Exhaust & Aero
            Positioned(
              top: 70,
              right: 16,
              child: _buildCalloutChip(
                context,
                category: 'EXHAUST & PERFORMANCE',
                title: exhaustTitle,
                alignRight: true,
                description: isPorsche
                    ? 'Full titanium sport exhaust system with tuned headers and active valvetronic flaps.'
                    : 'Performance tuned exhaust system maximizing flow and acoustic resonance.',
                specs: isPorsche
                    ? {
                        'Material': 'Full Grade 1 Titanium',
                        'Power Gain': '+22 HP @ 8,400 RPM',
                        'Weight Savings': '-11.2 kg',
                        'Sound Output': '108 dB Track Mode',
                      }
                    : {
                        'Material': 'SUS304 Stainless Steel',
                        'Diameter': '76mm to 115mm tip',
                        'Power Gain': '+14 WHP',
                      },
              ),
            ),

            // Callout C: Braking
            Positioned(
              bottom: 30,
              left: 24,
              child: _buildCalloutChip(
                context,
                category: 'BRAKING',
                title: brakesTitle,
                alignRight: false,
                description: isPorsche
                    ? 'Carbon-ceramic 6-piston monobloc front brake setup with racing compound pads.'
                    : 'High performance multi-piston caliper system with slotted floating heat-treated rotors.',
                specs: isPorsche
                    ? {
                        'Diameter': '410mm front / 390mm rear',
                        'Caliper': '6-Piston Monobloc',
                        'Fluid': 'Motul RBF 660 Factory Line',
                        'Max Temp': '900°C Thermal Limit',
                      }
                    : {
                        'Diameter': '355mm floating rotor',
                        'Caliper': '6-Piston Radi-CAL',
                        'Pads': 'Endless ME20 Compound',
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
          boxShadow: const [
            BoxShadow(color: Colors.black45, blurRadius: 8),
          ],
        ),
        child: Column(
          crossAxisAlignment: alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!alignRight) ...[
                  const Icon(Icons.touch_app_rounded, size: 10, color: AppColors.performanceLime),
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
                  const Icon(Icons.touch_app_rounded, size: 10, color: AppColors.performanceLime),
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
