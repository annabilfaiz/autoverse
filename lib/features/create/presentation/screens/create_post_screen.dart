import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/post_model.dart';
import '../../../../data/models/vehicle_model.dart';
import '../../../../data/vehicles_data.dart';
import '../../../home/state/feed_controller.dart';
import '../widgets/create_post_media_picker.dart';
import '../widgets/create_post_vehicle_selector.dart';

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
    'assets/images/vehicles/vehicle_porsche_911_gt3_hero.jpg',
    'assets/images/vehicles/vehicle_mazda_rx7_fd3s_hero.jpg',
    'assets/images/vehicles/vehicle_honda_civic_type_r_fk8_hero.jpg',
    'assets/images/products/product_titanium_exhaust.jpg',
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
        _selectedVehicle = null;
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
        _errorMessage = 'Pilih foto untuk postingan modifikasi Anda.';
      });
      return;
    }

    if (caption.isEmpty) {
      setState(() {
        _errorMessage = 'Masukkan keterangan untuk postingan Anda.';
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
      timeAgo: 'Baru saja',
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
      viewCount: 1,
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
                      ? 'Postingan berhasil dibagikan ke Beranda dan showcase ${_selectedVehicle!.displayName}!'
                      : 'Postingan berhasil dibagikan ke Beranda dan profil Anda!',
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
          'Buat Postingan',
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
                          'Bagikan',
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

              // ── 1. Media Preview & Gallery Strip ──
              CreatePostMediaPicker(
                selectedMediaAsset: _selectedMediaAsset,
                mediaGallery: _mediaGallery,
                onSelectMedia: _selectMedia,
                onRemoveMedia: _removeMedia,
              ),

              const SizedBox(height: 22),

              // ── 2. Caption Composer ──
              _buildCaptionComposer(),

              const SizedBox(height: 24),

              // ── 3. Vehicle Linking Section ──
              CreatePostVehicleSelector(
                availableVehicles: _availableVehicles,
                selectedVehicle: _selectedVehicle,
                onVehicleToggled: _toggleVehicle,
                onClearVehicle: () => setState(() => _selectedVehicle = null),
              ),
            ],
          ),
        ),
      ),
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
              'KETERANGAN *',
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
                  'Bagikan modifikasi terbaru, catatan sirkuit, atau proyek garasi Anda... #Porsche #GT3 #Sentul',
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
}
