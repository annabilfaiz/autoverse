import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:autoverse/core/theme/app_theme.dart';
import 'package:autoverse/data/models/product_model.dart';
import 'package:autoverse/features/messages/presentation/screens/chat_room_screen.dart';
import 'package:autoverse/features/messages/presentation/screens/conversations_list_screen.dart';
import 'package:autoverse/features/messages/presentation/widgets/product_reference_card.dart';
import 'package:autoverse/features/messages/state/messages_controller.dart';
import 'package:autoverse/features/navigation/presentation/main_shell.dart';

void main() {
  group('MessagesController Unit Tests', () {
    late MessagesController controller;

    setUp(() {
      controller = MessagesController();
    });

    test('Initial state contains demo automotive conversations', () {
      expect(controller.conversations.isNotEmpty, true);
      final names = controller.conversations.map((c) => c.participantName).toList();
      expect(names.contains('Kevin Mahendra'), true);
      expect(names.contains('Daniel Wijaya'), true);
      expect(names.contains('Adrian Kusuma'), true);
      expect(names.contains('Rafael Putra'), true);
    });

    test('totalUnreadCount calculates correctly across conversations', () {
      expect(controller.totalUnreadCount > 0, true);
    });

    test('getOrCreateSellerConversation reuses existing seller conversation', () {
      final initialCount = controller.conversations.length;
      final product = ProductModel(
        id: 'prod_99',
        name: 'Porsche Sport Exhaust',
        brand: 'Akrapovič',
        category: 'Exhaust',
        priceIdr: 45000000,
        sellerName: 'Kevin Mahendra',
        sellerUsername: '@ak_parts_jkt',
        description: 'Titanium exhaust',
        specifications: {},
        compatibleVehicles: ['Porsche 911 GT3'],
        imageAsset: 'assets/images/feed_porsche_dusk.png',
      );

      final conv = controller.getOrCreateSellerConversation(product: product);
      expect(controller.conversations.length, initialCount); // No duplicate!
      expect(conv.participantUsername, '@ak_parts_jkt');
      expect(conv.productContext?.id, 'prod_99');
    });

    test('getOrCreateSellerConversation creates a new conversation for unknown seller', () {
      final initialCount = controller.conversations.length;
      final newProduct = ProductModel(
        id: 'prod_new_seller',
        name: 'Custom Billet Intake Manifold',
        brand: 'Plazmaman',
        category: 'Engine',
        priceIdr: 18500000,
        sellerName: 'Billet Works Surabaya',
        sellerUsername: '@billetworks_sby',
        description: 'CNC Billet Manifold',
        specifications: {},
        compatibleVehicles: ['Toyota 2JZ-GTE'],
        imageAsset: 'assets/images/feed_rx7_track.png',
      );

      final conv = controller.getOrCreateSellerConversation(product: newProduct);
      expect(controller.conversations.length, initialCount + 1);
      expect(conv.participantName, 'Billet Works Surabaya');
      expect(conv.participantUsername, '@billetworks_sby');
      expect(conv.productContext?.id, 'prod_new_seller');
    });

    test('sendMessage sends a valid message and updates conversation', () {
      final conv = controller.conversations.first;
      final initialMsgCount = conv.messages.length;

      final success = controller.sendMessage(
        conversationId: conv.id,
        text: 'Halo bro, barang masih ready?',
      );

      expect(success, true);
      expect(conv.messages.length, initialMsgCount + 1);
      expect(conv.lastMessage?.text, 'Halo bro, barang masih ready?');
      expect(conv.lastMessage?.isMe, true);
    });

    test('sendMessage rejects empty or whitespace-only messages', () {
      final conv = controller.conversations.first;
      final initialMsgCount = conv.messages.length;

      final emptySuccess = controller.sendMessage(
        conversationId: conv.id,
        text: '',
      );
      final spaceSuccess = controller.sendMessage(
        conversationId: conv.id,
        text: '   \n  \t ',
      );

      expect(emptySuccess, false);
      expect(spaceSuccess, false);
      expect(conv.messages.length, initialMsgCount);
    });

    test('sendMessage moves updated conversation to the top of list', () {
      // Pick the last conversation
      final lastConv = controller.conversations.last;
      controller.sendMessage(
        conversationId: lastConv.id,
        text: 'Test moving to top',
      );

      expect(controller.conversations.first.id, lastConv.id);
    });

    test('markAsRead clears unread count for conversation', () {
      final unreadConv =
          controller.conversations.firstWhere((c) => c.unreadCount > 0);
      expect(unreadConv.unreadCount > 0, true);

      controller.markAsRead(unreadConv.id);
      expect(unreadConv.unreadCount, 0);
    });
  });

  group('Messages Widget Tests', () {
    testWidgets('ConversationsListScreen renders header, search, and items',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = MessagesController();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(
            body: ConversationsListScreen(controller: controller),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Pesan'), findsOneWidget);
      expect(find.text('Obrolan langsung sesama antusias & penjual komponen'), findsOneWidget);
      expect(find.text('Kevin Mahendra'), findsOneWidget);
      expect(find.text('Daniel Wijaya'), findsOneWidget);
    });

    testWidgets('ConversationsListScreen displays product context chip',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = MessagesController();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(
            body: ConversationsListScreen(controller: controller),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Kevin Mahendra has product context: Akrapovič Evolution Line
      expect(find.byIcon(Icons.storefront_rounded), findsWidgets);
    });

    testWidgets('ChatRoomScreen renders product card, messages, and composer',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = MessagesController();
      final conv = controller.conversations.firstWhere((c) => c.productContext != null);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: ChatRoomScreen(
            conversationId: conv.id,
            controller: controller,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify header
      expect(find.text(conv.participantName), findsOneWidget);

      // Verify Product Reference Card is pinned
      expect(find.byType(ProductReferenceCard), findsOneWidget);
      expect(find.text('Lihat Komponen'), findsOneWidget);

      // Verify input and send interaction
      final inputFinder = find.byType(TextField);
      expect(inputFinder, findsOneWidget);

      await tester.enterText(inputFinder, 'Bisa COD di Sentul Sirkuit?');
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_upward_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Bisa COD di Sentul Sirkuit?'), findsOneWidget);
    });

    testWidgets('Messages survive tab navigation in MainShell', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: const MainShell(),
        ),
      );
      await tester.pump(const Duration(milliseconds: 200));

      // Tab 3 is Messages
      await tester.tap(find.text('Pesan'));
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('Kevin Mahendra'), findsOneWidget);

      // Switch to Marketplace tab
      await tester.tap(find.text('Marketplace'));
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.text('Marketplace'), findsWidgets);

      // Switch back to Messages tab
      await tester.tap(find.text('Pesan'));
      await tester.pump(const Duration(milliseconds: 200));

      // State is preserved!
      expect(find.text('Kevin Mahendra'), findsOneWidget);
      expect(find.text('Daniel Wijaya'), findsOneWidget);
    });
  });
}
