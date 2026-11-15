import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:autoverse/core/theme/app_theme.dart';
import 'package:autoverse/data/models/post_model.dart';
import 'package:autoverse/data/vehicles_data.dart';
import 'package:autoverse/features/create/presentation/screens/create_post_screen.dart';
import 'package:autoverse/features/home/state/feed_controller.dart';
import 'package:autoverse/features/navigation/presentation/main_shell.dart';
import 'package:autoverse/features/profile/presentation/screens/my_profile_screen.dart';
import 'package:autoverse/features/showcase/presentation/screens/featured_vehicle_showcase_screen.dart';

PostModel _buildTestPost({
  required String id,
  String creatorName = 'Aditya Pratama',
  String creatorUsername = '@aditya_gt3',
  String caption = 'Test caption',
  String? linkedVehicleId,
  String linkedVehicleChip = '',
  String mediaAsset =
      'assets/images/posts/video_thumbnail/post_porsche_gt3_thumbnail.jpg',
  int likeCount = 0,
  int viewCount = 0,
}) {
  return PostModel(
    id: id,
    creatorName: creatorName,
    creatorUsername: creatorUsername,
    creatorAvatarAsset: 'assets/images/avatars/avatar_aditya.png',
    timeAgo: 'Just now',
    caption: caption,
    hashtags: ['#trackday', '#porsche'],
    musicTitle: 'Original Audio - aditya_gt3',
    linkedVehicleId: linkedVehicleId,
    linkedVehicleChip: linkedVehicleChip,
    mediaAsset: mediaAsset,
    likeCount: likeCount,
    viewCount: viewCount,
    commentCount: 0,
    saveCount: 0,
    shareCount: 0,
    comments: [],
    createdAt: DateTime.now(),
  );
}

