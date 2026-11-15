class ProductModel {
  final String id;
  final String name;
  final String brand;
  final String category;
  final int priceIdr;
  final String sellerName;
  final String sellerUsername;
  final String description;
  final Map<String, String> specifications;
  final List<String> compatibleVehicles;
  final String imageAsset;
  bool isSaved;
  final bool isNewListing;
  final String condition;
  final int stock;

  ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.priceIdr,
    required this.sellerName,
    required this.sellerUsername,
    required this.description,
    required this.specifications,
    required this.compatibleVehicles,
    required this.imageAsset,
    this.isSaved = false,
    this.isNewListing = false,
    this.condition = 'New',
    this.stock = 1,
  });

  String get formattedPrice {
    final formatted = priceIdr.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    );
    return 'Rp $formatted';
  }
}
