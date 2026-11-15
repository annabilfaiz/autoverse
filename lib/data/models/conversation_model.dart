import 'message_model.dart';
import 'product_model.dart';

class ConversationModel {
  final String id;
  final String participantName;
  final String participantUsername;
  final String participantRole;
  final String? participantAvatar;
  int unreadCount;
  final List<MessageModel> messages;
  ProductModel? productContext;
  DateTime updatedAt;

  ConversationModel({
    required this.id,
    required this.participantName,
    required this.participantUsername,
    this.participantRole = '',
    this.participantAvatar,
    this.unreadCount = 0,
    required this.messages,
    this.productContext,
    required this.updatedAt,
  });

  MessageModel? get lastMessage =>
      messages.isNotEmpty ? messages.last : null;

  String get formattedLastMessageTime {
    if (messages.isEmpty) return '';
    final now = DateTime.now();
    final diff = now.difference(updatedAt);

    if (diff.inSeconds < 60) {
      return 'Just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d';
    } else {
      return '${updatedAt.day}/${updatedAt.month}';
    }
  }

  void addMessage(MessageModel message) {
    messages.add(message);
    updatedAt = message.timestamp;
  }
}
