import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/product_model.dart';
import '../../../../features/marketplace/state/marketplace_controller.dart';
import '../../../../features/messages/state/messages_controller.dart';
import 'product_detail_screen.dart';
import 'create_listing_screen.dart';

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
  late final TextEditingController _searchCtrl;
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController(text: widget.controller.searchQuery);
  }

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
                          child: Text('Marketplace',
                              style: AppTypography.headlineH1
                                  .copyWith(letterSpacing: -0.5)),
                        ),
                        _iconButton(
                          icon: Icons.tune_rounded,
                          isActive: hasFilters,
                          onTap: () =>
                              setState(() => _showFilters = !_showFilters),
                          tooltip: 'Filters',
                        ),
                        const SizedBox(width: 10),
                        _iconButton(
                          icon: Icons.add_circle_outline_rounded,
                          onTap: _openCreateListing,
                          tooltip: 'List a Part',
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
                        style: AppTypography.body
                            .copyWith(color: AppColors.iceWhite),
                        decoration: InputDecoration(
                          hintText: 'Search parts, brands, vehicles...',
                          hintStyle: AppTypography.body
                              .copyWith(color: AppColors.mutedSteel),
                          prefixIcon: const Icon(Icons.search_rounded,
                              color: AppColors.mutedSteel, size: 20),
                          suffixIcon: _searchCtrl.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    _searchCtrl.clear();
                                    widget.controller.setSearchQuery('');
                                  },
                                  child: const Icon(Icons.close,
                                      color: AppColors.titanium, size: 18),
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        onChanged: widget.controller.setSearchQuery,
                      ),
                    ),
                  ),
                ),

                // ── Expandable Filter Panel ──
                if (_showFilters)
                  SliverToBoxAdapter(
                    child: _FilterPanel(controller: widget.controller),
                  ),

                // ── Category Shortcuts ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 90,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        children: widget.controller.categories
                            .where((c) => c != 'All')
                            .map((cat) => _CategoryChip(
                                  label: cat,
                                  icon: _categoryIcon(cat),
                                  isSelected:
                                      widget.controller.selectedCategory ==
                                          cat,
                                  onTap: () =>
                                      widget.controller.setCategory(
                                          widget.controller.selectedCategory ==
                                                  cat
                                              ? 'All'
                                              : cat),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),

                // ── Active Filter Chips Row ──
                if (hasFilters)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Row(
                        children: [
                          Text('Filters active',
                              style: AppTypography.caption.copyWith(
                                  color: AppColors.performanceLime,
                                  fontWeight: FontWeight.w600)),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              widget.controller.clearFilters();
                              _searchCtrl.clear();
                            },
                            child: Text('Clear all',
                                style: AppTypography.caption
                                    .copyWith(color: AppColors.titanium)),
                          ),
                        ],
                      ),
                    ),
                  ),

                // ── Featured Parts (only when no search/filter active) ──
                if (!hasFilters && featured.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                      child: Text('Featured Parts',
                          style: AppTypography.headlineH3),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 220,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        separatorBuilder: (ctx, idx) =>
                            const SizedBox(width: 12),
                        itemCount: featured.length,
                        itemBuilder: (ctx, i) => _FeaturedCard(
                          product: featured[i],
                          onTap: () => _openProduct(featured[i]),
                        ),
                      ),
                    ),
                  ),
                ],

                // ── Products Section Header ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 2),
                    child: Row(
                      children: [
                        Text(
                          hasFilters
                              ? '${products.length} Result${products.length == 1 ? '' : 's'}'
                              : 'All Parts & Listings',
                          style: AppTypography.headlineH3,
                        ),
                        const Spacer(),
                        // Sort dropdown
                        GestureDetector(
                          onTap: () => _showSortSheet(context),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(_sortLabel(),
                                  style: AppTypography.caption.copyWith(
                                      color: AppColors.titanium)),
                              const SizedBox(width: 4),
                              const Icon(Icons.sort_rounded,
                                  size: 16, color: AppColors.titanium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Product List ──
                products.isEmpty
                    ? SliverFillRemaining(
                        hasScrollBody: false,
                        child: _EmptyState(
                          onClear: () {
                            widget.controller.clearFilters();
                            _searchCtrl.clear();
                          },
                        ),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (ctx, i) => Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 12),
                              child: _ProductListCard(
                                product: products[i],
                                onTap: () => _openProduct(products[i]),
                                onToggleSave: () => widget.controller
                                    .toggleSave(products[i].id),
                              ),
                            ),
                            childCount: products.length,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _sortLabel() {
    switch (widget.controller.sortOrder) {
      case MarketplaceSortOrder.priceLowToHigh:
        return 'Price: Low → High';
      case MarketplaceSortOrder.priceHighToLow:
        return 'Price: High → Low';
      case MarketplaceSortOrder.newest:
        return 'Newest';
    }
  }

  void _showSortSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.carbon,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          border: Border(top: BorderSide(color: AppColors.steel)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sort by', style: AppTypography.headlineH3),
              const SizedBox(height: 16),
              ...MarketplaceSortOrder.values.map(
                (order) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(_sortOrderLabel(order),
                      style: AppTypography.body.copyWith(
                          color: widget.controller.sortOrder == order
                              ? AppColors.performanceLime
                              : AppColors.iceWhite)),
                  trailing: widget.controller.sortOrder == order
                      ? const Icon(Icons.check,
                          color: AppColors.performanceLime, size: 18)
                      : null,
                  onTap: () {
                    widget.controller.setSortOrder(order);
                    Navigator.pop(ctx);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _sortOrderLabel(MarketplaceSortOrder o) {
    switch (o) {
      case MarketplaceSortOrder.newest:
        return 'Newest First';
      case MarketplaceSortOrder.priceLowToHigh:
        return 'Price: Low to High';
      case MarketplaceSortOrder.priceHighToLow:
        return 'Price: High to Low';
    }
  }

  Widget _iconButton({
    required IconData icon,
    VoidCallback? onTap,
    bool isActive = false,
    String? tooltip,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.performanceLime.withValues(alpha: 0.15)
              : AppColors.carbon,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isActive ? AppColors.performanceLime : AppColors.steel),
        ),
        child: Icon(icon,
            size: 20,
            color: isActive ? AppColors.performanceLime : AppColors.titanium),
      ),
    );
  }

  IconData _categoryIcon(String cat) {
    switch (cat) {
      case 'Engine':
        return Icons.settings_rounded;
      case 'Exhaust':
        return Icons.air_rounded;
      case 'Wheels':
        return Icons.radio_button_checked_rounded;
      case 'Suspension':
        return Icons.compress_rounded;
      case 'Brakes':
        return Icons.pan_tool_rounded;
      case 'Exterior':
        return Icons.directions_car_rounded;
      default:
        return Icons.category_rounded;
    }
  }
}

// ── Filter Panel ──────────────────────────────────────────────────────────────
class _FilterPanel extends StatelessWidget {
  final MarketplaceController controller;
  const _FilterPanel({required this.controller});

  @override
  Widget build(BuildContext context) {
    final compatOptions = ['', 'Porsche 911', 'Mazda RX-7', 'Honda Civic Type R'];

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.carbon,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.steel),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Vehicle Compatibility',
              style: AppTypography.caption.copyWith(
                  color: AppColors.titanium, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: compatOptions.map((opt) {
              final isSelected = controller.compatibilityFilter == opt;
              final label = opt.isEmpty ? 'All Vehicles' : opt;
              return GestureDetector(
                onTap: () => controller.setCompatibilityFilter(opt),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.performanceLime.withValues(alpha: 0.15)
                        : AppColors.graphite,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: isSelected
                            ? AppColors.performanceLime
                            : AppColors.steel),
                  ),
                  child: Text(label,
                      style: AppTypography.caption.copyWith(
                          color: isSelected
                              ? AppColors.performanceLime
                              : AppColors.iceWhite,
                          fontWeight: FontWeight.w600)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ── Category Chip ─────────────────────────────────────────────────────────────
class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.performanceLime.withValues(alpha: 0.18)
                    : AppColors.carbon,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: isSelected
                        ? AppColors.performanceLime
                        : AppColors.steel,
                    width: isSelected ? 1.5 : 1),
              ),
              child: Icon(icon,
                  size: 24,
                  color: isSelected
                      ? AppColors.performanceLime
                      : AppColors.titanium),
            ),
            const SizedBox(height: 6),
            Text(label,
                style: AppTypography.micro.copyWith(
                    color: isSelected
                        ? AppColors.performanceLime
                        : AppColors.titanium,
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

// ── Featured Card (horizontal scroll) ────────────────────────────────────────
class _FeaturedCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const _FeaturedCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.carbon,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.steel),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                product.imageAsset,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stk) => Container(
                  color: AppColors.graphite,
                  child: const Icon(Icons.directions_car,
                      size: 36, color: AppColors.steel),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.brand,
                      style: AppTypography.micro.copyWith(
                          color: AppColors.performanceLime,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5)),
                  const SizedBox(height: 2),
                  Text(product.name,
                      style: AppTypography.caption.copyWith(
                          color: AppColors.iceWhite,
                          fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(product.formattedPrice,
                      style: AppTypography.caption.copyWith(
                          color: AppColors.performanceLime,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Product List Card ─────────────────────────────────────────────────────────
class _ProductListCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  final VoidCallback onToggleSave;

  const _ProductListCard({
    required this.product,
    required this.onTap,
    required this.onToggleSave,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.carbon,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.steel),
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                product.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stk) => Container(
                  color: AppColors.graphite,
                  child: const Icon(Icons.directions_car,
                      size: 36, color: AppColors.steel),
                ),
              ),
            ),

            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.graphite,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(product.category,
                              style: AppTypography.micro.copyWith(
                                  color: AppColors.titanium)),
                        ),
                        if (product.condition == 'Used') ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.warning.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('Used',
                                style: AppTypography.micro.copyWith(
                                    color: AppColors.warning,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                        if (product.isNewListing) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.performanceLime
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('New Listing',
                                style: AppTypography.micro.copyWith(
                                    color: AppColors.performanceLime,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(product.name,
                        style: AppTypography.bodyStrong
                            .copyWith(fontSize: 13),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(product.brand,
                        style: AppTypography.caption
                            .copyWith(color: AppColors.titanium)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Text(product.formattedPrice,
                              style: AppTypography.bodyStrong.copyWith(
                                  color: AppColors.performanceLime,
                                  fontSize: 13)),
                        ),
                        GestureDetector(
                          onTap: onToggleSave,
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              product.isSaved
                                  ? Icons.bookmark_rounded
                                  : Icons.bookmark_border_rounded,
                              size: 20,
                              color: product.isSaved
                                  ? AppColors.performanceLime
                                  : AppColors.titanium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(product.sellerName,
                        style: AppTypography.micro.copyWith(
                            color: AppColors.mutedSteel)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Empty State ───────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final VoidCallback onClear;
  const _EmptyState({required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off_rounded,
                size: 54, color: AppColors.mutedSteel),
            const SizedBox(height: 16),
            Text('No parts found',
                style: AppTypography.headlineH3
                    .copyWith(color: AppColors.titanium)),
            const SizedBox(height: 8),
            Text('Try different keywords or clear all filters.',
                style: AppTypography.body.copyWith(color: AppColors.mutedSteel),
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: onClear,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.graphite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.steel),
                ),
                child: Text('Clear Filters',
                    style: AppTypography.bodyStrong
                        .copyWith(color: AppColors.iceWhite)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

