import 'package:flutter/foundation.dart';

import '../../../data/dummy_data.dart';
import '../../../data/models/comment_model.dart';
import '../../../data/models/post_model.dart';

enum FeedTab { forYou, following }

class FeedController extends ChangeNotifier {
  FeedTab _activeTab = FeedTab.forYou;
  int _activePostIndex = 0;
  int _newPostsCreated = 0;
  final List<PostModel> _allPosts = DummyData.getInitialPosts();

  FeedTab get activeTab => _activeTab;
  int get activePostIndex => _activePostIndex;
  List<PostModel> get allPosts => List.unmodifiable(_allPosts);
  int get authorPostCount => 38 + _newPostsCreated;

  void addPost(PostModel post) {
    _allPosts.insert(0, post);
    _activePostIndex = 0;
    if (post.creatorUsername == '@aditya_gt3') {
      _newPostsCreated++;
    }
    notifyListeners();
  }

  List<PostModel> getPostsForVehicle(String vehicleId) {
    if (vehicleId.isEmpty) return [];
    final vLower = vehicleId.toLowerCase();
    return _allPosts.where((p) {
      if (p.linkedVehicleId != null &&
          p.linkedVehicleId!.toLowerCase() == vLower) {
        return true;
      }
      if (p.linkedVehicleName.isNotEmpty) {
        final pName = p.linkedVehicleName.toLowerCase();
        if (pName.contains(vLower) || vLower.contains(pName)) {
          return true;
        }
      }
      return false;
    }).toList();
  }

  List<PostModel> getPostsForAuthor(String username) {
    final normalized = username.toLowerCase();
    return _allPosts
        .where((p) => p.creatorUsername.toLowerCase() == normalized)
        .toList();
  }

  List<PostModel> get currentPosts {
    if (_activeTab == FeedTab.following) {
      final followingPosts = _allPosts.where((p) => p.isFollowing).toList();
      return followingPosts.isNotEmpty ? followingPosts : _allPosts;
    }
    return _allPosts;
  }

  PostModel? get currentPost {
    final posts = currentPosts;
    if (_activePostIndex >= 0 && _activePostIndex < posts.length) {
      return posts[_activePostIndex];
    }
    return posts.isNotEmpty ? posts.first : null;
  }

  void setActiveTab(FeedTab tab) {
    if (_activeTab != tab) {
      _activeTab = tab;
      _activePostIndex = 0;
      notifyListeners();
    }
  }

  void setActivePostIndex(int index) {
    if (_activePostIndex != index) {
      _activePostIndex = index;
      notifyListeners();
    }
  }

  bool isLiked(String postId) {
    final index = _allPosts.indexWhere((p) => p.id == postId);
    return index != -1 && _allPosts[index].isLiked;
  }

  bool isSaved(String postId) {
    final index = _allPosts.indexWhere((p) => p.id == postId);
    return index != -1 && _allPosts[index].isSaved;
  }

  void toggleLike(String postId) {
    final index = _allPosts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      final post = _allPosts[index];
      if (post.isLiked) {
        post.isLiked = false;
        post.likeCount = (post.likeCount - 1).clamp(0, 9999999);
      } else {
        post.isLiked = true;
        post.likeCount += 1;
      }
      notifyListeners();
    }
  }

  void toggleSave(String postId) {
    final index = _allPosts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      final post = _allPosts[index];
      if (post.isSaved) {
        post.isSaved = false;
        post.saveCount = (post.saveCount - 1).clamp(0, 9999999);
      } else {
        post.isSaved = true;
        post.saveCount += 1;
      }
      notifyListeners();
    }
  }

  void toggleFollow(String postId) {
    final index = _allPosts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      final post = _allPosts[index];
      final newStatus = !post.isFollowing;
      // Update across all posts by the same creator handle
      for (final p in _allPosts) {
        if (p.creatorUsername == post.creatorUsername) {
          p.isFollowing = newStatus;
        }
      }
      notifyListeners();
    }
  }

  void addComment(String postId, String text) {
    if (text.trim().isEmpty) return;
    final index = _allPosts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      final post = _allPosts[index];
      final newComment = CommentModel(
        id: 'c_${DateTime.now().millisecondsSinceEpoch}',
        authorName: 'You',
        authorUsername: '@auto_enthusiast',
        authorAvatarUrl: 'assets/images/avatar_aditya.png',
        text: text.trim(),
        timeAgo: 'Just now',
        likeCount: 0,
        isLiked: false,
      );
      post.comments.insert(0, newComment);
      post.commentCount += 1;
      notifyListeners();
    }
  }

  void toggleCommentLike(String postId, String commentId) {
    final postIndex = _allPosts.indexWhere((p) => p.id == postId);
    if (postIndex != -1) {
      final post = _allPosts[postIndex];
      final commentIndex = post.comments.indexWhere((c) => c.id == commentId);
      if (commentIndex != -1) {
        final comment = post.comments[commentIndex];
        if (comment.isLiked) {
          comment.isLiked = false;
          comment.likeCount = (comment.likeCount - 1).clamp(0, 999999);
        } else {
          comment.isLiked = true;
          comment.likeCount += 1;
        }
        notifyListeners();
      }
    }
  }
}
