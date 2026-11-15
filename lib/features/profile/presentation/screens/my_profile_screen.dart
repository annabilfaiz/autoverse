import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../home/state/feed_controller.dart';
import '../../../../data/models/post_model.dart';
import '../../../../data/vehicles_data.dart';
import '../../../showcase/presentation/screens/featured_vehicle_showcase_screen.dart';

class MyProfileScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  final FeedController? feedController;

  const MyProfileScreen({
    super.key,
    this.onBackToHome,
    this.feedController,
  });

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  int _selectedTab = 0; // 0: Posts, 1: Builds, 2: Saved

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      body: SafeArea(
        bottom: false,
        child: ListenableBuilder(
          listenable: widget.feedController ?? ValueNotifier(0),
          builder: (context, _) {
            final authorPosts =
                widget.feedController?.getPostsForAuthor('@aditya_gt3') ?? [];
            final totalPostCount = widget.feedController?.authorPostCount ?? 38;

            return CustomScrollView(
          slivers: [
            // 1. Top App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (widget.onBackToHome != null)
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.iceWhite),
                            onPressed: widget.onBackToHome,
                            padding: const EdgeInsets.only(right: 8),
                            constraints: const BoxConstraints(),
                          ),
                        Text(
                          '@aditya_gt3',
                          style: AppTypography.headlineH3.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.iceWhite,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified, size: 16, color: AppColors.performanceLime),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.ios_share, size: 20, color: AppColors.titanium),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.settings, size: 20, color: AppColors.titanium),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 2. Profile Identity Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Avatar with Active Build Indicator
                        Stack(
                          children: [
                            Container(
                              width: 76,
                              height: 76,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.steel, width: 2),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/avatar_aditya.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: AppColors.performanceLime,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.voidBlack, width: 2),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Stats Counters
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _statCounter('$totalPostCount', 'Posts'),
                              _statCounter('14.8k', 'Followers'),
                              _statCounter('420', 'Following'),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Bio
                    Text(
                      'Aditya Pratama',
                      style: AppTypography.headlineH3.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.iceWhite,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.limeSoft,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'PRO BUILDER',
                            style: AppTypography.micro.copyWith(
                              color: AppColors.performanceLime,
                              fontWeight: FontWeight.w700,
                              fontSize: 9,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Jakarta, Indonesia',
                          style: AppTypography.caption.copyWith(color: AppColors.titanium),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '992 GT3 track build and vintage air-cooled projects. Driving fast, wrenching slow.',
                      style: AppTypography.body.copyWith(fontSize: 13, color: AppColors.iceWhite),
                    ),

                    const SizedBox(height: 14),

                    // Profile Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 38,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: AppColors.graphite,
                                foregroundColor: AppColors.iceWhite,
                                side: const BorderSide(color: AppColors.steel),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.edit, size: 15, color: AppColors.iceWhite),
                              label: Text('Edit Profile', style: AppTypography.button.copyWith(fontSize: 12)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.graphite,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.steel),
                          ),
                          child: const Icon(Icons.share, size: 16, color: AppColors.iceWhite),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 3. Featured Vehicle Signature Card (No stat boxes)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'FEATURED VEHICLE',
                          style: AppTypography.micro.copyWith(
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.performanceLime,
                          ),
                        ),
                        Text(
                          'Signature Build',
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
                              'assets/images/feed_porsche_dusk.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Details
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
                                              feedController: widget.feedController,
                                            ),
                                          ),
                                        );
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Explore Full Showcase',
                                          style: AppTypography.button.copyWith(
                                            color: AppColors.voidBlack,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        const Icon(Icons.arrow_forward, size: 16, color: AppColors.voidBlack),
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
            ),

            // 4. Compact My Garage Rows
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Garage (3)',
                          style: AppTypography.headlineH3.copyWith(fontSize: 16, color: AppColors.iceWhite),
                        ),
                        Text(
                          'View All >',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.performanceLime,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _garageRow(
                      '1994 Mazda RX-7 FD3S',
                      'Twin-Turbo 13B-REW · Build in Progress',
                      'In Progress',
                      onTap: () {
                        final rx7 = VehiclesData.getAdityaGarageVehicles()
                            .firstWhere((v) => v.id == 'veh_mazda_rx7');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FeaturedVehicleShowcaseScreen(
                              vehicle: rx7,
                              feedController: widget.feedController,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    _garageRow(
                      '2018 Honda Civic Type R FK8',
                      'Daily Track Spec · 306 HP · K20C1',
                      'Active Daily',
                      onTap: () {
                        final civic = VehiclesData.getAdityaGarageVehicles()
                            .firstWhere((v) => v.id == 'veh_civic_fk8');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FeaturedVehicleShowcaseScreen(
                              vehicle: civic,
                              feedController: widget.feedController,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // 5. Tabs (Posts, Builds, Saved)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.steel)),
                  ),
                  child: Row(
                    children: [
                      _tabButton(0, Icons.grid_view, 'Posts'),
                      _tabButton(1, Icons.tune, 'Builds'),
                      _tabButton(2, Icons.bookmark_border, 'Saved'),
                    ],
                  ),
                ),
              ),
            ),

            // 6. Dynamic Tab Content (Posts, Builds, Saved)
            if (_selectedTab == 0) ...[
              // Posts Media Grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final fallbackImages = [
                        'assets/images/feed_porsche_dusk.png',
                        'assets/images/feed_rx7_track.png',
                        'assets/images/feed_porsche_gt3.png',
                        'assets/images/feed_porsche_911.png',
                        'assets/images/feed_porsche_dusk.png',
                        'assets/images/feed_rx7_track.png',
                      ];

                      if (index < authorPosts.length) {
                        final post = authorPosts[index];
                        return GestureDetector(
                          onTap: () => _showPostDetail(context, post),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: AppColors.steel.withValues(alpha: 0.5)),
                              image: DecorationImage(
                                image: AssetImage(post.mediaAsset),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 4,
                                  left: 4,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.favorite_rounded,
                                          size: 10,
                                          color: AppColors.performanceLime),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${post.likeCount}',
                                        style: AppTypography.micro.copyWith(
                                          fontSize: 9,
                                          color: AppColors.iceWhite,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (post.linkedVehicleChip.isNotEmpty)
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: AppColors.voidBlack
                                            .withValues(alpha: 0.8),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.directions_car_filled_rounded,
                                        size: 10,
                                        color: AppColors.performanceLime,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }

                      final fallbackIdx =
                          (index - authorPosts.length) % fallbackImages.length;
                      final img = fallbackImages[fallbackIdx];

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.steel.withValues(alpha: 0.5)),
                          image: DecorationImage(
                            image: AssetImage(img),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 4,
                              left: 4,
                              child: Row(
                                children: [
                                  const Icon(Icons.play_arrow,
                                      size: 12,
                                      color: AppColors.performanceLime),
                                  const SizedBox(width: 2),
                                  Text(
                                    '${(12.4 - index * 1.5).clamp(1.0, 99.0).toStringAsFixed(1)}k',
                                    style: AppTypography.micro.copyWith(
                                      fontSize: 9,
                                      color: AppColors.iceWhite,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: authorPosts.length > 6 ? authorPosts.length : 6,
                  ),
                ),
              ),
            ] else if (_selectedTab == 1) ...[
              // Builds Tab
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final vehicles = VehiclesData.getAdityaGarageVehicles();
                      final v = vehicles[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.carbon,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.steel),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    v.imageAsset,
                                    width: 54,
                                    height: 54,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(v.displayName, style: AppTypography.bodyStrong.copyWith(color: AppColors.iceWhite)),
                                      const SizedBox(height: 2),
                                      Text('Generation ${v.generation} • ${v.nickname}', style: AppTypography.caption.copyWith(color: AppColors.titanium, fontSize: 11)),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.graphite,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(v.status, style: AppTypography.micro.copyWith(color: AppColors.performanceLime, fontSize: 10)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 36,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.graphite,
                                  foregroundColor: AppColors.iceWhite,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(color: AppColors.steel),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FeaturedVehicleShowcaseScreen(
                                        vehicle: v,
                                        feedController: widget.feedController,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('View Vehicle Showcase', style: AppTypography.caption.copyWith(color: AppColors.iceWhite)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: VehiclesData.getAdityaGarageVehicles().length,
                  ),
                ),
              ),
            ] else ...[
              // Saved Tab
              Builder(
                builder: (context) {
                  final savedPosts = widget.feedController?.allPosts.where((p) => p.isSaved).toList() ?? [];
                  if (savedPosts.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          children: [
                            const Icon(Icons.bookmark_border_rounded, size: 48, color: AppColors.mutedSteel),
                            const SizedBox(height: 12),
                            Text(
                              'No Saved Posts Yet',
                              style: AppTypography.headlineH3.copyWith(color: AppColors.titanium),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Bookmark automotive posts and build logs from Home FYP to view them here.',
                              style: AppTypography.caption.copyWith(color: AppColors.mutedSteel),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        childAspectRatio: 1.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final post = savedPosts[index];
                          return GestureDetector(
                            onTap: () => _showPostDetail(context, post),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.steel.withValues(alpha: 0.5)),
                                image: DecorationImage(
                                  image: AssetImage(post.mediaAsset),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: AppColors.voidBlack.withValues(alpha: 0.8),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.bookmark_rounded, size: 10, color: AppColors.performanceLime),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: savedPosts.length,
                      ),
                    ),
                  );
                },
              ),
            ],

            const SliverToBoxAdapter(
              child: SizedBox(height: 100), // Spacing for floating bottom nav
            ),
          ],
        );
          },
        ),
      ),
    );
  }

  Widget _statCounter(String val, String label) {
    return Column(
      children: [
        Text(
          val,
          style: AppTypography.headlineH2.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.iceWhite,
          ),
        ),
        Text(
          label,
          style: AppTypography.micro.copyWith(
            color: AppColors.titanium,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _garageRow(String title, String subtitle, String status, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
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
                  Text(subtitle, style: AppTypography.caption.copyWith(color: AppColors.titanium, fontSize: 11)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.graphite,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                status,
                style: AppTypography.micro.copyWith(
                  color: status.contains('Progress') ? AppColors.performanceLime : AppColors.titanium,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (onTap != null) ...[
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, size: 16, color: AppColors.titanium),
            ],
          ],
        ),
      ),
    );
  }

  Widget _tabButton(int index, IconData icon, String label) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.performanceLime : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? AppColors.performanceLime : AppColors.titanium,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? AppColors.iceWhite : AppColors.titanium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPostDetail(BuildContext context, PostModel post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: AppColors.carbon,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          border: Border(top: BorderSide(color: AppColors.steel)),
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 12),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.mutedSteel.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(post.creatorAvatarAsset),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              post.creatorName,
                              style: AppTypography.bodyStrong.copyWith(color: AppColors.iceWhite),
                            ),
                            if (post.isVerified) ...[
                              const SizedBox(width: 4),
                              const Icon(Icons.verified, size: 14, color: AppColors.performanceLime),
                            ],
                          ],
                        ),
                        Text(
                          '${post.creatorUsername} • ${post.timeAgo}',
                          style: AppTypography.caption.copyWith(color: AppColors.titanium, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.titanium),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.steel, height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 240,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.graphite,
                          border: Border.all(color: AppColors.steel),
                        ),
                        child: Image.asset(
                          post.mediaAsset,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Center(
                            child: Icon(Icons.image_not_supported, color: AppColors.titanium),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    if (post.linkedVehicleChip.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.performanceLime.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.performanceLime.withValues(alpha: 0.4)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.directions_car_rounded, size: 14, color: AppColors.performanceLime),
                            const SizedBox(width: 6),
                            Text(
                              post.linkedVehicleChip,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.performanceLime,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    Text(
                      post.caption,
                      style: AppTypography.body.copyWith(
                        color: AppColors.iceWhite,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _modalStat(Icons.favorite_rounded, '${post.likeCount} Likes', AppColors.error),
                        const SizedBox(width: 20),
                        _modalStat(Icons.chat_bubble_rounded, '${post.commentCount} Comments', AppColors.titanium),
                        const SizedBox(width: 20),
                        _modalStat(Icons.share_rounded, '${post.shareCount} Shares', AppColors.titanium),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modalStat(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Text(text, style: AppTypography.caption.copyWith(color: AppColors.titanium, fontSize: 12)),
      ],
    );
  }
}
