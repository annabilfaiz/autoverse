import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/post_model.dart';
import '../../../../data/models/vehicle_model.dart';
import '../../../../data/vehicles_data.dart';
import '../../../home/state/feed_controller.dart';

class CreatePostScreen extends StatefulWidget {
  final FeedController feedController;
  final VoidCallback? onPostPublished;

  const CreatePostScreen({
    super.key,
    required this.feedController,
    this.onPostPublished,
  });

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _captionController = TextEditingController();
  final List<VehicleModel> _availableVehicles =
      VehiclesData.getAdityaGarageVehicles();

  String? _selectedMediaAsset;
  VehicleModel? _selectedVehicle;
  bool _isPublishing = false;
  String? _errorMessage;

  // Curated automotive media assets for enthusiast post creation
  final List<String> _mediaGallery = const [
    'assets/images/feed_porsche_dusk.png',
    'assets/images/feed_rx7_track.png',
    'assets/images/feed_porsche_gt3.png',
    'assets/images/feed_porsche_911.png',
  ];

  @override
  void initState() {
    super.initState();
    // Default to first photo for quick preview, but user can clear or switch
    _selectedMediaAsset = _mediaGallery.first;
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  void _removeMedia() {
    setState(() {
      _selectedMediaAsset = null;
    });
  }

  void _selectMedia(String asset) {
    setState(() {
      _selectedMediaAsset = asset;
      _errorMessage = null;
    });
  }

  void _toggleVehicle(VehicleModel vehicle) {
    setState(() {
      if (_selectedVehicle?.id == vehicle.id) {
        _selectedVehicle = null; // Deselect
      } else {
        _selectedVehicle = vehicle;
      }
    });
  }

  List<String> _extractHashtags(String text) {
    final exp = RegExp(r'#(\w+)');
    final matches = exp.allMatches(text);
    if (matches.isEmpty) {
      return ['#AutoVerse', '#CarBuild'];
    }
    return matches.map((m) => '#${m.group(1)}').toList();
  }

  Future<void> _publishPost() async {
    final caption = _captionController.text.trim();

    if (_selectedMediaAsset == null) {
      setState(() {
        _errorMessage = 'Please select a photo for your automotive post.';
      });
      return;
    }

    if (caption.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a caption for your post.';
      });
      return;
    }

    setState(() {
      _isPublishing = true;
      _errorMessage = null;
    });

    await Future.delayed(const Duration(milliseconds: 400));

    final newPost = PostModel(
      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
      creatorName: 'Aditya Pratama',
      creatorUsername: '@aditya_gt3',
      creatorAvatarAsset: 'assets/images/avatar_aditya.png',
      isVerified: true,
      isFollowing: false,
      timeAgo: 'Just now',
      caption: caption,
      hashtags: _extractHashtags(caption),
      musicTitle: 'Original Sound - aditya_gt3',
      linkedVehicleId: _selectedVehicle?.id,
      linkedVehicleName: _selectedVehicle?.displayName ?? '',
      linkedVehicleGeneration: _selectedVehicle?.generation ?? '',
      linkedVehicleChip: _selectedVehicle != null
          ? '🏎️ ${_selectedVehicle!.displayFullName}'
          : '',
      mediaAsset: _selectedMediaAsset!,
      isVideo: false,
      likeCount: 0,
      commentCount: 0,
      saveCount: 0,
      shareCount: 0,
      comments: [],
      createdAt: DateTime.now(),
    );

