import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/state/feed_controller.dart';
import '../widgets/profile_garage_section.dart';
import '../widgets/profile_header_section.dart';
import '../widgets/profile_tabs_section.dart';

/// MyProfileScreen displays the user profile, automotive identity,
/// garage builds, and media posts.
class MyProfileScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  final FeedController? feedController;

  const MyProfileScreen({
    super.key,
    this.onBackToHome,
    this.feedController,
  });

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  int _selectedTab = 0; // 0: Posts, 1: Builds, 2: Saved
  late final FeedController _controller;
  late final bool _internalController;

  @override
  void initState() {
    super.initState();
    if (widget.feedController != null) {
      _controller = widget.feedController!;
      _internalController = false;
    } else {
      _controller = FeedController();
      _internalController = true;
    }
  }

  @override
  void dispose() {
    if (_internalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      body: SafeArea(
        bottom: false,
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            final authorPosts = _controller.getPostsForAuthor('@aditya_gt3');
            final totalPostCount = _controller.authorPostCount;

            return CustomScrollView(
              slivers: [
                // 1. Profile Header & Bio
                SliverToBoxAdapter(
                  child: ProfileHeaderSection(
                    totalPostCount: totalPostCount,
                    onBackToHome: widget.onBackToHome,
                  ),
                ),

                // 2. Featured Vehicle & Garage Rows
                SliverToBoxAdapter(
                  child: ProfileGarageSection(
                    feedController: _controller,
                  ),
                ),

                // 3. Dynamic Profile Tabs (Posts, Builds, Saved)
                SliverToBoxAdapter(
                  child: ProfileTabsSection(
                    selectedTab: _selectedTab,
                    onTabSelected: (index) {
                      setState(() {
                        _selectedTab = index;
                      });
                    },
                    authorPosts: authorPosts,
                    feedController: _controller,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
