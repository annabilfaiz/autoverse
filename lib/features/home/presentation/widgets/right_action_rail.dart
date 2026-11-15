import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/post_model.dart';
import '../../state/feed_controller.dart';
import 'comments_bottom_sheet.dart';

class RightActionRail extends StatefulWidget {
  final PostModel post;
  final FeedController controller;
  final VoidCallback onProfileTap;

  const RightActionRail({
    super.key,
    required this.post,
    required this.controller,
    required this.onProfileTap,
  });

  @override
  State<RightActionRail> createState() => _RightActionRailState();
}

class _RightActionRailState extends State<RightActionRail>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  void _showShareDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.carbon,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          border: Border(top: BorderSide(color: AppColors.steel)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.mutedSteel.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'Bagikan Postingan',
                style: AppTypography.headlineH3.copyWith(
                  color: AppColors.iceWhite,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _shareItem(Icons.link, 'Salin Tautan', () async {
                    Navigator.pop(ctx);
                    final postUrl = 'https://autoverse.app/p/${widget.post.id}';
                    await Clipboard.setData(ClipboardData(text: postUrl));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: const [
                              Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.performanceLime,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Tautan postingan berhasil disalin ke papan klip!',
                              ),
                            ],
                          ),
                          backgroundColor: AppColors.carbon,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: AppColors.steel),
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  }),
                  _shareItem(Icons.bookmark_add, 'Simpan', () {
                    Navigator.pop(ctx);
                    widget.controller.toggleSave(widget.post.id);
                  }),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shareItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.graphite,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.steel),
            ),
            child: Icon(icon, color: AppColors.iceWhite, size: 22),
          ),
          const SizedBox(height: 6),
          Text(label, style: AppTypography.caption.copyWith(fontSize: 11)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. Creator Avatar + Follow action
        GestureDetector(
          onTap: widget.onProfileTap,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.steel, width: 2),
                  image: DecorationImage(
                    image: AssetImage(post.creatorAvatarAsset),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: -6,
                child: GestureDetector(
                  onTap: () => widget.controller.toggleFollow(post.id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: post.isFollowing
                          ? AppColors.carbon
                          : AppColors.performanceLime,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.voidBlack,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        post.isFollowing ? Icons.check : Icons.add,
                        size: 13,
                        color: post.isFollowing
                            ? AppColors.performanceLime
                            : AppColors.voidBlack,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 2. Like Action
        _actionButton(
          icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
          color: post.isLiked ? AppColors.error : AppColors.iceWhite,
          label: _formatCount(post.likeCount),
          onTap: () => widget.controller.toggleLike(post.id),
        ),

        const SizedBox(height: 16),

        // 3. Comment Action
        _actionButton(
          icon: Icons.chat_bubble_outline_rounded,
          color: AppColors.iceWhite,
          label: _formatCount(post.commentCount),
          onTap: () =>
              CommentsBottomSheet.show(context, post, widget.controller),
        ),

        const SizedBox(height: 16),

        // 4. Save / Bookmark Action
        _actionButton(
          icon: post.isSaved ? Icons.bookmark : Icons.bookmark_border_rounded,
          color: post.isSaved ? AppColors.performanceLime : AppColors.iceWhite,
          label: _formatCount(post.saveCount),
          onTap: () => widget.controller.toggleSave(post.id),
        ),

        const SizedBox(height: 16),

        // 5. Share Action
        _actionButton(
          icon: Icons.share_rounded,
          color: AppColors.iceWhite,
          label: _formatCount(post.shareCount),
          onTap: () => _showShareDialog(context),
        ),

        const SizedBox(height: 18),

        // 6. Spinning Vinyl Audio Disc
        AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationController.value * 2 * math.pi,
              child: child,
            );
          },
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.voidBlack,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.steel, width: 2),
              gradient: const RadialGradient(
                colors: [
                  AppColors.voidBlack,
                  AppColors.carbon,
                  AppColors.graphite,
                  AppColors.voidBlack,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.performanceLime.withValues(alpha: 0.2),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
                  color: AppColors.performanceLime,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.music_note,
                  size: 9,
                  color: AppColors.voidBlack,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.voidBlack.withValues(alpha: 0.4),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Icon(icon, size: 26, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.micro.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.iceWhite,
              shadows: const [
                Shadow(
                  color: Colors.black,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