    widget.feedController.addPost(newPost);
    widget.onPostPublished?.call();

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.carbon,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 90),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: AppColors.steel),
          ),
          content: Row(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.performanceLime,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _selectedVehicle != null
                      ? 'Post published to FYP and ${_selectedVehicle!.displayName} showcase!'
                      : 'Post published to FYP and your profile!',
                  style: AppTypography.body.copyWith(
                    color: AppColors.iceWhite,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasVehicle = _selectedVehicle != null;

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        backgroundColor: AppColors.carbon,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: AppColors.iceWhite,
            size: 22,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create Post',
          style: AppTypography.headlineH3.copyWith(
            color: AppColors.iceWhite,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Center(
              child: SizedBox(
                height: 34,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.performanceLime,
                    foregroundColor: AppColors.voidBlack,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _isPublishing ? null : _publishPost,
                  child: _isPublishing
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.voidBlack,
                          ),
                        )
                      : Text(
                          'Share',
                          style: AppTypography.button.copyWith(
                            color: AppColors.voidBlack,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.steel.withValues(alpha: 0.6),
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Error banner if any
              if (_errorMessage != null) ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.error.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        color: AppColors.error,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.iceWhite,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // ── 1. Media Preview Area ──
              _buildMediaPreview(),

              const SizedBox(height: 14),

              // ── Media Gallery Thumbnails ──
              _buildGallerySelector(),

              const SizedBox(height: 22),

              // ── 2. Caption Composer ──
              _buildCaptionComposer(),

              const SizedBox(height: 24),

              // ── 3. Vehicle Linking Section ──
              _buildVehicleSelector(hasVehicle),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaPreview() {
    if (_selectedMediaAsset == null) {
      return GestureDetector(
        onTap: () {
          if (_mediaGallery.isNotEmpty) {
            _selectMedia(_mediaGallery.first);
          }
        },
        child: Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.carbon,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.steel,
              width: 1.2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.graphite,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.steel),
                ),
                child: const Icon(
                  Icons.add_photo_alternate_rounded,
                  color: AppColors.performanceLime,
                  size: 26,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Select Vehicle Media',
                style: AppTypography.bodyStrong.copyWith(
                  color: AppColors.iceWhite,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tap to pick an automotive photo below',
                style: AppTypography.caption.copyWith(
                  color: AppColors.mutedSteel,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        Container(
          height: 240,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.carbon,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.steel),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            _selectedMediaAsset!,
            fit: BoxFit.cover,
            errorBuilder: (ctx, err, stk) => Container(
              color: AppColors.graphite,
              child: const Center(
                child: Icon(
                  Icons.broken_image_rounded,
                  color: AppColors.mutedSteel,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
        // Remove button
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: _removeMedia,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.voidBlack.withValues(alpha: 0.75),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.steel),
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 16,
                color: AppColors.iceWhite,
              ),
            ),
          ),
        ),
        // Photo Badge
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.voidBlack.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.steel.withValues(alpha: 0.6)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.photo_camera_rounded,
                  size: 12,
                  color: AppColors.performanceLime,
                ),
                const SizedBox(width: 4),
                Text(
                  'Automotive Photo',
                  style: AppTypography.micro.copyWith(
                    color: AppColors.iceWhite,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGallerySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'MEDIA LIBRARY',
              style: AppTypography.micro.copyWith(
                color: AppColors.mutedSteel,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                fontSize: 10,
              ),
            ),
            Text(
              '${_mediaGallery.length} Photos available',
              style: AppTypography.micro.copyWith(
                color: AppColors.mutedSteel,
                fontSize: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 64,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _mediaGallery.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final asset = _mediaGallery[index];
              final isSelected = _selectedMediaAsset == asset;

              return GestureDetector(
                onTap: () => _selectMedia(asset),
                child: Container(
                  width: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.performanceLime
                          : AppColors.steel,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        asset,
                        fit: BoxFit.cover,
                      ),
                      if (isSelected)
                        Container(
                          color: AppColors.performanceLime.withValues(alpha: 0.2),
                          child: const Center(
                            child: Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.performanceLime,
                              size: 18,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCaptionComposer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'CAPTION *',
              style: AppTypography.micro.copyWith(
                color: AppColors.mutedSteel,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                fontSize: 10,
              ),
            ),
            ListenableBuilder(
              listenable: _captionController,
              builder: (context, _) {
                final len = _captionController.text.length;
                return Text(
                  '$len / 500',
                  style: AppTypography.micro.copyWith(
                    color: len > 500 ? AppColors.error : AppColors.mutedSteel,
                    fontSize: 10,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.carbon,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.steel),
          ),
          child: TextField(
            controller: _captionController,
            maxLines: 4,
            minLines: 3,
            maxLength: 500,
            style: AppTypography.body.copyWith(
              color: AppColors.iceWhite,
              fontSize: 14,
              height: 1.4,
            ),
            decoration: InputDecoration(
              hintText:
                  'Share what is new with your build, track day telemetry, or garage project... #Porsche #GT3 #Sentul',
              hintStyle: AppTypography.body.copyWith(
                color: AppColors.mutedSteel,
                fontSize: 13,
              ),
              border: InputBorder.none,
              counterText: '',
            ),
            onChanged: (_) {
              if (_errorMessage != null) {
                setState(() => _errorMessage = null);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVehicleSelector(bool hasVehicle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'LINK TO VEHICLE',
                  style: AppTypography.micro.copyWith(
                    color: AppColors.mutedSteel,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: AppColors.graphite,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.steel),
                  ),
                  child: Text(
                    'OPTIONAL',
                    style: AppTypography.micro.copyWith(
                      color: AppColors.titanium,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            if (hasVehicle)
              GestureDetector(
                onTap: () => setState(() => _selectedVehicle = null),
                child: Text(
                  'Clear Link',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.performanceLime,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Attach this update to your signature build or garage car showcase.',
          style: AppTypography.caption.copyWith(
            color: AppColors.mutedSteel,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 12),

        // Vehicles list
        ..._availableVehicles.map((vehicle) {
          final isSelected = _selectedVehicle?.id == vehicle.id;

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _toggleVehicle(vehicle),
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.performanceLime.withValues(alpha: 0.08)
                        : AppColors.carbon,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.performanceLime
                          : AppColors.steel,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Vehicle thumbnail
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 48,
                          height: 48,
                          color: AppColors.graphite,
                          child: Image.asset(
                            vehicle.imageAsset,
                            fit: BoxFit.cover,
                            errorBuilder: (ctx, err, stk) => const Icon(
                              Icons.directions_car_rounded,
                              color: AppColors.titanium,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Vehicle details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  vehicle.displayName,
                                  style: AppTypography.bodyStrong.copyWith(
                                    color: isSelected
                                        ? AppColors.performanceLime
                                        : AppColors.iceWhite,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '(${vehicle.generation})',
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.mutedSteel,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${vehicle.nickname} • ${vehicle.status}',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.titanium,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Selection Indicator
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.performanceLime
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.performanceLime
                                : AppColors.steel,
                            width: 1.5,
                          ),
                        ),
                        child: isSelected
                            ? const Center(
                                child: Icon(
                                  Icons.check_rounded,
                                  size: 14,
                                  color: AppColors.voidBlack,
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
