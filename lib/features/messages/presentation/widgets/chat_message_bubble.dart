import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/message_model.dart';

class ChatMessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool showDateHeader;

  const ChatMessageBubble({
    super.key,
    required this.message,
    this.showDateHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showDateHeader) _buildDateChip(message),
        _buildBubble(context, message),
      ],
    );
  }

  Widget _buildDateChip(MessageModel message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.carbon,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.steel.withValues(alpha: 0.6)),
          ),
          child: Text(
            '${message.timestamp.day}/${message.timestamp.month}/${message.timestamp.year}',
            style: AppTypography.micro.copyWith(
              color: AppColors.mutedSteel,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBubble(BuildContext context, MessageModel message) {
    final isMe = message.isMe;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.76,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isMe ? AppColors.carbon : AppColors.graphite,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isMe ? 16 : 4),
                bottomRight: Radius.circular(isMe ? 4 : 16),
              ),
              border: Border.all(
                color: isMe
                    ? AppColors.performanceLime.withValues(alpha: 0.35)
                    : AppColors.steel,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: AppTypography.body.copyWith(
                    color: AppColors.iceWhite,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.formattedTime,
                      style: AppTypography.micro.copyWith(
                        color: isMe
                            ? AppColors.performanceLime.withValues(alpha: 0.8)
                            : AppColors.mutedSteel,
                        fontSize: 10,
                      ),
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.done_all_rounded,
                        size: 13,
                        color: AppColors.performanceLime,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
