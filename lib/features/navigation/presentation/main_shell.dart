import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../home/presentation/screens/home_fyp_screen.dart';
import '../../home/state/feed_controller.dart';
import '../../marketplace/presentation/screens/marketplace_home_screen.dart';
import '../../marketplace/presentation/screens/create_listing_screen.dart';
import '../../marketplace/state/marketplace_controller.dart';
import '../../messages/presentation/screens/conversations_list_screen.dart';
import '../../messages/state/messages_controller.dart';
import '../../profile/presentation/screens/my_profile_screen.dart';
import '../../create/presentation/screens/create_post_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  late final FeedController _feedController;
  late final MarketplaceController _marketplaceController;
  late final MessagesController _messagesController;

  @override
  void initState() {
    super.initState();
    _feedController = FeedController();
    _marketplaceController = MarketplaceController();
    _messagesController = MessagesController();
  }

  @override
  void dispose() {
    _feedController.dispose();
    _marketplaceController.dispose();
    _messagesController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    if (index == 2) {
      // Index 2 is the primary center Create action
      _showCreateModal();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _showCreateModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.carbon,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          border: Border(top: BorderSide(color: AppColors.steel)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppColors.mutedSteel.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                'Create on AutoVerse',
                style: AppTypography.headlineH2.copyWith(color: AppColors.iceWhite),
              ),
              const SizedBox(height: 20),
              _createActionOption(
                icon: Icons.post_add_rounded,
                title: 'Create Post & Build Update',
                subtitle: 'Share photos, link garage builds & log upgrades',
                color: AppColors.performanceLime,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreatePostScreen(
                        feedController: _feedController,
                        onPostPublished: () => _onTabSelected(0),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _createActionOption(
                icon: Icons.directions_car,
                title: 'Add Vehicle to Garage',
                subtitle: 'Register your build and track component upgrades',
                color: AppColors.iceWhite,
                onTap: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Add vehicle flow opening...'),
                      backgroundColor: AppColors.carbon,
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _createActionOption(
                icon: Icons.storefront_rounded,
                title: 'List Automotive Part',
                subtitle: 'Sell wheels, exhausts, and performance gear',
                color: AppColors.iceWhite,
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CreateListingScreen(
                        controller: _marketplaceController,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createActionOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.graphite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.steel),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.carbon,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.bodyStrong.copyWith(color: AppColors.iceWhite)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTypography.caption.copyWith(color: AppColors.titanium, fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 18, color: AppColors.titanium),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      body: Stack(
        children: [
          // IndexedStack maintains all screen state without rebuilding/reloading
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

              // 2: Create (Handled via modal)
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

          // Global Floating Bottom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return ListenableBuilder(
      listenable: _messagesController,
      builder: (context, _) {
        final unreadCount = _messagesController.totalUnreadCount;

        return Container(
          decoration: BoxDecoration(
            color: AppColors.carbon.withValues(alpha: 0.96),
            border: const Border(
              top: BorderSide(color: AppColors.steel, width: 0.8),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // 1. Home
                  _navItem(
                    index: 0,
                    icon: Icons.home_rounded,
                    label: 'Home',
                  ),

                  // 2. Marketplace
                  _navItem(
                    index: 1,
                    icon: Icons.storefront_rounded,
                    label: 'Marketplace',
                  ),

                  // 3. Center Create Action
                  GestureDetector(
                    onTap: () => _onTabSelected(2),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.performanceLime,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x66C7F36B),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add_rounded,
                          size: 26,
                          color: AppColors.voidBlack,
                        ),
                      ),
                    ),
                  ),

                  // 4. Messages
                  _navItem(
                    index: 3,
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'Messages',
                    badgeCount: unreadCount,
                  ),

                  // 5. Profile
                  _navItem(
                    index: 4,
                    icon: Icons.person_rounded,
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _navItem({
    required int index,
    required IconData icon,
    required String label,
    int badgeCount = 0,
  }) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? AppColors.performanceLime : AppColors.titanium;

    return GestureDetector(
      onTap: () => _onTabSelected(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: 22, color: color),
                if (badgeCount > 0)
                  Positioned(
                    right: -6,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: AppColors.performanceLime,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '$badgeCount',
                        style: const TextStyle(
                          color: AppColors.voidBlack,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTypography.micro.copyWith(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.performanceLime : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
