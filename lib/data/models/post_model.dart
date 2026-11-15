import 'comment_model.dart';

class PostModel {
  final String id;
  final String creatorName;
  final String creatorUsername;
  final String creatorAvatarAsset;
  final bool isVerified;
  bool isFollowing;
  final String timeAgo;

  final String caption;
  final List<String> hashtags;
  final String musicTitle;

  final String linkedVehicleName;
  final String linkedVehicleGeneration;
  final String linkedVehicleChip;
  final String? linkedVehicleId;
  final DateTime? createdAt;

  final String mediaAsset;
  final String? videoAsset;
  final bool isVideo;

  int likeCount;
  bool isLiked;

  final int viewCount;

  int commentCount;
  int saveCount;
  bool isSaved;

  int shareCount;

  final List<CommentModel> comments;

  PostModel({
    required this.id,
    required this.creatorName,
    required this.creatorUsername,
    required this.creatorAvatarAsset,
    this.isVerified = true,
    this.isFollowing = false,
    required this.timeAgo,
    required this.caption,
    required this.hashtags,
    required this.musicTitle,
    this.linkedVehicleName = '',
    this.linkedVehicleGeneration = '',
    this.linkedVehicleChip = '',
    this.linkedVehicleId,
    this.createdAt,
    required this.mediaAsset,
    this.videoAsset,
    this.isVideo = false,
    required this.likeCount,
    this.isLiked = false,
    this.viewCount = 0,
    required this.commentCount,
    required this.saveCount,
    this.isSaved = false,
    required this.shareCount,
    required this.comments,
  });

  PostModel copyWith({
    String? id,
    String? creatorName,
    String? creatorUsername,
    String? creatorAvatarAsset,
    bool? isVerified,
    bool? isFollowing,
    String? timeAgo,
    String? caption,
    List<String>? hashtags,
    String? musicTitle,
    String? linkedVehicleName,
    String? linkedVehicleGeneration,
    String? linkedVehicleChip,
    String? linkedVehicleId,
    DateTime? createdAt,
    String? mediaAsset,
    String? videoAsset,
    bool? isVideo,
    int? likeCount,
    bool? isLiked,
    int? viewCount,
    int? commentCount,
    int? saveCount,
    bool? isSaved,
    int? shareCount,
    List<CommentModel>? comments,
  }) {
    return PostModel(
      id: id ?? this.id,
      creatorName: creatorName ?? this.creatorName,
      creatorUsername: creatorUsername ?? this.creatorUsername,
      creatorAvatarAsset: creatorAvatarAsset ?? this.creatorAvatarAsset,
      isVerified: isVerified ?? this.isVerified,
      isFollowing: isFollowing ?? this.isFollowing,
      timeAgo: timeAgo ?? this.timeAgo,
      caption: caption ?? this.caption,
      hashtags: hashtags ?? this.hashtags,
      musicTitle: musicTitle ?? this.musicTitle,
      linkedVehicleName: linkedVehicleName ?? this.linkedVehicleName,
      linkedVehicleGeneration: linkedVehicleGeneration ?? this.linkedVehicleGeneration,
      linkedVehicleChip: linkedVehicleChip ?? this.linkedVehicleChip,
      linkedVehicleId: linkedVehicleId ?? this.linkedVehicleId,
      createdAt: createdAt ?? this.createdAt,
      mediaAsset: mediaAsset ?? this.mediaAsset,
      videoAsset: videoAsset ?? this.videoAsset,
      isVideo: isVideo ?? this.isVideo,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      viewCount: viewCount ?? this.viewCount,
      commentCount: commentCount ?? this.commentCount,
      saveCount: saveCount ?? this.saveCount,
      isSaved: isSaved ?? this.isSaved,
      shareCount: shareCount ?? this.shareCount,
      comments: comments ?? this.comments,
    );
  }
}
