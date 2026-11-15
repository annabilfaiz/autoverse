import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/product_model.dart';
import '../../../messages/state/messages_controller.dart';
import '../../state/marketplace_controller.dart';
import '../widgets/marketplace_category_chip.dart';
import '../widgets/marketplace_featured_card.dart';
import '../widgets/marketplace_filter_panel.dart';
import '../widgets/marketplace_product_card.dart';
import 'create_listing_screen.dart';
import 'product_detail_screen.dart';

/// MarketplaceHomeScreen presents the automotive parts catalog,
/// search field, category chips, compatibility filter, and product list.
class MarketplaceHomeScreen extends StatefulWidget {
  final MarketplaceController controller;
  final MessagesController? messagesController;

  const MarketplaceHomeScreen({
    super.key,
    required this.controller,
    this.messagesController,
  });

  @override
  State<MarketplaceHomeScreen> createState() => _MarketplaceHomeScreenState();
}

class _MarketplaceHomeScreenState extends State<MarketplaceHomeScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  bool _showFilters = false;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _openProduct(ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          productId: product.id,
          controller: widget.controller,
          messagesController: widget.messagesController,
        ),
      ),
    );
  }

  void _openCreateListing() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CreateListingScreen(controller: widget.controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final products = widget.controller.filteredProducts;
        final featured = widget.controller.featuredProducts;
        final hasFilters = widget.controller.hasActiveFilters;

        return Scaffold(
          backgroundColor: AppColors.voidBlack,
          body: SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: [
                // ── App Bar ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Marketplace',
                            style: AppTypography.headlineH1.copyWith(
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        _iconButton(
                          icon: Icons.tune_rounded,
                          isActive: hasFilters,
                          onTap: () =>
                              setState(() => _showFilters = !_showFilters),
                          tooltip: 'Filter',
                        ),
                        const SizedBox(width: 10),
                        _iconButton(
                          icon: Icons.add_circle_outline_rounded,
                          onTap: _openCreateListing,
                          tooltip: 'Jual Komponen',
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Search Bar ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.carbon,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.steel),
                      ),
                      child: TextField(
                        controller: _searchCtrl,
                        style: AppTypography.body.copyWith(
                          color: AppColors.iceWhite,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Cari komponen, merek, kendaraan...',
                          hintStyle: AppTypography.body.copyWith(
                            color: AppColors.titanium,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.titanium,
                            size: 20,
                          ),
                          suffixIcon: _searchCtrl.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: AppColors.titanium,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    _searchCtrl.clear();
                                    widget.controller.setSearchQuery('');
                                    setState(() {});
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                        onChanged: (val) {
                          widget.controller.setSearchQuery(val);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),

                // ── Category Shortcuts ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: SizedBox(
                      height: 86,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          _category(
                            'Mesin',
                            Icons.settings_outlined,
                            widget.controller.selectedCategory == 'Engine',
                            categoryKey: 'Engine',
                          ),
                          _category(
                            'Knalpot',
                            Icons.air_rounded,
                            widget.controller.selectedCategory == 'Exhaust',
                            categoryKey: 'Exhaust',
                          ),
                          _category(
                            'Velg',
                            Icons.radio_button_checked_rounded,
                            widget.controller.selectedCategory == 'Wheels',
                            categoryKey: 'Wheels',
                          ),
                          _category(
                            'Suspensi',
                            Icons.swap_vert_rounded,
                            widget.controller.selectedCategory == 'Suspension',
                            categoryKey: 'Suspension',
                          ),
                          _category(
                            'Rem',
                            Icons.front_hand_rounded,
                            widget.controller.selectedCategory == 'Brakes',
                            categoryKey: 'Brakes',
                          ),
                          _category(
                            'Eksterior',
                            Icons.directions_car_outlined,
                            widget.controller.selectedCategory == 'Exterior',
                            categoryKey: 'Exterior',
                          ),
                          _category(
                            'Interior',
                            Icons.airline_seat_recline_extra_rounded,
                            widget.controller.selectedCategory == 'Interior',
                            categoryKey: 'Interior',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── Compatibility Filter Panel (Collapsible) ──
                if (_showFilters)
                  SliverToBoxAdapter(
                    child: MarketplaceFilterPanel(
                      controller: widget.controller,
                    ),
                  ),

                // ── Featured Parts Section ──
                if (featured.isNotEmpty &&
                    !widget.controller.hasActiveFilters) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                      child: Text(
                        'Komponen Unggulan',
                        style: AppTypography.headlineH3.copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 220,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: featured.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 14),
                        itemBuilder: (_, i) => MarketplaceFeaturedCard(
                          product: featured[i],
                          onTap: () => _openProduct(featured[i]),
                        ),
                      ),
                    ),
                  ),
                ],

                // ── Section Header: All Parts & Listings ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.controller.hasActiveFilters
                              ? 'Hasil Filter (${products.length})'
                              : 'Semua Komponen',
                          style: AppTypography.headlineH3.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showSortSheet(context),
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            children: [
                              Text(
                                _sortLabel(widget.controller.sortOrder),
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.titanium,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.sort_rounded,
                                size: 16,
                                color: AppColors.titanium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Products List ──
                if (products.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _emptyState(),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: MarketplaceProductCard(
                            product: products[i],
                            onTap: () => _openProduct(products[i]),
                            onToggleSave: () =>
                                widget.controller.toggleSave(products[i].id),
                          ),
                        ),
                        childCount: products.length,
                      ),
                    ),
                  ),

                // Bottom padding for persistent nav
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _category(
    String label,
    IconData icon,
    bool isSelected, {
    String? categoryKey,
  }) {
    final key = categoryKey ?? label;
    return MarketplaceCategoryChip(
      label: label,
      icon: icon,
      isSelected: isSelected,
      onTap: () => widget.controller.setCategory(isSelected ? 'All' : key),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isActive = false,
    String? tooltip,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.performanceLime.withValues(alpha: 0.15)
              : AppColors.carbon,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? AppColors.performanceLime : AppColors.steel,
          ),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isActive ? AppColors.performanceLime : AppColors.iceWhite,
        ),
      ),
    );
  }

  void _showSortSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.carbon,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 8),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.steel,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              _sortTile(context, 'Terbaru', MarketplaceSortOrder.newest),
              _sortTile(
                context,
                'Harga: Terendah ke Tertinggi',
                MarketplaceSortOrder.priceLowToHigh,
              ),
              _sortTile(
                context,
                'Harga: Tertinggi ke Terendah',
                MarketplaceSortOrder.priceHighToLow,
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _sortTile(
    BuildContext context,
    String label,
    MarketplaceSortOrder opt,
  ) {
    final isSelected = widget.controller.sortOrder == opt;
    return ListTile(
      title: Text(
        label,
        style: AppTypography.body.copyWith(
          color: isSelected ? AppColors.performanceLime : AppColors.iceWhite,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check, color: AppColors.performanceLime)
          : null,
      onTap: () {
        widget.controller.setSortOrder(opt);
        Navigator.pop(context);
      },
    );
  }

  String _sortLabel(MarketplaceSortOrder opt) {
    switch (opt) {
      case MarketplaceSortOrder.newest:
        return 'Terbaru';
      case MarketplaceSortOrder.priceLowToHigh:
        return 'Harga Terendah';
      case MarketplaceSortOrder.priceHighToLow:
        return 'Harga Tertinggi';
    }
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 54,
              color: AppColors.mutedSteel,
            ),
            const SizedBox(height: 16),
            Text(
              'Tidak ada komponen ditemukan',
              style: AppTypography.headlineH3.copyWith(
                color: AppColors.titanium,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Coba kata kunci lain atau hapus semua filter.',
              style: AppTypography.body.copyWith(color: AppColors.mutedSteel),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _searchCtrl.clear();
                widget.controller.clearFilters();
                setState(() => _showFilters = false);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.graphite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.steel),
                ),
                child: Text(
                  'Hapus Filter',
                  style: AppTypography.bodyStrong.copyWith(
                    color: AppColors.iceWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
