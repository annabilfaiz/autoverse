import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/post_model.dart';
import '../../../../data/models/vehicle_model.dart';
import '../../../../data/vehicles_data.dart';
import '../../../../features/home/state/feed_controller.dart';

class FeaturedVehicleShowcaseScreen extends StatelessWidget {
  final FeedController? feedController;
  final VehicleModel? vehicle;

  const FeaturedVehicleShowcaseScreen({
    super.key,
    this.feedController,
    this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    final currentVehicle = vehicle ?? VehiclesData.getAdityaGarageVehicles().first;
    final targetVehicleId = currentVehicle.id;
    final linkedPosts = feedController != null
        ? feedController!.getPostsForVehicle(targetVehicleId)
        : <PostModel>[];

    final isPorsche = currentVehicle.id == 'veh_porsche_gt3';
    final isMazda = currentVehicle.id == 'veh_mazda_rx7';

    final wheelsTitle = isPorsche
        ? 'BBS FI-R Monobloc 20"'
        : (isMazda ? 'Volk Racing TE37 SL 18"' : 'Enkei RPF1 18"');
    final exhaustTitle = isPorsche
        ? 'Akrapovič Titanium Race'
        : (isMazda ? 'HKS Hi-Power Silent Exhaust' : 'Invidia R400 Gemini Exhaust');
    final brakesTitle = isPorsche
        ? 'Brembo Carbon 410mm'
        : (isMazda ? 'AP Racing Radi-CAL 6-Pot' : 'Brembo Factory Monobloc 350mm');

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      body: CustomScrollView(
        slivers: [
          // 1. Top App Bar
          SliverAppBar(
            backgroundColor: AppColors.voidBlack.withValues(alpha: 0.9),
            pinned: true,
            leading: IconButton(
              icon: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.graphite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.steel),
                ),
                child: const Icon(Icons.chevron_left, size: 22, color: AppColors.iceWhite),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(
              'FEATURED VEHICLE',
              style: AppTypography.micro.copyWith(
                letterSpacing: 2.0,
                fontWeight: FontWeight.w700,
                color: AppColors.titanium,
              ),
            ),
            actions: [
              IconButton(
                icon: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.graphite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.steel),
                  ),
                  child: const Icon(Icons.share, size: 18, color: AppColors.iceWhite),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.graphite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.steel),
                  ),
                  child: const Icon(Icons.bookmark_border, size: 18, color: AppColors.iceWhite),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),

          // 2. Interactive Hero Stage with Technical Callouts
          SliverToBoxAdapter(
            child: SizedBox(
              height: 280,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    currentVehicle.imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stk) => Container(
                      color: AppColors.carbon,
                      child: const Center(
                        child: Icon(Icons.directions_car, size: 48, color: AppColors.titanium),
                      ),
                    ),
                  ),
                  // Dark gradients
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.voidBlack.withValues(alpha: 0.6),
                          Colors.transparent,
                          AppColors.voidBlack,
                        ],
                        stops: const [0.0, 0.5, 1.0],
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
          ),

          // 3. Vehicle Title & Dual-Pill Specification Strips
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FEATURED VEHICLE',
                    style: AppTypography.micro.copyWith(
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.performanceLime,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentVehicle.displayName,
                    style: AppTypography.headlineH1.copyWith(
                      fontSize: 26,
                      color: AppColors.iceWhite,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Generation ${currentVehicle.generation} · ${currentVehicle.nickname} · ${currentVehicle.status}',
                    style: AppTypography.caption.copyWith(color: AppColors.titanium),
                  ),
                  const SizedBox(height: 16),

                  // Dual Specification Strips
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.carbon,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.steel),
                    ),
                    child: Center(
                      child: Text(
                        '${currentVehicle.specs['Engine'] ?? 'High Performance Engine'}  •  ${currentVehicle.specs['Transmission'] ?? 'Manual'}',
                        style: AppTypography.bodyStrong.copyWith(fontSize: 13, color: AppColors.iceWhite),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.graphite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.steel),
                    ),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          style: AppTypography.bodyStrong.copyWith(fontSize: 13, color: AppColors.iceWhite),
                          children: [
                            TextSpan(
                              text: currentVehicle.specs['Power'] ?? 'Tuned Spec',
                              style: const TextStyle(color: AppColors.performanceLime),
                            ),
                            const TextSpan(text: '  •  '),
                            TextSpan(text: currentVehicle.status),
                            const TextSpan(text: '  •  '),
                            TextSpan(
                              text: '${linkedPosts.length} Updates',
                              style: const TextStyle(color: AppColors.performanceLime),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      '*Owner-reported build telemetry · Demo specification',
                      style: AppTypography.micro.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColors.mutedSteel,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // 4. Factory Specifications Grid
          SliverToBoxAdapter(
            child: Padding(
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
                          'FACTORY SPECIFICATIONS',
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
                        Expanded(child: _specItem('Manufacturer', currentVehicle.manufacturer)),
                        Expanded(child: _specItem('Model', currentVehicle.model)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _specItem('Engine', currentVehicle.specs['Engine'] ?? 'High Performance Spec')),
                        Expanded(child: _specItem('Power Spec', currentVehicle.specs['Power'] ?? 'Track Spec')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 5. Simplified Build Inventory
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Build Inventory (14 Installed)',
                          style: AppTypography.headlineH3.copyWith(fontSize: 16, color: AppColors.iceWhite),
                        ),
                      ),
                      Text(
                        'View All (14) >',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.performanceLime,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _inventoryRow(
                    context: context,
                    icon: Icons.air,
                    category: 'ENGINE & EXHAUST',
                    title: 'Akrapovič Titanium Full System',
                    delta: '+22 HP · -11 kg',
                  ),
                  const SizedBox(height: 8),
                  _inventoryRow(
                    context: context,
                    icon: Icons.speed,
                    category: 'SUSPENSION & CHASSIS',
                    title: 'KW Clubsport 3-Way Coilovers',
                    delta: 'Corner Balanced Track Spec',
                  ),
                  const SizedBox(height: 8),
                  _inventoryRow(
                    context: context,
                    icon: Icons.radio_button_checked,
                    category: 'WHEELS & TIRES',
                    title: 'BBS FI-R Monobloc 20" / Michelin Cup 2',
                    delta: 'Lightweight Forged',
                  ),
                ],
              ),
            ),
          ),

          // 6. Modification Timeline (Single Latest Entry)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latest Build Milestone',
                    style: AppTypography.headlineH3.copyWith(fontSize: 16, color: AppColors.iceWhite),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.carbon,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.steel),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: AppColors.limeSoft,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.build_circle, size: 18, color: AppColors.performanceLime),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Oct 18, 2026',
                                style: AppTypography.micro.copyWith(
                                  color: AppColors.performanceLime,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Akrapovič Titanium Race Exhaust (+22 HP, -11 kg)',
                                style: AppTypography.bodyStrong.copyWith(color: AppColors.iceWhite),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Installed full titanium headers and race cats at Sentul Speed Lab. Dyno verified.',
                                style: AppTypography.caption.copyWith(color: AppColors.titanium),
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
          ),

          // 6b. Build Posts & Updates
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'BUILD POSTS & UPDATES',
                          style: AppTypography.micro.copyWith(
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.performanceLime,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.performanceLime
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${linkedPosts.length} Updates',
                          style: AppTypography.micro.copyWith(
                            color: AppColors.performanceLime,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (linkedPosts.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.carbon,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.steel),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.directions_car_filled_rounded,
                            color: AppColors.mutedSteel,
                            size: 28,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No posts linked to this vehicle yet',
                            style: AppTypography.bodyStrong.copyWith(
                              color: AppColors.iceWhite,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Create a post and select this car to display dyno pulls and track updates.',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.mutedSteel,
                              fontSize: 11,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  else
                    ...linkedPosts.map(
                      (post) => Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.carbon,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.steel),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 56,
                                height: 56,
                                color: AppColors.graphite,
                                child: Image.asset(
                                  post.mediaAsset,
                                  fit: BoxFit.cover,
                                  errorBuilder: (ctx, err, stk) => const Icon(
                                    Icons.directions_car_rounded,
                                    color: AppColors.titanium,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        post.creatorUsername,
                                        style: AppTypography.bodyStrong.copyWith(
                                          color: AppColors.iceWhite,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.verified,
                                        size: 12,
                                        color: AppColors.performanceLime,
                                      ),
                                      const Spacer(),
                                      Text(
                                        post.timeAgo,
                                        style: AppTypography.micro.copyWith(
                                          color: AppColors.mutedSteel,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    post.caption,
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.titanium,
                                      fontSize: 12,
                                      height: 1.3,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.favorite_rounded,
                                        size: 13,
                                        color: AppColors.error,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${post.likeCount}',
                                        style: AppTypography.micro.copyWith(
                                          color: AppColors.iceWhite,
                                          fontSize: 10,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      const Icon(
                                        Icons.chat_bubble_outline_rounded,
                                        size: 13,
                                        color: AppColors.mutedSteel,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${post.commentCount}',
                                        style: AppTypography.micro.copyWith(
                                          color: AppColors.iceWhite,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // 7. Clean Bottom Ending (Only View Full Build Timeline CTA)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.graphite,
                        foregroundColor: AppColors.iceWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: AppColors.steel),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Opening full build timeline...'),
                            backgroundColor: AppColors.carbon,
                          ),
                        );
                      },
                      child: Text(
                        'View Full Build Timeline',
                        style: AppTypography.button.copyWith(color: AppColors.iceWhite),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildCalloutChip(
    BuildContext context, {
    required String category,
    required String title,
    required bool alignRight,
    required String description,
    required Map<String, String> specs,
  }) {
    return GestureDetector(
      onTap: () => _showComponentDetail(
        context,
        category: category,
        title: title,
        description: description,
        specs: specs,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.graphite.withValues(alpha: 0.9),
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

  static void _showComponentDetail(
    BuildContext context, {
    required String category,
    required String title,
    required String description,
    required Map<String, String> specs,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
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
                  Text('Verified Upgrade', style: AppTypography.micro.copyWith(color: AppColors.titanium)),
                ],
              ),
              const SizedBox(height: 10),
              Text(title, style: AppTypography.headlineH2.copyWith(color: AppColors.iceWhite)),
              const SizedBox(height: 6),
              Text(description, style: AppTypography.caption.copyWith(color: AppColors.titanium, height: 1.4)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.graphite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.steel),
                ),
                child: Column(
                  children: specs.entries.map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.key, style: AppTypography.caption.copyWith(color: AppColors.titanium)),
                        Text(e.value, style: AppTypography.bodyStrong.copyWith(color: AppColors.iceWhite, fontSize: 12)),
                      ],
                    ),
                  )).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _specItem(String label, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.caption.copyWith(color: AppColors.titanium, fontSize: 11)),
        const SizedBox(height: 2),
        Text(val, style: AppTypography.bodyStrong.copyWith(color: AppColors.iceWhite, fontSize: 13)),
      ],
    );
  }

  Widget _inventoryRow({
    required BuildContext context,
    required IconData icon,
    required String category,
    required String title,
    required String delta,
  }) {
    return GestureDetector(
      onTap: () => _showComponentDetail(
        context,
        category: category,
        title: title,
        description: 'Installed component telemetry and upgrade specifications.',
        specs: {
          'Category': category,
          'Component': title,
          'Performance Delta': delta,
          'Installation': 'Sentul Speed Lab Verified',
        },
      ),
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
                    style: AppTypography.bodyStrong.copyWith(color: AppColors.iceWhite, fontSize: 13),
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
            const Icon(Icons.chevron_right, size: 18, color: AppColors.titanium),
          ],
        ),
      ),
    );
  }
}
