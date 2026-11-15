import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:autoverse/core/theme/app_theme.dart';
import 'package:autoverse/data/models/product_model.dart';
import 'package:autoverse/data/vehicles_data.dart';
import 'package:autoverse/features/home/state/feed_controller.dart';
import 'package:autoverse/features/marketplace/presentation/screens/marketplace_home_screen.dart';
import 'package:autoverse/features/marketplace/presentation/screens/product_detail_screen.dart';
import 'package:autoverse/features/marketplace/state/marketplace_controller.dart';
import 'package:autoverse/features/messages/presentation/screens/chat_room_screen.dart';
import 'package:autoverse/features/messages/state/messages_controller.dart';
import 'package:autoverse/features/navigation/presentation/main_shell.dart';
import 'package:autoverse/features/profile/presentation/screens/my_profile_screen.dart';
import 'package:autoverse/features/showcase/presentation/screens/featured_vehicle_showcase_screen.dart';

void main() {
  group('Sprint 05: Final Integration QA Tests', () {
    testWidgets('1. Global Shell 5-Tab Persistence & Navigation', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        MaterialApp(theme: AppTheme.darkTheme, home: const MainShell()),
      );
      await tester.pump(const Duration(milliseconds: 200));

      // Verify Home tab is initially active
      expect(find.text('Untuk Anda'), findsOneWidget);

      // Navigate to Marketplace (Tab 1)
      await tester.tap(find.text('Marketplace'));
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('Komponen Unggulan'), findsOneWidget);

      // Search for Akrapovic in marketplace
      await tester.enterText(find.byType(TextField).first, 'Akrapovič');
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.textContaining('Akrapovič'), findsWidgets);

      // Navigate to Messages (Tab 3)
      await tester.tap(find.text('Pesan'));
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('Kevin Mahendra'), findsOneWidget);

      // Navigate to Profile (Tab 4)
      await tester.tap(find.text('Profil'));
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('Aditya Pratama'), findsOneWidget);

      // Switch back to Marketplace (Tab 1) - State must be preserved!
      await tester.tap(find.text('Marketplace'));
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.textContaining('Akrapovič'), findsWidgets);

      // Switch back to Home (Tab 0)
      await tester.tap(find.text('Beranda'));
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('Untuk Anda'), findsOneWidget);
    });

    testWidgets('2. Home FYP Like and Save Interactions', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = FeedController();
      final firstPost = controller.allPosts.first;
      final initialLikes = firstPost.likeCount;
      final initialSaved = firstPost.isSaved;

      controller.toggleLike(firstPost.id);
      expect(controller.isLiked(firstPost.id), true);
      expect(firstPost.likeCount, initialLikes + 1);

      controller.toggleSave(firstPost.id);
      expect(controller.isSaved(firstPost.id), !initialSaved);
    });

    testWidgets('3. Profile Tabs Switching (Posts, Builds, Saved)', (
      tester,
    ) async {
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

      // Posts tab is default
      expect(find.text('Postingan'), findsWidgets);
      expect(find.text('Modifikasi'), findsOneWidget);
      expect(find.text('Tersimpan'), findsOneWidget);

      // Tap Builds tab
      await tester.tap(find.text('Modifikasi'));
      await tester.pumpAndSettle();
      expect(find.text('Lihat Detail Kendaraan'), findsWidgets);

      // Tap Saved tab
      await tester.tap(find.text('Tersimpan'));
      await tester.pumpAndSettle();
      // post_02 is saved by default in initial dummy data
      expect(find.byIcon(Icons.bookmark_rounded), findsWidgets);

      // Untoggle save on post_02 to test empty state
      feedController.toggleSave('post_02');
      await tester.pumpAndSettle();
      expect(find.text('Belum ada postingan tersimpan.'), findsOneWidget);

      // Toggle save back on first post
      feedController.toggleSave(feedController.allPosts.first.id);
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.bookmark_rounded), findsWidgets);
    });

    testWidgets('4. Vehicle Showcase Interactive Callout Hotspots', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final porsche = VehiclesData.getAdityaGarageVehicles().first;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: FeaturedVehicleShowcaseScreen(vehicle: porsche),
        ),
      );
      await tester.pumpAndSettle();

      // Verify callout hotspot exists and tap it
      expect(find.text('BBS FI-R Monobloc 20"'), findsWidgets);
      await tester.tap(find.text('BBS FI-R Monobloc 20"').first);
      await tester.pumpAndSettle();

      // Component detail sheet opens
      expect(find.text('Modifikasi Terverifikasi'), findsOneWidget);
      expect(find.text('VELG & BAN'), findsWidgets);
    });

    testWidgets(
      '5. Marketplace -> Product Detail -> Chat Seller -> Send Message Flow',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        final marketController = MarketplaceController();
        final messagesController = MessagesController();

        // 1. Render Marketplace Home
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: MarketplaceHomeScreen(
              controller: marketController,
              messagesController: messagesController,
            ),
          ),
        );
        await tester.pumpAndSettle();

        // 2. Filter by Exhaust (tap category chip)
        await tester.tap(find.text('Knalpot').first);
        await tester.pumpAndSettle();
        expect(find.textContaining('Akrapovič'), findsWidgets);

        // 3. Open Product Detail
        final product = marketController.filteredProducts.first;
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: ProductDetailScreen(
              productId: product.id,
              controller: marketController,
              messagesController: messagesController,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Hubungi Penjual'), findsOneWidget);

        // 4. Tap Chat Seller -> Opens ChatRoomScreen
        final conv = messagesController.getOrCreateSellerConversation(
          product: product,
        );
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.darkTheme,
            home: ChatRoomScreen(
              conversationId: conv.id,
              controller: messagesController,
            ),
          ),
        );
        await tester.pumpAndSettle();

        // 5. Send message
        await tester.enterText(
          find.byType(TextField),
          'Halo Kevin, apakah ada diskon?',
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.arrow_upward_rounded));
        await tester.pumpAndSettle();

        expect(find.text('Halo Kevin, apakah ada diskon?'), findsOneWidget);

        // 6. Verify message updated in conversations list
        final updatedConv = messagesController.getConversationById(conv.id);
        expect(
          updatedConv?.lastMessage?.text,
          'Halo Kevin, apakah ada diskon?',
        );
      },
    );

    testWidgets(
      '6. Create Listing -> Appears in Marketplace & Product Detail',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        final marketController = MarketplaceController();
        final initialCount = marketController.filteredProducts.length;

        final newProduct = ProductModel(
          id: 'prod_custom_turbo',
          name: 'Garrett G35-1050 Turbocharger',
          brand: 'Garrett',
          category: 'Engine',
          priceIdr: 32000000,
          sellerName: 'Aditya Pratama',
          sellerUsername: '@aditya_gt3',
          description: 'Brand new in box Garrett dual ball bearing turbo.',
          specifications: {'A/R': '0.83', 'Power Rating': '1050 HP'},
          compatibleVehicles: ['Porsche 911 GT3', 'Mazda RX-7'],
          imageAsset: 'assets/images/feed_porsche_dusk.png',
          isNewListing: true,
        );

        marketController.addListing(newProduct);
        expect(marketController.filteredProducts.length, initialCount + 1);
        expect(
          marketController.filteredProducts.first.name,
          'Garrett G35-1050 Turbocharger',
        );
        expect(marketController.getById('prod_custom_turbo')?.brand, 'Garrett');
      },
    );

    testWidgets(
      '7. Screen Rotation & Orientation Change State Retention (End-to-End)',
      (tester) async {
        // ── Step 1: Start in Portrait ──
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          MaterialApp(theme: AppTheme.darkTheme, home: const MainShell()),
        );
        await tester.pump(const Duration(milliseconds: 200));

        // ── Step 2: Like & Save initial post on Home FYP ──
        expect(find.text('Untuk Anda'), findsOneWidget);
        // Tap like button on right rail
        await tester.tap(find.byIcon(Icons.favorite_border));
        await tester.pump(const Duration(milliseconds: 100));
        expect(find.byIcon(Icons.favorite), findsOneWidget);

        // Tap save button on right rail
        await tester.tap(find.byIcon(Icons.bookmark_border_rounded).first);
        await tester.pump(const Duration(milliseconds: 100));
        expect(find.byIcon(Icons.bookmark), findsWidgets);

        // ── Step 3: Create & Publish a new post ──
        await tester.tap(find.byIcon(Icons.add_rounded));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.text('Buat di AutoVerse'), findsOneWidget);
        await tester.tap(find.text('Buat Postingan'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        // Enter caption & link vehicle
        const testCaption = 'Verifikasi Retensi State Rotasi Layar #AutoVerse';
        await tester.enterText(find.byType(TextField), testCaption);
        await tester.tap(find.textContaining('Porsche 911 GT3'));
        await tester.pump(const Duration(milliseconds: 200));

        // Publish post
        await tester.tap(find.text('Bagikan'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));

        // Assert post appears in Home feed
        expect(
          find.textContaining(testCaption, findRichText: true),
          findsOneWidget,
        );

        // ── Step 4: Send message in existing conversation ──
        await tester.tap(find.text('Pesan'));
        await tester.pump(const Duration(milliseconds: 200));
        expect(find.text('Kevin Mahendra'), findsOneWidget);

        await tester.tap(find.text('Kevin Mahendra'));
        await tester.pumpAndSettle();

        const chatText = 'Halo Kevin, cek verifikasi rotasi layar.';
        await tester.enterText(find.byType(TextField), chatText);
        await tester.pump(const Duration(milliseconds: 100));
        await tester.tap(find.byIcon(Icons.arrow_upward_rounded));
        await tester.pumpAndSettle();

        expect(find.text(chatText), findsOneWidget);

        // Pop back to conversations list
        await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 400));
        expect(find.text('Anda: $chatText'), findsOneWidget);

        // ── Step 5 & 6: Rotate Emulator to Landscape (2400 x 1080) ──
        tester.view.physicalSize = const Size(2400, 1080);
        await tester.pump(const Duration(milliseconds: 300));

        // Verify chat state in landscape
        expect(find.text('Anda: $chatText'), findsOneWidget);

        // Navigate to Profil tab in landscape
        await tester.tap(find.text('Profil'));
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.text('Aditya Pratama'), findsOneWidget);
        // Initial author post count (38) + newly published post (1) = 39 posts
        expect(find.text('39'), findsOneWidget);

        // Navigate back to Beranda in landscape
        await tester.tap(find.text('Beranda'));
        await tester.pump(const Duration(milliseconds: 300));
        expect(
          find.textContaining(testCaption, findRichText: true),
          findsOneWidget,
        );

        // ── Step 7 & 8: Rotate Back to Portrait (1080 x 2400) ──
        tester.view.physicalSize = const Size(1080, 2400);
        await tester.pump(const Duration(milliseconds: 300));

        // Verify published post on Beranda
        expect(
          find.textContaining(testCaption, findRichText: true),
          findsOneWidget,
        );

        // Navigate to Pesan in portrait and verify message
        await tester.tap(find.text('Pesan'));
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.text('Anda: $chatText'), findsOneWidget);

        // Navigate to Profil in portrait and verify post count & grid
        await tester.tap(find.text('Profil'));
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.text('39'), findsOneWidget);
        expect(find.text('Aditya Pratama'), findsOneWidget);
      },
    );
  });
}
