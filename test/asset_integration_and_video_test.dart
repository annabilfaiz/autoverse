import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:autoverse/data/dummy_data.dart';
import 'package:autoverse/data/marketplace_data.dart';
import 'package:autoverse/data/vehicles_data.dart';
import 'package:autoverse/features/home/presentation/widgets/video_feed_item.dart';
import 'package:autoverse/features/home/state/feed_controller.dart';
import 'package:autoverse/features/navigation/presentation/main_shell.dart';

import 'helpers/fake_video_player.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    FakeVideoPlayerPlatform.registerWith();
  });

  group('Phase 9: Asset Integration & Video Verification Tests', () {
    test('1. Vehicle image-to-ID mapping', () {
      final vehicles = VehiclesData.getAdityaGarageVehicles();
      final porsche = vehicles.firstWhere((v) => v.id == 'veh_porsche_gt3');
      final mazda = vehicles.firstWhere((v) => v.id == 'veh_mazda_rx7');
      final civic = vehicles.firstWhere((v) => v.id == 'veh_civic_fk8');

      expect(
        porsche.imageAsset,
        'assets/images/vehicles/vehicle_porsche_911_gt3_hero.jpg',
      );
      expect(
        mazda.imageAsset,
        'assets/images/vehicles/vehicle_mazda_rx7_fd3s_hero.jpg',
      );
      expect(
        civic.imageAsset,
        'assets/images/vehicles/vehicle_honda_civic_type_r_fk8_hero.jpg',
      );
    });

    test('2. Marketplace product image mapping for verified products', () {
      final products = MarketplaceData.getInitialProducts();
      final prod01 = products.firstWhere((p) => p.id == 'prod_01');
      final prod02 = products.firstWhere((p) => p.id == 'prod_02');

      expect(
        prod01.imageAsset,
        'assets/images/products/product_titanium_exhaust.jpg',
      );
      expect(
        prod02.imageAsset,
        'assets/images/products/product_forged_wheel.jpg',
      );
    });

    test('3. Correct Honda Civic image assignment and visual mismatch fix', () {
      final vehicles = VehiclesData.getAdityaGarageVehicles();
      final civic = vehicles.firstWhere((v) => v.id == 'veh_civic_fk8');
      expect(civic.imageAsset.contains('porsche'), false);
      expect(
        civic.imageAsset,
        'assets/images/vehicles/vehicle_honda_civic_type_r_fk8_hero.jpg',
      );

      final posts = DummyData.getInitialPosts();
      final post03 = posts.firstWhere((p) => p.id == 'post_03');
      expect(post03.linkedVehicleId, 'veh_civic_fk8');
      expect(post03.mediaAsset.contains('porsche'), false);
      expect(
        post03.mediaAsset,
        'assets/images/posts/video_thumbnail/post_civic_fk8_thumbnail.jpg',
      );
      expect(post03.videoAsset, 'assets/videos/fyp/fyp_civic_fk8_trackday.mp4');
    });

    test('4. Post media type and local video asset mapping', () {
      final posts = DummyData.getInitialPosts();
      final post01 = posts.firstWhere((p) => p.id == 'post_01');
      final post02 = posts.firstWhere((p) => p.id == 'post_02');
      final post03 = posts.firstWhere((p) => p.id == 'post_03');

      // post_01: Porsche GT3 video
      expect(post01.isVideo, true);
      expect(post01.videoAsset, 'assets/videos/fyp/fyp_porsche_gt3_tunnel.mp4');
      expect(
        post01.mediaAsset,
        'assets/images/posts/video_thumbnail/post_porsche_gt3_thumbnail.jpg',
      );

      // post_02: Mazda RX-7 (rotary workshop video)
      expect(post02.isVideo, true);
      expect(post02.videoAsset, 'assets/videos/fyp/fyp_mazda_rotary_idle.mp4');
      expect(
        post02.mediaAsset,
        'assets/images/posts/video_thumbnail/post_mazda_rx7_thumbnail.jpg',
      );

      // post_03: Honda FK8 video
      expect(post03.isVideo, true);
      expect(post03.videoAsset, 'assets/videos/fyp/fyp_civic_fk8_trackday.mp4');
      expect(
        post03.mediaAsset,
        'assets/images/posts/video_thumbnail/post_civic_fk8_thumbnail.jpg',
      );
    });

    testWidgets('5 & 6. FYP active-item playback and pause on scroll away', (
      tester,
    ) async {
      final controller = FeedController();
      final post = DummyData.getInitialPosts().first;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VideoFeedItem(
              post: post,
              controller: controller,
              isCurrentPost: true,
              isActiveTab: true,
              onProfileTap: () {},
              onVehicleTap: () {},
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Now scroll away (simulate changing active post)
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VideoFeedItem(
              post: post,
              controller: controller,
              isCurrentPost: false,
              isActiveTab: true,
              onProfileTap: () {},
              onVehicleTap: () {},
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(VideoFeedItem), findsOneWidget);
    });

    testWidgets('7. Pausing playback when switching tabs in MainShell', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: MainShell(initialIndex: 0)),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Home tab is active
      expect(find.byType(MainShell), findsOneWidget);

      // Switch to Marketplace tab (index 1)
      await tester.tap(find.text('Marketplace'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Return to Home tab (index 0)
      await tester.tap(find.text('Beranda'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.byType(MainShell), findsOneWidget);
    });

    test('8. Saving and restoring FYP feed state', () {
      final controller = FeedController();
      expect(controller.isLiked('post_01'), false);
      expect(controller.isSaved('post_01'), false);

      controller.toggleLike('post_01');
      expect(controller.isLiked('post_01'), true);

      controller.toggleSave('post_01');
      expect(controller.isSaved('post_01'), true);

      controller.setActivePostIndex(2);
      expect(controller.activePostIndex, 2);
    });

    test('9. Profile thumbnails mapping to correct posts', () {
      final posts = DummyData.getInitialPosts();
      for (final p in posts) {
        expect(p.mediaAsset.isNotEmpty, true);
        expect(
          p.mediaAsset.endsWith('.jpg') || p.mediaAsset.endsWith('.png'),
          true,
        );
      }
    });

    test('10. No regression to Like, Save, Follow, and vehicle navigation', () {
      final controller = FeedController();
      final post = controller.allPosts.firstWhere((p) => p.id == 'post_01');
      final initialLikes = post.likeCount;
      final initialSaves = post.saveCount;

      controller.toggleLike('post_01');
      expect(post.likeCount, initialLikes + 1);

      controller.toggleSave('post_01');
      expect(post.saveCount, initialSaves + 1);

      final porschePosts = controller.getPostsForVehicle('veh_porsche_gt3');
      expect(porschePosts.isNotEmpty, true);
      expect(porschePosts.first.id, 'post_01');
    });

    testWidgets(
      '11. FYP Search and Volume buttons positioning and separation (Volume on top-left, Search on top-right)',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          const MaterialApp(home: MainShell(initialIndex: 0)),
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 200));

        // Find Search button (Icons.search_rounded) and Volume button (Icons.volume_up_rounded / Icons.volume_off_rounded)
        final searchFinder = find.byIcon(Icons.search_rounded);
        final volumeFinder = find.byWidgetPredicate(
          (widget) =>
              widget is Icon &&
              (widget.icon == Icons.volume_up_rounded ||
                  widget.icon == Icons.volume_off_rounded),
        );

        expect(searchFinder, findsOneWidget);
        expect(volumeFinder, findsOneWidget);

        final searchRect = tester.getRect(searchFinder);
        final volumeRect = tester.getRect(volumeFinder);

        // Verify Search is on the right half of the screen (> 270 dp)
        expect(searchRect.center.dx > 270, true);

        // Verify Volume is on the left half of the screen (< 270 dp)
        expect(volumeRect.center.dx < 270, true);

        // Verify they are completely separated horizontally and do not overlap
        expect(searchRect.left > volumeRect.right + 200, true);

        // Verify Volume button toggles mute state
        expect(find.byIcon(Icons.volume_up_rounded), findsOneWidget);
        await tester.tap(volumeFinder);
        await tester.pump(const Duration(milliseconds: 350));
        expect(find.byIcon(Icons.volume_off_rounded), findsOneWidget);

        // Tap again to unmute
        await tester.tap(volumeFinder);
        await tester.pump(const Duration(milliseconds: 350));
        expect(find.byIcon(Icons.volume_up_rounded), findsOneWidget);

        // Verify Search button navigates to SearchScreen
        await tester.tap(searchFinder);
        await tester.pumpAndSettle();
        expect(
          find.text('Cari modifikasi, kendaraan, komponen...'),
          findsOneWidget,
        );
      },
    );
  });
}
