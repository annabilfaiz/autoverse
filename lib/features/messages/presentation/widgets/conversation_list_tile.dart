import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/conversation_model.dart';

class ConversationListTile extends StatelessWidget {
  final ConversationModel conversation;
  final VoidCallback onTap;

  const ConversationListTile({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasUnread = conversation.unreadCount > 0;
    final lastMessage = conversation.lastMessage;
    final productContext = conversation.productContext;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.steel.withValues(alpha: 0.5),
                width: 0.6,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with Online Indicator
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.carbon,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: hasUnread
                            ? AppColors.performanceLime.withValues(alpha: 0.6)
                            : AppColors.steel,
                        width: hasUnread ? 1.5 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        conversation.participantName.isNotEmpty
                            ? conversation.participantName[0].toUpperCase()
                            : 'U',
                        style: AppTypography.headlineH3.copyWith(
                          color: hasUnread
                              ? AppColors.performanceLime
                              : AppColors.iceWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.voidBlack,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),

              // Content Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Participant Header & Timestamp
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            conversation.participantName,
                            style: AppTypography.bodyStrong.copyWith(
                              color: AppColors.iceWhite,
                              fontSize: 15,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified_rounded,
                          size: 13,
                          color: AppColors.performanceLime,
                        ),
                        const Spacer(),
                        Text(
                          conversation.formattedLastMessageTime,
                          style: AppTypography.micro.copyWith(
                            color: hasUnread
                                ? AppColors.performanceLime
                                : AppColors.mutedSteel,
                            fontWeight: hasUnread
                                ? FontWeight.w700
                                : FontWeight.w400,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),

                    // Username / Role
                    Text(
                      conversation.participantUsername,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.mutedSteel,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Marketplace Product Context Indicator Chip
                    if (productContext != null) ...[
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.carbon,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.steel,
                            width: 0.8,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.storefront_rounded,
                              size: 12,
                              color: AppColors.performanceLime,
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                '${productContext.category} • ${productContext.name}',
                                style: AppTypography.micro.copyWith(
                                  color: AppColors.titanium,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 5),

                    // Last Message Preview & Unread Badge
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lastMessage != null
                                ? (lastMessage.isMe
                                      ? 'Anda: ${lastMessage.text}'
                                      : lastMessage.text)
                                : 'Belum ada pesan',
                            style: AppTypography.body.copyWith(
                              color: hasUnread
                                  ? AppColors.iceWhite
                                  : AppColors.mutedSteel,
                              fontWeight: hasUnread
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (hasUnread) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.performanceLime,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${conversation.unreadCount}',
                              style: const TextStyle(
                                color: AppColors.voidBlack,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
