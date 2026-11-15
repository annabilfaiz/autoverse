import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../home/presentation/screens/home_fyp_screen.dart';
import '../../home/state/feed_controller.dart';
import '../../marketplace/presentation/screens/marketplace_home_screen.dart';
import '../../marketplace/state/marketplace_controller.dart';
import '../../messages/presentation/screens/conversations_list_screen.dart';
import '../../messages/state/messages_controller.dart';
import '../../profile/presentation/screens/my_profile_screen.dart';
import 'widgets/create_action_modal.dart';
import 'widgets/global_bottom_nav_bar.dart';

/// MainShell manages the persistent 5-position bottom navigation
/// and preserves state across all tabs using an IndexedStack.
class MainShell extends StatefulWidget {
  final int initialIndex;

  const MainShell({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _currentIndex;

  // Shared controllers persisted across all tabs
  late final FeedController _feedController;
  late final MarketplaceController _marketplaceController;
  late final MessagesController _messagesController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _feedController = FeedController();
    _marketplaceController = MarketplaceController();
    _messagesController = MessagesController();
  }

  void _onTabSelected(int index) {
    if (index == 2) {
      // Center tab triggers the Create action modal
      _showCreateModal();
      return;
    }
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _showCreateModal() {
    CreateActionModal.show(
      context,
      feedController: _feedController,
      marketplaceController: _marketplaceController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      body: Stack(
        children: [
          // IndexedStack maintains all screen state without reloading
          IndexedStack(
            index: _currentIndex,
            children: [
              // 0: Home FYP
              HomeFypScreen(
                controller: _feedController,
                onOpenProfileTab: () => _onTabSelected(4),
              ),

              // 1: Marketplace
              MarketplaceHomeScreen(
                controller: _marketplaceController,
                messagesController: _messagesController,
              ),

              // 2: Create (Triggered via modal)
              const SizedBox.shrink(),

              // 3: Messages
              ConversationsListScreen(
                controller: _messagesController,
                marketplaceController: _marketplaceController,
              ),

              // 4: Profile
              MyProfileScreen(
                onBackToHome: () => _onTabSelected(0),
                feedController: _feedController,
              ),
            ],
          ),

          // Global Bottom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ListenableBuilder(
              listenable: _messagesController,
              builder: (context, _) {
                return GlobalBottomNavBar(
                  currentIndex: _currentIndex,
                  onTabSelected: _onTabSelected,
                  onCreatePressed: _showCreateModal,
                  unreadMessagesCount: _messagesController.totalUnreadCount,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
