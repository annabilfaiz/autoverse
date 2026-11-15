import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/post_model.dart';
import '../../state/feed_controller.dart';

class CommentsBottomSheet extends StatefulWidget {
  final PostModel post;
  final FeedController controller;

  const CommentsBottomSheet({
    super.key,
    required this.post,
    required this.controller,
  });

  static void show(BuildContext context, PostModel post, FeedController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CommentsBottomSheet(post: post, controller: controller),
    );
  }

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitComment() {
    final text = _textController.text;
    if (text.trim().isNotEmpty) {
      widget.controller.addComment(widget.post.id, text);
      _textController.clear();
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final comments = widget.post.comments;

        return Container(
          height: screenHeight * 0.65 + bottomInset,
          padding: EdgeInsets.only(bottom: bottomInset),
          decoration: const BoxDecoration(
            color: AppColors.carbon,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            border: Border(top: BorderSide(color: AppColors.steel, width: 1)),
          ),
          child: Column(
            children: [
              // Drag handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 8),
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.mutedSteel.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.post.commentCount} Komentar',
                      style: AppTypography.headlineH3.copyWith(
                        fontSize: 15,
                        color: AppColors.iceWhite,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20, color: AppColors.titanium),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),

              const Divider(color: AppColors.steel, height: 1),

              // Comments list
              Expanded(
                child: comments.isEmpty
                    ? Center(
                        child: Text(
                          'Belum ada komentar. Jadilah yang pertama berkomentar!',
                          style: AppTypography.caption.copyWith(color: AppColors.mutedSteel),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        itemCount: comments.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: AppColors.graphite,
                                backgroundImage: AssetImage(comment.authorAvatarUrl),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          comment.authorName,
                                          style: AppTypography.bodyStrong.copyWith(
                                            fontSize: 13,
                                            color: AppColors.iceWhite,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          comment.timeAgo,
                                          style: AppTypography.caption.copyWith(
                                            fontSize: 11,
                                            color: AppColors.mutedSteel,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      comment.text,
                                      style: AppTypography.body.copyWith(
                                        fontSize: 13,
                                        color: AppColors.titanium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.controller.toggleCommentLike(
                                    widget.post.id,
                                    comment.id,
                                  );
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      comment.isLiked ? Icons.favorite : Icons.favorite_border,
                                      size: 16,
                                      color: comment.isLiked ? AppColors.error : AppColors.mutedSteel,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${comment.likeCount}',
                                      style: AppTypography.micro.copyWith(
                                        color: comment.isLiked ? AppColors.error : AppColors.mutedSteel,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ),

              // Comment Composer
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: AppColors.voidBlack,
                  border: Border(top: BorderSide(color: AppColors.steel, width: 1)),
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.graphite,
                        backgroundImage: AssetImage('assets/images/avatar_aditya.png'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: AppColors.carbon,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppColors.steel),
                          ),
                          child: TextField(
                            controller: _textController,
                            focusNode: _focusNode,
                            style: AppTypography.body.copyWith(color: AppColors.iceWhite),
                            decoration: InputDecoration(
                              hintText: 'Tulis komentar...',
                              hintStyle: AppTypography.body.copyWith(color: AppColors.mutedSteel),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            onSubmitted: (_) => _submitComment(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _submitComment,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: AppColors.performanceLime,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_upward,
                            size: 18,
                            color: AppColors.voidBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
