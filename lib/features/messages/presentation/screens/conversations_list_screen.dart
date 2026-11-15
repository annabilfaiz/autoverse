import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/conversation_model.dart';
import '../../../../features/marketplace/state/marketplace_controller.dart';
import '../../state/messages_controller.dart';
import '../widgets/conversation_list_tile.dart';
import 'chat_room_screen.dart';

class ConversationsListScreen extends StatefulWidget {
  final MessagesController controller;
  final MarketplaceController? marketplaceController;

  const ConversationsListScreen({
    super.key,
    required this.controller,
    this.marketplaceController,
  });

  @override
  State<ConversationsListScreen> createState() =>
      _ConversationsListScreenState();
}

class _ConversationsListScreenState extends State<ConversationsListScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _filterQuery = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _openChat(ConversationModel conversation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatRoomScreen(
          conversationId: conversation.id,
          controller: widget.controller,
          marketplaceController: widget.marketplaceController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final allConversations = widget.controller.conversations;
        final filtered = _filterQuery.isEmpty
            ? allConversations
            : allConversations.where((c) {
                final q = _filterQuery.toLowerCase();
                final nameMatch = c.participantName.toLowerCase().contains(q);
                final userMatch =
                    c.participantUsername.toLowerCase().contains(q);
                final msgMatch =
                    c.lastMessage?.text.toLowerCase().contains(q) ?? false;
                final prodMatch =
                    c.productContext?.name.toLowerCase().contains(q) ?? false;
                return nameMatch || userMatch || msgMatch || prodMatch;
              }).toList();

        final unreadCount = widget.controller.totalUnreadCount;

        return Scaffold(
          backgroundColor: AppColors.voidBlack,
          body: SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: [
                // Header Bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Messages',
                                style: AppTypography.headlineH1.copyWith(
                                  letterSpacing: -0.5,
                                  color: AppColors.iceWhite,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Direct enthusiast & parts seller chats',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.mutedSteel,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (unreadCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.performanceLime
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.performanceLime
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: AppColors.performanceLime,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '$unreadCount Unread',
                                  style: AppTypography.micro.copyWith(
                                    color: AppColors.performanceLime,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // Search Bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.carbon,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.steel),
                      ),
                      child: TextField(
                        controller: _searchCtrl,
                        style: AppTypography.body.copyWith(
                          color: AppColors.iceWhite,
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search chats, sellers, or parts...',
                          hintStyle: AppTypography.body.copyWith(
                            color: AppColors.mutedSteel,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.mutedSteel,
                            size: 20,
                          ),
                          suffixIcon: _filterQuery.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    _searchCtrl.clear();
                                    setState(() => _filterQuery = '');
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: AppColors.titanium,
                                    size: 18,
                                  ),
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        onChanged: (q) => setState(() => _filterQuery = q),
                      ),
                    ),
                  ),
                ),

                // Conversation List
                if (filtered.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildEmptyState(),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 120),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final conversation = filtered[index];
                          return ConversationListTile(
                            conversation: conversation,
                            onTap: () => _openChat(conversation),
                          );
                        },
                        childCount: filtered.length,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.carbon,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.steel),
              ),
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                size: 28,
                color: AppColors.mutedSteel,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              _filterQuery.isNotEmpty
                  ? 'No Conversations Found'
                  : 'No Messages Yet',
              style: AppTypography.headlineH3.copyWith(
                color: AppColors.iceWhite,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _filterQuery.isNotEmpty
                  ? 'Try searching with a different name or part query.'
                  : 'Inquire about performance parts in the Marketplace or connect with local car builders.',
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
