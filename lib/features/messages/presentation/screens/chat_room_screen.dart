import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/message_model.dart';
import '../../../../features/marketplace/presentation/screens/product_detail_screen.dart';
import '../../../../features/marketplace/state/marketplace_controller.dart';
import '../../state/messages_controller.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_message_composer.dart';
import '../widgets/product_reference_card.dart';

class ChatRoomScreen extends StatefulWidget {
  final String conversationId;
  final MessagesController controller;
  final MarketplaceController? marketplaceController;

  const ChatRoomScreen({
    super.key,
    required this.conversationId,
    required this.controller,
    this.marketplaceController,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _canSend = false;

  @override
  void initState() {
    super.initState();
    // Mark messages as read after initial layout build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.controller.markAsRead(widget.conversationId);
      }
    });

    _textController.addListener(() {
      final canSend = _textController.text.trim().isNotEmpty;
      if (canSend != _canSend) {
        setState(() => _canSend = canSend);
      }
    });

    // Schedule scroll to bottom after layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom(animate: false);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom({bool animate = true}) {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (animate) {
      _scrollController.animateTo(
        maxScroll,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutQuad,
      );
    } else {
      _scrollController.jumpTo(maxScroll);
    }
  }

  void _sendMessage() {
    final text = _textController.text;
    if (text.trim().isEmpty) return;

    final success = widget.controller.sendMessage(
      conversationId: widget.conversationId,
      text: text,
    );

    if (success) {
      _textController.clear();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom(animate: true);
      });
    }
  }

  bool _shouldShowDateHeader(MessageModel prev, MessageModel current) {
    return prev.timestamp.day != current.timestamp.day ||
        prev.timestamp.month != current.timestamp.month ||
        prev.timestamp.year != current.timestamp.year;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final conversation = widget.controller.getConversationById(
          widget.conversationId,
        );

        if (conversation == null) {
          return Scaffold(
            backgroundColor: AppColors.voidBlack,
            appBar: AppBar(
              backgroundColor: AppColors.carbon,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.iceWhite,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: const Center(
              child: Text(
                'Percakapan tidak ditemukan',
                style: TextStyle(color: AppColors.titanium),
              ),
            ),
          );
        }

        final messages = conversation.messages;
        final productContext = conversation.productContext;

        return Scaffold(
          backgroundColor: AppColors.voidBlack,
          appBar: _buildAppBar(
            conversation.participantName,
            conversation.participantUsername,
            conversation.participantRole,
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Pinned Marketplace Product Reference Card
                if (productContext != null)
                  ProductReferenceCard(
                    product: productContext,
                    onTap: () {
                      if (widget.marketplaceController != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(
                              productId: productContext.id,
                              controller: widget.marketplaceController!,
                            ),
                          ),
                        );
                      }
                    },
                  ),

                // Message Thread
                Expanded(
                  child: messages.isEmpty
                      ? _buildEmptyConversation()
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final showDateHeader =
                                index == 0 ||
                                _shouldShowDateHeader(
                                  messages[index - 1],
                                  message,
                                );

                            return ChatMessageBubble(
                              message: message,
                              showDateHeader: showDateHeader,
                            );
                          },
                        ),
                ),

                // Input Composer
                ChatMessageComposer(
                  controller: _textController,
                  canSend: _canSend,
                  onSend: _sendMessage,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(String name, String username, String role) {
    return AppBar(
      backgroundColor: AppColors.carbon,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.iceWhite,
          size: 18,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          // Participant Avatar with Online Dot
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.graphite,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.steel),
                ),
                child: Center(
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : 'U',
                    style: AppTypography.headlineH3.copyWith(
                      color: AppColors.performanceLime,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.carbon, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // Name and Role
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: AppTypography.headlineH3.copyWith(
                          fontSize: 15,
                          color: AppColors.iceWhite,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified_rounded,
                      size: 14,
                      color: AppColors.performanceLime,
                    ),
                  ],
                ),
                Text(
                  username.isNotEmpty ? username : 'Aktif sekarang',
                  style: AppTypography.micro.copyWith(
                    color: AppColors.mutedSteel,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: AppColors.steel.withValues(alpha: 0.6),
          height: 1,
        ),
      ),
    );
  }

  Widget _buildEmptyConversation() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.carbon,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.steel),
              ),
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                color: AppColors.performanceLime,
                size: 26,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Mulai Percakapan',
              style: AppTypography.headlineH3.copyWith(
                color: AppColors.iceWhite,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Tanyakan ketersediaan komponen, kecocokan, atau proyek modifikasi.',
              style: AppTypography.caption.copyWith(
                color: AppColors.mutedSteel,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
