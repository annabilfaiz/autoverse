import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/post_model.dart';
import '../../state/feed_controller.dart';
import 'content_overlay.dart';
import 'right_action_rail.dart';

class VideoFeedItem extends StatefulWidget {
  final PostModel post;
  final FeedController controller;
  final bool isCurrentPost;
  final bool isActiveTab;
  final VoidCallback onProfileTap;
  final VoidCallback onVehicleTap;

  const VideoFeedItem({
    super.key,
    required this.post,
    required this.controller,
    this.isCurrentPost = true,
    this.isActiveTab = true,
    required this.onProfileTap,
    required this.onVehicleTap,
  });

  @override
  State<VideoFeedItem> createState() => _VideoFeedItemState();
}

class _VideoFeedItemState extends State<VideoFeedItem>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  VideoPlayerController? _videoPlayerController;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _isPlaying = true;
  bool _isMuted = false;
  bool _showHeartAnimation = false;
  late final AnimationController _heartAnimController;
  late final Animation<double> _heartScale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _heartAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _heartScale =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 40),
          TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 20),
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 40),
        ]).animate(
          CurvedAnimation(
            parent: _heartAnimController,
            curve: Curves.easeInOut,
          ),
        );

    _heartAnimController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showHeartAnimation = false;
        });
      }
    });

    if (widget.post.videoAsset != null && widget.post.videoAsset!.isNotEmpty) {
      _initVideoController();
    }
  }

  void _initVideoController() {
    final assetPath = widget.post.videoAsset;
    if (assetPath == null || assetPath.isEmpty) return;

    final controller = VideoPlayerController.asset(assetPath);
    _videoPlayerController = controller;

    controller
        .initialize()
        .then((_) {
          if (!mounted) return;
          controller.setLooping(true);
          controller.setVolume(_isMuted ? 0.0 : 1.0);
          setState(() {
            _isInitialized = true;
          });
          _syncPlayback();
        })
        .catchError((err) {
          debugPrint('VideoFeedItem: error initializing $assetPath: $err');
          if (mounted) {
            setState(() {
              _hasError = true;
            });
          }
        });
  }

  void _syncPlayback() {
    if (_videoPlayerController == null || !_isInitialized) return;

    final shouldPlay = widget.isCurrentPost && widget.isActiveTab && _isPlaying;
    if (shouldPlay) {
      _videoPlayerController?.play();
    } else {
      _videoPlayerController?.pause();
    }
  }

  @override
  void didUpdateWidget(VideoFeedItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.post.videoAsset != oldWidget.post.videoAsset) {
      _videoPlayerController?.pause();
      _videoPlayerController?.dispose();
      _videoPlayerController = null;
      _isInitialized = false;
      _hasError = false;
      if (widget.post.videoAsset != null &&
          widget.post.videoAsset!.isNotEmpty) {
        _initVideoController();
      }
      return;
    }

    if (widget.isCurrentPost != oldWidget.isCurrentPost ||
        widget.isActiveTab != oldWidget.isActiveTab) {
      _syncPlayback();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _videoPlayerController?.pause();
    } else if (state == AppLifecycleState.resumed) {
      _syncPlayback();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoPlayerController?.pause();
    _videoPlayerController?.dispose();
    _videoPlayerController = null;
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
    _syncPlayback();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    _videoPlayerController?.setVolume(_isMuted ? 0.0 : 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final hasVideo = post.videoAsset != null && post.videoAsset!.isNotEmpty;
    final canRenderVideo =
        hasVideo &&
        _isInitialized &&
        !_hasError &&
        _videoPlayerController != null;

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
              if (canRenderVideo)
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoPlayerController!.value.size.width > 0
                          ? _videoPlayerController!.value.size.width
                          : 720,
                      height: _videoPlayerController!.value.size.height > 0
                          ? _videoPlayerController!.value.size.height
                          : 1280,
                      child: VideoPlayer(_videoPlayerController!),
                    ),
                  ),
                )
              else
                Image.asset(
                  post.mediaAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.carbon,
                    child: const Center(
                      child: Icon(
                        Icons.directions_car,
                        size: 64,
                        color: AppColors.steel,
                      ),
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

              // Pending Video Integration Badge (e.g. for placeholder videos)
              if (!hasVideo)
                Positioned(
                  top: 0,
                  left: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.voidBlack.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.steel.withValues(alpha: 0.6),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.video_library_outlined,
                              size: 13,
                              color: AppColors.titanium,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Video Segera Hadir',
                              style: AppTypography.micro.copyWith(
                                color: AppColors.titanium,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              // Audio Mute / Unmute Floating Toggle Button (Top-Left)
              if (hasVideo && _isInitialized)
                Positioned(
                  top: 0,
                  left: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: GestureDetector(
                        onTap: _toggleMute,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.voidBlack.withValues(alpha: 0.35),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Icon(
                            _isMuted
                                ? Icons.volume_off_rounded
                                : Icons.volume_up_rounded,
                            size: 20,
                            color: AppColors.iceWhite,
                          ),
                        ),
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
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
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
                      shadows: [Shadow(color: Colors.black, blurRadius: 16)],
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