void main() {
  group('FeedController & PostModel Unit Tests', () {
    late FeedController controller;

    setUp(() {
      controller = FeedController();
    });

    test('Initial feed has seed posts and correct author post count', () {
      expect(controller.allPosts.isNotEmpty, true);
      expect(controller.authorPostCount, greaterThanOrEqualTo(38));
    });

    test(
      'addPost prepends post to top of feed and increments author count',
      () {
        final initialCount = controller.allPosts.length;
        final initialAuthorCount = controller.authorPostCount;

        final newPost = _buildTestPost(
          id: 'post_test_01',
          caption: 'Testing cold start with new titanium headers!',
          linkedVehicleId: 'veh_porsche_gt3',
          linkedVehicleChip: '🏎️ Porsche 911 GT3 (992)',
        );

        controller.addPost(newPost);

        expect(controller.allPosts.length, initialCount + 1);
        expect(controller.allPosts.first.id, 'post_test_01');
        expect(controller.authorPostCount, initialAuthorCount + 1);
      },
    );

    test(
      'getPostsForAuthor returns only posts created by specified author',
      () {
        final adityaPosts = controller.getPostsForAuthor('@aditya_gt3');
        for (final p in adityaPosts) {
          expect(p.creatorUsername, '@aditya_gt3');
        }
      },
    );

    test(
      'getPostsForVehicle returns only posts linked to specified vehicle',
      () {
        final gt3Posts = controller.getPostsForVehicle('veh_porsche_gt3');
        expect(gt3Posts.isNotEmpty, true);
        for (final p in gt3Posts) {
          expect(p.linkedVehicleId, 'veh_porsche_gt3');
        }

        final rx7Posts = controller.getPostsForVehicle('veh_mazda_rx7');
        expect(rx7Posts.isNotEmpty, true);
        for (final p in rx7Posts) {
          expect(p.linkedVehicleId, 'veh_mazda_rx7');
        }
      },
    );

    test('getPostsForVehicle does not return posts for unrelated vehicle', () {
      final nonExistentPosts = controller.getPostsForVehicle('veh_unknown_999');
      expect(nonExistentPosts.isEmpty, true);

      final newPost = _buildTestPost(
        id: 'post_gt3_exclusive',
        caption: 'PDK shift at 9,000 RPM!',
        linkedVehicleId: 'veh_porsche_gt3',
        linkedVehicleChip: '🏎️ Porsche 911 GT3 (992)',
      );
      controller.addPost(newPost);

      final civicPosts = controller.getPostsForVehicle('veh_civic_fk8');
      expect(civicPosts.any((p) => p.id == 'post_gt3_exclusive'), false);
    });

    test(
      'Post unlinked to vehicle has null linkedVehicleId and empty chip',
      () {
        final unlinkedPost = _buildTestPost(
          id: 'post_unlinked',
          caption: 'Saturday morning coffee run with the crew',
          linkedVehicleChip: '',
          linkedVehicleId: null,
        );
        controller.addPost(unlinkedPost);

        expect(
          controller
              .getPostsForVehicle('veh_porsche_gt3')
              .any((p) => p.id == 'post_unlinked'),
          false,
        );
        expect(
          controller
              .getPostsForVehicle('veh_mazda_rx7')
              .any((p) => p.id == 'post_unlinked'),
          false,
        );
        expect(
          controller
              .getPostsForVehicle('veh_civic_fk8')
              .any((p) => p.id == 'post_unlinked'),
          false,
        );
      },
    );

    test('Like and Save interactions remain functional on posts', () {
      final firstPostId = controller.allPosts.first.id;
      final initialLikes = controller.allPosts.first.likeCount;
      final initialSaved = controller.isSaved(firstPostId);

      controller.toggleLike(firstPostId);
      expect(controller.isLiked(firstPostId), true);
      expect(controller.allPosts.first.likeCount, initialLikes + 1);

      controller.toggleSave(firstPostId);
      expect(controller.isSaved(firstPostId), !initialSaved);
    });
  });

  group('CreatePostScreen Widget Tests', () {
    testWidgets('Renders CreatePostScreen with all sections', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = FeedController();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: CreatePostScreen(feedController: controller),
        ),
      );
      await tester.pumpAndSettle();

      // Top bar
      expect(find.text('Buat Postingan'), findsOneWidget);
      expect(find.text('Bagikan'), findsOneWidget);

      // Media selection preview
      expect(find.text('GALERI MEDIA'), findsOneWidget);

      // Caption composer
      expect(find.text('KETERANGAN *'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      // Vehicle linkage section
      expect(find.text('HUBUNGKAN KE KENDARAAN'), findsOneWidget);
      expect(find.textContaining('Porsche 911 GT3'), findsOneWidget);
      expect(find.textContaining('Mazda RX-7'), findsOneWidget);
      expect(find.textContaining('Civic Type R'), findsOneWidget);
    });

    testWidgets('Rejects submission with empty or whitespace-only caption', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = FeedController();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: CreatePostScreen(feedController: controller),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Share without caption
      await tester.tap(find.text('Bagikan'));
      await tester.pumpAndSettle();

      // Validation error message appears
      expect(
        find.text('Masukkan keterangan untuk postingan Anda.'),
        findsOneWidget,
      );

      // Enter only whitespace
      await tester.enterText(find.byType(TextField), '    ');
      await tester.tap(find.text('Bagikan'));
      await tester.pumpAndSettle();

      expect(
        find.text('Masukkan keterangan untuk postingan Anda.'),
        findsOneWidget,
      );
    });

    testWidgets('Allows selecting and deselecting garage vehicle', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = FeedController();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: CreatePostScreen(feedController: controller),
        ),
      );
      await tester.pumpAndSettle();

      // Select Porsche 911 GT3
      await tester.tap(find.textContaining('Porsche 911 GT3'));
      await tester.pumpAndSettle();

      // Check that "Hapus Tautan" action button appears
      expect(find.text('Hapus Tautan'), findsOneWidget);

      // Deselect by tapping Hapus Tautan
      await tester.tap(find.text('Hapus Tautan'));
      await tester.pumpAndSettle();

      expect(find.text('Hapus Tautan'), findsNothing);
    });

    testWidgets('Publishing creates a valid post and invokes callback', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = FeedController();
      bool callbackFired = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: CreatePostScreen(
            feedController: controller,
            onPostPublished: () {
              callbackFired = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Select Mazda RX-7
      await tester.tap(find.textContaining('Mazda RX-7'));
      await tester.pumpAndSettle();

      // Enter caption
      await tester.enterText(
        find.byType(TextField),
        'Apex seals renewed! Ready for Sentul hot laps.',
      );
      await tester.pumpAndSettle();

      // Tap Bagikan
      await tester.tap(find.text('Bagikan'));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(callbackFired, true);

      // FeedController now has the post at the top
      expect(
        controller.allPosts.first.caption,
        'Apex seals renewed! Ready for Sentul hot laps.',
      );
      expect(controller.allPosts.first.linkedVehicleId, 'veh_mazda_rx7');
      expect(controller.allPosts.first.linkedVehicleName, '1994 Mazda RX-7');
    });
  });

  group('Cross-Module Integration Widget Tests', () {
    testWidgets(
      'Vehicle-linked post appears in FeaturedVehicleShowcaseScreen',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        final controller = FeedController();
        final porsche = VehiclesData.getAdityaGarageVehicles().firstWhere(
          (v) => v.id == 'veh_porsche_gt3',
        );

        // Add a custom GT3 post
        final gt3Post = _buildTestPost(
          id: 'post_gt3_integration_test',
          caption: 'Akrapovič evolution full titanium exhaust installed!',
          linkedVehicleId: 'veh_porsche_gt3',
          linkedVehicleChip: '🏎️ Porsche 911 GT3 (992)',
          likeCount: 142,
        );
        controller.addPost(gt3Post);

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: FeaturedVehicleShowcaseScreen(
              vehicle: porsche,
              feedController: controller,
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Scroll down until the POSTINGAN MODIFIKASI section is visible
        await tester.scrollUntilVisible(
          find.text('POSTINGAN MODIFIKASI'),
          400,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.pumpAndSettle();

        // Verify section header and post caption are rendered
        expect(find.text('POSTINGAN MODIFIKASI'), findsOneWidget);
        expect(
          find.text('Akrapovič evolution full titanium exhaust installed!'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'Published post updates MyProfileScreen post count and posts grid',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        final controller = FeedController();
        final initialCount = controller.authorPostCount;

        final testPost = _buildTestPost(
          id: 'post_profile_test',
          caption: 'Sentul Circuit Lap Time: 1:41.22 on Cup 2R tires!',
          linkedVehicleId: 'veh_porsche_gt3',
          linkedVehicleChip: '🏎️ Porsche 911 GT3 (992)',
          likeCount: 520,
          viewCount: 1540,
        );
        controller.addPost(testPost);

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: MyProfileScreen(feedController: controller),
          ),
        );
        await tester.pumpAndSettle();

        // Post count in profile header updated
        expect(find.text('${initialCount + 1}'), findsOneWidget);

        // Verify the first item in the grid represents our post with 1.5k views
        expect(find.text('1.5k'), findsOneWidget);

        // Tap on the post item in the grid to open post detail modal
        await tester.tap(find.text('1.5k'));
        await tester.pumpAndSettle();

        // Verify detail modal opened showing full caption and stats
        expect(
          find.text('Sentul Circuit Lap Time: 1:41.22 on Cup 2R tires!'),
          findsOneWidget,
        );
        expect(find.text('520 Suka'), findsOneWidget);
      },
    );

    testWidgets(
      'MainShell Create flow navigates to CreatePostScreen and preserves state across tabs',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          MaterialApp(theme: AppTheme.darkTheme, home: const MainShell()),
        );
        await tester.pump(const Duration(milliseconds: 200));

        // Tap center Create button (Plus icon)
        await tester.tap(find.byIcon(Icons.add_rounded));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        // Modal bottom sheet opens
        expect(find.text('Buat di AutoVerse'), findsOneWidget);
        expect(find.text('Buat Postingan'), findsOneWidget);

        // Tap "Buat Postingan"
        await tester.tap(find.text('Buat Postingan'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        // CreatePostScreen opens
        expect(find.text('Buat Postingan'), findsOneWidget);
        expect(find.text('HUBUNGKAN KE KENDARAAN'), findsOneWidget);

        // Enter caption and link Porsche
        await tester.enterText(
          find.byType(TextField),
          'Full carbon bucket seats installed today.',
        );
        await tester.tap(find.textContaining('Porsche 911 GT3'));
        await tester.pump(const Duration(milliseconds: 200));

        // Share post
        await tester.tap(find.text('Bagikan'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        // Returned to Home tab with new post
        expect(
          find.textContaining(
            'Full carbon bucket seats installed today.',
            findRichText: true,
          ),
          findsOneWidget,
        );

        // Switch to Profile tab (Index 4)
        await tester.tap(find.text('Profil'));
        await tester.pump(const Duration(milliseconds: 300));

        // Profile shows updated post count and grid
        expect(find.byType(MyProfileScreen), findsOneWidget);

        // Switch back to Home tab (Index 0)
        await tester.tap(find.text('Beranda'));
        await tester.pump(const Duration(milliseconds: 300));

        // State is preserved in Home tab!
        expect(
          find.textContaining(
            'Full carbon bucket seats installed today.',
            findRichText: true,
          ),
          findsOneWidget,
        );
      },
    );
  });
}
