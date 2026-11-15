import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/product_model.dart';
import '../../../../features/marketplace/state/marketplace_controller.dart';
import '../../../../features/messages/presentation/screens/chat_room_screen.dart';
import '../../../../features/messages/state/messages_controller.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  final MarketplaceController controller;
  final MessagesController? messagesController;

  const ProductDetailScreen({
    super.key,
    required this.productId,
    required this.controller,
    this.messagesController,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  void _chatSeller(ProductModel product) {
    if (widget.messagesController != null) {
      final conv = widget.messagesController!.getOrCreateSellerConversation(
        product: product,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatRoomScreen(
            conversationId: conv.id,
            controller: widget.messagesController!,
            marketplaceController: widget.controller,
          ),
        ),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.carbon,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 90),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: AppColors.steel)),
          content: Row(
            children: [
              const Icon(Icons.chat_bubble_outline_rounded,
                  size: 18, color: AppColors.performanceLime),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Membuka percakapan dengan ${product.sellerName}...',
                  style: AppTypography.body.copyWith(color: AppColors.iceWhite),
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final product = widget.controller.getById(widget.productId);
        if (product == null) {
          return Scaffold(
            backgroundColor: AppColors.voidBlack,
            appBar: AppBar(backgroundColor: AppColors.voidBlack),
            body: const Center(
              child: Text('Komponen tidak ditemukan.',
                  style: TextStyle(color: AppColors.titanium)),
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.voidBlack,
          body: CustomScrollView(
            slivers: [
              // ── Hero App Bar ──
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: AppColors.voidBlack,
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.carbon.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.steel),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 16, color: AppColors.iceWhite),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () =>
                        widget.controller.toggleSave(product.id),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.carbon.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: product.isSaved
                                ? AppColors.performanceLime
                                : AppColors.steel),
                      ),
                      child: Icon(
                        product.isSaved
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        size: 18,
                        color: product.isSaved
                            ? AppColors.performanceLime
                            : AppColors.titanium,
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    product.imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stk) => Container(
                      color: AppColors.graphite,
                      child: const Icon(Icons.directions_car,
                          size: 72, color: AppColors.steel),
                    ),
                  ),
                ),
              ),

              // ── Content ──
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Brand + Category
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.performanceLime
                                .withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(product.category,
                              style: AppTypography.micro.copyWith(
                                  color: AppColors.performanceLime,
                                  fontWeight: FontWeight.w700)),
                        ),
                        if (product.condition == 'Used') ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color:
                                  AppColors.warning.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text('Bekas',
                                style: AppTypography.micro.copyWith(
                                    color: AppColors.warning,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                        const Spacer(),
                        Text('${product.stock} tersedia',
                            style: AppTypography.caption.copyWith(
                                color: product.stock > 0
                                    ? AppColors.success
                                    : AppColors.error)),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Product Name
                    Text(product.name,
                        style: AppTypography.headlineH1
                            .copyWith(fontSize: 22)),
                    const SizedBox(height: 4),
                    Text(product.brand,
                        style: AppTypography.headlineH3.copyWith(
                            color: AppColors.titanium,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 14),

                    // Price
                    Text(product.formattedPrice,
                        style: AppTypography.display.copyWith(
                            color: AppColors.performanceLime,
                            fontSize: 28,
                            fontWeight: FontWeight.w700)),

                    const SizedBox(height: 20),
                    _divider(),

                    // Seller
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.graphite,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.steel),
                          ),
                          child: const Icon(Icons.storefront_rounded,
                              size: 18, color: AppColors.titanium),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.sellerName,
                                  style: AppTypography.bodyStrong.copyWith(
                                      fontSize: 13)),
                              Text(product.sellerUsername,
                                  style: AppTypography.caption.copyWith(
                                      color: AppColors.mutedSteel)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.graphite,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.steel),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.star_rounded,
                                  size: 12, color: AppColors.warning),
                              SizedBox(width: 3),
                              Text('4.9',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.iceWhite,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    _divider(),

                    // Description
                    const SizedBox(height: 16),
                    Text('Deskripsi',
                        style: AppTypography.headlineH3
                            .copyWith(fontSize: 15)),
                    const SizedBox(height: 8),
                    Text(product.description,
                        style: AppTypography.body.copyWith(
                            color: AppColors.titanium, height: 1.6)),

                    const SizedBox(height: 20),
                    _divider(),

                    // Specifications
                    const SizedBox(height: 16),
                    Text('Spesifikasi',
                        style: AppTypography.headlineH3
                            .copyWith(fontSize: 15)),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.carbon,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.steel),
                      ),
                      child: Column(
                        children: product.specifications.entries
                            .map((e) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(e.key,
                                            style: AppTypography.caption
                                                .copyWith(
                                                    color: AppColors.titanium)),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(e.value,
                                            style:
                                                AppTypography.caption.copyWith(
                                                    color: AppColors.iceWhite,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),

                    const SizedBox(height: 20),
                    _divider(),

                    // Compatibility
                    const SizedBox(height: 16),
                    Text('Kompatibilitas Kendaraan',
                        style: AppTypography.headlineH3
                            .copyWith(fontSize: 15)),
                    const SizedBox(height: 10),
                    ...product.compatibleVehicles.map(
                      (v) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_rounded,
                                size: 16, color: AppColors.success),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(v,
                                  style: AppTypography.body.copyWith(
                                      color: AppColors.iceWhite,
                                      fontSize: 13)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),

          // ── Bottom CTA Bar ──
          bottomNavigationBar: Container(
            padding:
                const EdgeInsets.fromLTRB(20, 14, 20, 0),
            decoration: BoxDecoration(
              color: AppColors.carbon.withValues(alpha: 0.97),
              border:
                  const Border(top: BorderSide(color: AppColors.steel)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Save Toggle
                  GestureDetector(
                    onTap: () =>
                        widget.controller.toggleSave(product.id),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.graphite,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: product.isSaved
                                ? AppColors.performanceLime
                                : AppColors.steel),
                      ),
                      child: Icon(
                        product.isSaved
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        color: product.isSaved
                            ? AppColors.performanceLime
                            : AppColors.titanium,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Chat Seller
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _chatSeller(product),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.performanceLime,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.chat_rounded,
                                size: 18, color: AppColors.voidBlack),
                            const SizedBox(width: 8),
                            Text('Hubungi Penjual',
                                style: AppTypography.button.copyWith(
                                    color: AppColors.voidBlack,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _divider() => const Divider(color: AppColors.steel, height: 1);
}

