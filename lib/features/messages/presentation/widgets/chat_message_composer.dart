import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ChatMessageComposer extends StatelessWidget {
  final TextEditingController controller;
  final bool canSend;
  final VoidCallback onSend;

  const ChatMessageComposer({
    super.key,
    required this.controller,
    required this.canSend,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      decoration: const BoxDecoration(
        color: AppColors.carbon,
        border: Border(
          top: BorderSide(color: AppColors.steel, width: 0.8),
        ),
      ),
      child: Row(
        children: [
          // Text input
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.voidBlack,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.steel),
              ),
              child: TextField(
                controller: controller,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                minLines: 1,
                style: AppTypography.body.copyWith(
                  color: AppColors.iceWhite,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'Type an automotive message...',
                  hintStyle: AppTypography.body.copyWith(
                    color: AppColors.mutedSteel,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Send button
          GestureDetector(
            onTap: canSend ? onSend : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: canSend
                    ? AppColors.performanceLime
                    : AppColors.graphite,
                shape: BoxShape.circle,
                border: Border.all(
                  color: canSend
                      ? AppColors.performanceLime
                      : AppColors.steel,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_upward_rounded,
                  size: 20,
                  color: canSend ? AppColors.voidBlack : AppColors.mutedSteel,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
