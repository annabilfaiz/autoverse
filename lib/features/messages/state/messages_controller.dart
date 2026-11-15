import 'package:flutter/foundation.dart';
import '../../../data/models/conversation_model.dart';
import '../../../data/models/message_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/messages_data.dart';

class MessagesController extends ChangeNotifier {
  final List<ConversationModel> _conversations =
      MessagesData.getInitialConversations();

  List<ConversationModel> get conversations {
    final list = List<ConversationModel>.from(_conversations);
    list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return list;
  }

  int get totalUnreadCount =>
      _conversations.fold<int>(0, (sum, conv) => sum + conv.unreadCount);

  ConversationModel? getConversationById(String id) {
    try {
      return _conversations.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Opens or creates a conversation with the seller of a Marketplace product.
  /// If a conversation with that seller already exists, it is reused.
  /// The product context is attached so the chat room displays the referenced part.
  ConversationModel getOrCreateSellerConversation({
    required ProductModel product,
  }) {
    // 1. Check if conversation already exists for this seller
    final normalizedUsername = product.sellerUsername.toLowerCase();
    final normalizedName = product.sellerName.toLowerCase();

    for (final conv in _conversations) {
      if (conv.participantUsername.toLowerCase() == normalizedUsername ||
          conv.participantName.toLowerCase() == normalizedName) {
        // Reuse existing conversation and update product context
        conv.productContext = product;
        notifyListeners();
        return conv;
      }
    }

    // 2. No conversation exists, create a new one
    final newConv = ConversationModel(
      id: 'conv_seller_${DateTime.now().millisecondsSinceEpoch}',
      participantName: product.sellerName,
      participantUsername: product.sellerUsername,
      participantRole: 'Marketplace Seller • AutoVerse Verified',
      participantAvatar: null,
      unreadCount: 0,
      productContext: product,
      updatedAt: DateTime.now(),
      messages: [],
    );

    _conversations.insert(0, newConv);
    notifyListeners();
    return newConv;
  }

  /// Sends a new message in the specified conversation.
  /// Rejects empty or whitespace-only messages.
  bool sendMessage({
    required String conversationId,
    required String text,
  }) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      return false;
    }

    final conv = getConversationById(conversationId);
    if (conv == null) {
      return false;
    }

    final message = MessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      senderId: '@aditya_gt3',
      senderName: 'Aditya Pratama',
      text: trimmed,
      timestamp: DateTime.now(),
      isMe: true,
      status: MessageStatus.delivered,
    );

    conv.addMessage(message);
    notifyListeners();
    return true;
  }

  /// Clears the unread count when the user opens the conversation.
  void markAsRead(String conversationId) {
    final conv = getConversationById(conversationId);
    if (conv != null && conv.unreadCount > 0) {
      conv.unreadCount = 0;
      notifyListeners();
    }
  }
}
