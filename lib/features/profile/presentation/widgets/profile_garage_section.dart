import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/vehicles_data.dart';
import '../../../home/state/feed_controller.dart';
import '../../../showcase/presentation/screens/featured_vehicle_showcase_screen.dart';
import '../../state/saved_items_controller.dart';

/// Renders the user's signature featured vehicle card and garage vehicle items.
class ProfileGarageSection extends StatelessWidget {
  final FeedController? feedController;
  final SavedItemsController? savedController;

  const ProfileGarageSection({
    super.key,
    this.feedController,
    this.savedController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Featured Vehicle Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'KENDARAAN UNGGULAN',
                    style: AppTypography.micro.copyWith(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.performanceLime,
                    ),
                  ),
                  Text(
                    'Modifikasi Utama',
                    style: AppTypography.caption.copyWith(color: AppColors.titanium, fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.carbon,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.steel),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Vehicle Image
                    SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/vehicles/vehicle_porsche_911_gt3_hero.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '2022 Porsche 911 GT3 (992.1)',
                            style: AppTypography.headlineH3.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.iceWhite,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '4.0L Flat-6 · 6-Speed GT Sport · Track Spec',
                            style: AppTypography.caption.copyWith(color: AppColors.titanium),
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            height: 42,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.performanceLime,
                                foregroundColor: AppColors.voidBlack,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FeaturedVehicleShowcaseScreen(
                                      feedController: feedController,
                                      savedController: savedController,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Lihat Detail Kendaraan',
                                    style: AppTypography.button.copyWith(
                                      color: AppColors.voidBlack,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.arrow_forward_rounded, size: 16, color: AppColors.voidBlack),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 2. Compact My Garage Rows
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Garasi Saya',
                style: AppTypography.headlineH3.copyWith(fontSize: 16, color: AppColors.iceWhite),
              ),
              const SizedBox(height: 10),
              _garageRow(
                '1994 Mazda RX-7 FD3S',
                'Twin-Turbo 13B-REW · Dalam Proses',
                'Dalam Proses',
                onTap: () {
                  final rx7 = VehiclesData.getAdityaGarageVehicles()
                      .firstWhere((v) => v.id == 'veh_mazda_rx7');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FeaturedVehicleShowcaseScreen(
                        vehicle: rx7,
                        feedController: feedController,
                        savedController: savedController,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              _garageRow(
                '2018 Honda Civic Type R FK8',
                'Daily Track Spec · 306 HP · K20C1',
                'Harian',
                onTap: () {
                  final civic = VehiclesData.getAdityaGarageVehicles()
                      .firstWhere((v) => v.id == 'veh_civic_fk8');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FeaturedVehicleShowcaseScreen(
                        vehicle: civic,
                        feedController: feedController,
                        savedController: savedController,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _garageRow(String title, String subtitle, String status, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.carbon,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.steel),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.graphite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.directions_car, size: 18, color: AppColors.titanium),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.bodyStrong.copyWith(color: AppColors.iceWhite, fontSize: 13)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTypography.caption.copyWith(color: AppColors.titanium, fontSize: 11)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.graphite,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                status,
                style: AppTypography.micro.copyWith(
                  color: AppColors.performanceLime,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 16, color: AppColors.titanium),
          ],
        ),
      ),
    );
  }
}
