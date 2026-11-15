import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/post_model.dart';
import '../../state/feed_controller.dart';
import 'content_overlay.dart';
import 'right_action_rail.dart';

class VideoFeedItem extends StatefulWidget {
  final PostModel post;
  final FeedController controller;
  final VoidCallback onProfileTap;
  final VoidCallback onVehicleTap;

  const VideoFeedItem({
    super.key,
    required this.post,
    required this.controller,
    required this.onProfileTap,
    required this.onVehicleTap,
  });

  @override
  State<VideoFeedItem> createState() => _VideoFeedItemState();
}

class _VideoFeedItemState extends State<VideoFeedItem>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = true;
  bool _showHeartAnimation = false;
  late final AnimationController _heartAnimController;
  late final Animation<double> _heartScale;

  @override
  void initState() {
    super.initState();
    _heartAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _heartScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 40),
    ]).animate(CurvedAnimation(
      parent: _heartAnimController,
      curve: Curves.easeInOut,
    ));

    _heartAnimController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showHeartAnimation = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _heartAnimController.dispose();
    super.dispose();
  }

  void _onDoubleTap() {
    if (!widget.post.isLiked) {
      widget.controller.toggleLike(widget.post.id);
    }
    setState(() {
      _showHeartAnimation = true;
    });
    _heartAnimController.forward(from: 0.0);
  }

  void _onSingleTap() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Background Video / Media Canvas
        GestureDetector(
          onTap: _onSingleTap,
          onDoubleTap: _onDoubleTap,
          behavior: HitTestBehavior.opaque,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                post.mediaAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.carbon,
                  child: const Center(
                    child: Icon(Icons.directions_car, size: 64, color: AppColors.steel),
                  ),
                ),
              ),

              // Top vignette gradient (for top nav legibility)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 160,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.voidBlack.withValues(alpha: 0.85),
                        AppColors.voidBlack.withValues(alpha: 0.4),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom vignette gradient (for bottom overlay & nav legibility)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 320,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.voidBlack.withValues(alpha: 0.4),
                        AppColors.voidBlack.withValues(alpha: 0.85),
                        AppColors.voidBlack,
                      ],
                      stops: const [0.0, 0.4, 0.8, 1.0],
                    ),
                  ),
                ),
              ),

              // Pause Indicator when paused
              if (!_isPlaying)
                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.voidBlack.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 44,
                      color: AppColors.iceWhite,
                    ),
                  ),
                ),

              // Double-tap heart burst animation
              if (_showHeartAnimation)
                Center(
                  child: ScaleTransition(
                    scale: _heartScale,
                    child: const Icon(
                      Icons.favorite,
                      size: 110,
                      color: AppColors.error,
                      shadows: [
                        Shadow(color: Colors.black, blurRadius: 16),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),

        // 2. Lower-Left Content Overlay & Right Action Rail
        Positioned(
          left: 16,
          right: 12,
          bottom: 90, // Above floating bottom nav
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Content on the left
              Expanded(
                child: ContentOverlay(
                  post: post,
                  onProfileTap: widget.onProfileTap,
                  onVehicleTap: widget.onVehicleTap,
                ),
              ),

              const SizedBox(width: 12),

              // Action rail on the right
              RightActionRail(
                post: post,
                controller: widget.controller,
                onProfileTap: widget.onProfileTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
