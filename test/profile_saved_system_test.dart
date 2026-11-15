import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:autoverse/core/theme/app_theme.dart';
import 'package:autoverse/data/vehicles_data.dart';
import 'package:autoverse/features/home/state/feed_controller.dart';
import 'package:autoverse/features/marketplace/presentation/screens/product_detail_screen.dart';
import 'package:autoverse/features/marketplace/state/marketplace_controller.dart';
import 'package:autoverse/features/profile/presentation/screens/my_profile_screen.dart';
import 'package:autoverse/features/profile/state/saved_items_controller.dart';
import 'package:autoverse/features/showcase/presentation/screens/featured_vehicle_showcase_screen.dart';
import 'package:autoverse/features/showcase/presentation/widgets/showcase_build_posts_section.dart';

void main() {
  group('Phase 4: SavedItemsController Unit Tests', () {
    late FeedController feedController;
    late MarketplaceController marketplaceController;
    late SavedItemsController savedController;

    setUp(() {
      feedController = FeedController();
      marketplaceController = MarketplaceController();
      savedController = SavedItemsController(
        feedController: feedController,
        marketplaceController: marketplaceController,
      );
    });

    tearDown(() {
      savedController.dispose();
      feedController.dispose();
      marketplaceController.dispose();
    });

    test('Initial saved items synchronization with feed and marketplace', () {
      expect(savedController.savedPostsCount, greaterThan(0));
      expect(savedController.savedProductsCount, greaterThan(0));
      expect(savedController.savedVehiclesCount, 1);
    });

    test('Vehicle save and unsave toggle with duplicate prevention', () {
      // Clear Porsche first
      savedController.unsaveVehicle('veh_porsche_gt3');
      expect(savedController.isVehicleSaved('veh_porsche_gt3'), isFalse);
      expect(savedController.savedVehiclesCount, 0);

      // Save
      savedController.saveVehicle('veh_porsche_gt3');
      expect(savedController.isVehicleSaved('veh_porsche_gt3'), isTrue);
      expect(savedController.savedVehiclesCount, 1);

      // Attempt to save again shouldn't duplicate
      savedController.saveVehicle('veh_porsche_gt3');
      expect(savedController.savedVehiclesCount, 1);

      // Toggle save
      savedController.toggleSaveVehicle('veh_porsche_gt3');
      expect(savedController.isVehicleSaved('veh_porsche_gt3'), isFalse);
      expect(savedController.savedVehiclesCount, 0);
    });

    test('Unsaving post immediately reflects in SavedItemsController', () {
      final initialCount = savedController.savedPostsCount;
      final firstSaved = savedController.savedPosts.first;

      savedController.unsavePost(firstSaved.id);
      expect(savedController.savedPostsCount, initialCount - 1);
      expect(savedController.isPostSaved(firstSaved.id), isFalse);
    });

    test('Unsaving product immediately reflects in SavedItemsController', () {
      final initialCount = savedController.savedProductsCount;
      final firstProduct = savedController.savedProducts.first;

      savedController.unsaveProduct(firstProduct.id);
      expect(savedController.savedProductsCount, initialCount - 1);
      expect(savedController.isProductSaved(firstProduct.id), isFalse);
    });
  });

  group('Phase 3: Profile Posts Grid View Counters', () {
    testWidgets(
      'Profile posts grid displays view count with eye icon and no like icons',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        final feedController = FeedController();

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: MyProfileScreen(feedController: feedController),
          ),
        );
        await tester.pumpAndSettle();

        // Posts tab is active by default
        expect(find.text('Postingan'), findsWidgets);

        // Eye icons must be present in the grid for view counters
        expect(find.byIcon(Icons.visibility_outlined), findsWidgets);

        // Like icons (favorite/favorite_border) must NOT appear in the profile post grid
        expect(find.byIcon(Icons.favorite), findsNothing);
        expect(find.byIcon(Icons.favorite_border), findsNothing);
      },
    );
  });

  group('Phase 4: Unified Saved System in Profile Screen', () {
    testWidgets(
      'Saved tab displays 3 chips (Postingan, Marketplace, Kendaraan) with source-aware navigation',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        final feedController = FeedController();
        final marketplaceController = MarketplaceController();
        final savedController = SavedItemsController(
          feedController: feedController,
          marketplaceController: marketplaceController,
        );

        // Ensure a vehicle is saved
        savedController.saveVehicle('veh_porsche_gt3');

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: MyProfileScreen(
              feedController: feedController,
              marketplaceController: marketplaceController,
              savedController: savedController,
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Switch to Tersimpan (Saved) tab
        await tester.tap(find.text('Tersimpan'));
        await tester.pumpAndSettle();

        // Verify category chips exist
        expect(find.text('Postingan'), findsWidgets);
        expect(find.text('Marketplace'), findsOneWidget);
        expect(find.text('Kendaraan'), findsOneWidget);

        // Default category is Postingan
        expect(savedController.selectedCategory, SavedCategory.posts);

        // Switch to Marketplace category
        await tester.tap(find.text('Marketplace'));
        await tester.pumpAndSettle();
        expect(savedController.selectedCategory, SavedCategory.marketplace);

        // Tap on first saved product to open ProductDetailScreen
        final firstProductName = savedController.savedProducts.first.name;
        await tester.tap(find.text(firstProductName));
        await tester.pumpAndSettle();
        expect(find.byType(ProductDetailScreen), findsOneWidget);

        // Back to profile
        Navigator.pop(tester.element(find.byType(ProductDetailScreen)));
        await tester.pumpAndSettle();

        // Switch to Kendaraan category
        await tester.tap(find.text('Kendaraan'));
        await tester.pumpAndSettle();
        expect(savedController.selectedCategory, SavedCategory.vehicles);

        // Tap on saved vehicle card to open FeaturedVehicleShowcaseScreen
        final savedVehicle = savedController.savedVehicles.first;
        await tester.tap(find.text(savedVehicle.displayName));
        await tester.pumpAndSettle();
        expect(find.byType(FeaturedVehicleShowcaseScreen), findsOneWidget);
      },
    );

    testWidgets(
      'Unsaving item directly from saved tab removes it and updates empty state',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        final feedController = FeedController();
        final marketplaceController = MarketplaceController();
        final savedController = SavedItemsController(
          feedController: feedController,
          marketplaceController: marketplaceController,
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: MyProfileScreen(
              feedController: feedController,
              marketplaceController: marketplaceController,
              savedController: savedController,
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Switch to Tersimpan tab
        await tester.tap(find.text('Tersimpan'));
        await tester.pumpAndSettle();

        // Postingan category
        expect(savedController.savedPosts.isNotEmpty, isTrue);

        // Tap bookmark icon to unsave the item
        final unsaveButton = find.byIcon(Icons.bookmark_rounded).first;
        await tester.tap(unsaveButton);
        await tester.pumpAndSettle();

        // If all posts unsaved, empty state message shows
        if (savedController.savedPostsCount == 0) {
          expect(find.text('Belum ada postingan tersimpan.'), findsOneWidget);
        }
      },
    );
  });

  group('Phase 2: Vehicle Modification & Showcase Verification', () {
    testWidgets(
      'View Full Build Timeline button is completely removed from ShowcaseBuildPostsSection',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        final feedController = FeedController();
        final porsche = VehiclesData.getAdityaGarageVehicles().first;
        final posts = feedController.getPostsForVehicle(porsche.id);

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: Scaffold(
              body: SingleChildScrollView(
                child: ShowcaseBuildPostsSection(linkedPosts: posts),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Verify header in Indonesian
        expect(find.text('POSTINGAN MODIFIKASI'), findsOneWidget);
        expect(find.text('Catatan Modifikasi Terkini'), findsOneWidget);

        // Verify the broken timeline button is completely gone
        expect(find.text('View Full Build Timeline'), findsNothing);
        expect(find.text('Timeline lengkap akan segera hadir'), findsNothing);
      },
    );

    testWidgets(
      'FeaturedVehicleShowcaseScreen vehicle bookmark saves to SavedItemsController',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        final feedController = FeedController();
        final marketplaceController = MarketplaceController();
        final savedController = SavedItemsController(
          feedController: feedController,
          marketplaceController: marketplaceController,
        );
        final porsche = VehiclesData.getAdityaGarageVehicles().first;

        // Ensure unsaved initially for test
        savedController.unsaveVehicle(porsche.id);

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: FeaturedVehicleShowcaseScreen(
              vehicle: porsche,
              savedController: savedController,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(savedController.isVehicleSaved(porsche.id), isFalse);

        // Tap vehicle bookmark button in app bar
        await tester.tap(find.byIcon(Icons.bookmark_outline));
        await tester.pumpAndSettle();

        expect(savedController.isVehicleSaved(porsche.id), isTrue);
        expect(find.byIcon(Icons.bookmark), findsOneWidget);

        // Tap again to unbookmark
        await tester.tap(find.byIcon(Icons.bookmark));
        await tester.pumpAndSettle();

        expect(savedController.isVehicleSaved(porsche.id), isFalse);
        expect(find.byIcon(Icons.bookmark_outline), findsOneWidget);
      },
    );
  });
}
