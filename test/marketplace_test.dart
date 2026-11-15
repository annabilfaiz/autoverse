import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:autoverse/core/theme/app_theme.dart';
import 'package:autoverse/data/models/product_model.dart';
import 'package:autoverse/features/marketplace/presentation/screens/create_listing_screen.dart';
import 'package:autoverse/features/marketplace/presentation/screens/marketplace_home_screen.dart';
import 'package:autoverse/features/marketplace/presentation/screens/product_detail_screen.dart';
import 'package:autoverse/features/marketplace/state/marketplace_controller.dart';

void main() {
  group('MarketplaceController Unit Tests', () {
    late MarketplaceController controller;

    setUp(() {
      controller = MarketplaceController();
    });

    test('Initial state contains seed products', () {
      expect(controller.filteredProducts.isNotEmpty, true);
      expect(controller.selectedCategory, 'All');
      expect(controller.searchQuery, '');
      expect(controller.compatibilityFilter, '');
      expect(controller.sortOrder, MarketplaceSortOrder.newest);
    });

    test('Filter by category works', () {
      controller.setCategory('Exhaust');
      expect(controller.selectedCategory, 'Exhaust');
      for (final p in controller.filteredProducts) {
        expect(p.category, 'Exhaust');
      }
    });

    test('Search query filters by part name or brand', () {
      controller.setSearchQuery('Akrapovič');
      expect(controller.filteredProducts.isNotEmpty, true);
      for (final p in controller.filteredProducts) {
        final matches =
            p.name.toLowerCase().contains('akrapovič') ||
            p.brand.toLowerCase().contains('akrapovič');
        expect(matches, true);
      }
    });

    test('Vehicle compatibility filter matches vehicle string', () {
      controller.setCompatibilityFilter('Porsche 911');
      expect(controller.compatibilityFilter, 'Porsche 911');
      expect(controller.filteredProducts.isNotEmpty, true);
      for (final p in controller.filteredProducts) {
        final matches = p.compatibleVehicles.any(
          (v) =>
              v.toLowerCase().contains('porsche') ||
              v.toLowerCase().contains('911'),
        );
        expect(matches, true);
      }
    });

    test('Sort by price low to high and high to low', () {
      controller.setSortOrder(MarketplaceSortOrder.priceLowToHigh);
      for (var i = 0; i < controller.filteredProducts.length - 1; i++) {
        expect(
          controller.filteredProducts[i].priceIdr <=
              controller.filteredProducts[i + 1].priceIdr,
          true,
        );
      }

      controller.setSortOrder(MarketplaceSortOrder.priceHighToLow);
      for (var i = 0; i < controller.filteredProducts.length - 1; i++) {
        expect(
          controller.filteredProducts[i].priceIdr >=
              controller.filteredProducts[i + 1].priceIdr,
          true,
        );
      }
    });

    test('Clear filters resets all filters', () {
      controller.setCategory('Exhaust');
      controller.setSearchQuery('GT3');
      controller.setCompatibilityFilter('Porsche');
      expect(controller.hasActiveFilters, true);

      controller.clearFilters();
      expect(controller.selectedCategory, 'All');
      expect(controller.searchQuery, '');
      expect(controller.compatibilityFilter, '');
      expect(controller.hasActiveFilters, false);
    });

    test('Toggle save wishlist updates state', () {
      final product = controller.filteredProducts.first;
      final initialSaved = product.isSaved;
      controller.toggleSave(product.id);
      expect(controller.getById(product.id)!.isSaved, !initialSaved);
      controller.toggleSave(product.id);
      expect(controller.getById(product.id)!.isSaved, initialSaved);
    });

    test('Add listing prepends new product', () {
      final newProd = ProductModel(
        id: 'test_123',
        name: 'Custom Turbocharger Kit',
        brand: 'Garrett',
        category: 'Engine',
        priceIdr: 45000000,
        sellerName: 'Speed Shop',
        sellerUsername: '@speed_shop',
        description: 'Test turbo kit for track use',
        specifications: {'Condition': 'New'},
        compatibleVehicles: ['Toyota Supra A90', 'BMW M240i'],
        imageAsset: 'assets/images/feed_porsche_dusk.png',
        isNewListing: true,
      );

      final initialCount = controller.filteredProducts.length;
      controller.addListing(newProd);
      expect(controller.filteredProducts.length, initialCount + 1);
      expect(controller.filteredProducts.first.id, 'test_123');
    });
  });

  group('Marketplace Widget Tests', () {
    testWidgets('MarketplaceHomeScreen renders core sections', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = MarketplaceController();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(body: MarketplaceHomeScreen(controller: controller)),
        ),
      );
      await tester.pumpAndSettle();

      // Verify header
      expect(find.text('Marketplace'), findsOneWidget);

      // Verify category chips exist
      expect(find.text('Mesin'), findsWidgets);
      expect(find.text('Knalpot'), findsWidgets);
      expect(find.text('Velg'), findsWidgets);

      // Verify featured section
      expect(find.text('Komponen Unggulan'), findsOneWidget);
    });

    testWidgets('ProductDetailScreen renders product info and specifications', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = MarketplaceController();
      final product = controller.filteredProducts.first;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: ProductDetailScreen(
            productId: product.id,
            controller: controller,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(product.name), findsOneWidget);
      expect(find.text(product.formattedPrice), findsOneWidget);
      expect(find.text(product.sellerName), findsOneWidget);
      expect(find.text('Spesifikasi'), findsOneWidget);
      expect(find.text('Hubungi Penjual'), findsOneWidget);

      // Scroll to view Vehicle Compatibility
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -400));
      await tester.pumpAndSettle();
      expect(find.text('Kompatibilitas Kendaraan'), findsOneWidget);
    });

    testWidgets('CreateListingScreen validates form fields', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = MarketplaceController();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: CreateListingScreen(controller: controller),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Buat Iklan Komponen'), findsOneWidget);
      expect(find.text('Terbitkan Iklan'), findsOneWidget);

      // Scroll to and tap publish without filling fields to trigger validation
      await tester.ensureVisible(find.text('Terbitkan Iklan'));
      await tester.tap(find.text('Terbitkan Iklan'));
      await tester.pumpAndSettle();

      // Required validators triggered
      expect(find.text('Wajib diisi'), findsWidgets);
    });
  });
}
