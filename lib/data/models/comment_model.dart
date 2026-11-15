class CommentModel {
  final String id;
  final String authorName;
  final String authorUsername;
  final String authorAvatarUrl;
  final String text;
  final String timeAgo;
  int likeCount;
  bool isLiked;

  CommentModel({
    required this.id,
    required this.authorName,
    required this.authorUsername,
    required this.authorAvatarUrl,
    required this.text,
    required this.timeAgo,
    this.likeCount = 0,
    this.isLiked = false,
  });

  CommentModel copyWith({
    String? id,
    String? authorName,
    String? authorUsername,
    String? authorAvatarUrl,
    String? text,
    String? timeAgo,
    int? likeCount,
    bool? isLiked,
  }) {
    return CommentModel(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      authorUsername: authorUsername ?? this.authorUsername,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      text: text ?? this.text,
      timeAgo: timeAgo ?? this.timeAgo,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
