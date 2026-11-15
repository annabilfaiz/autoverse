import 'package:flutter/foundation.dart';
import '../../../../data/models/post_model.dart';
import '../../../../data/models/product_model.dart';
import '../../../../data/models/vehicle_model.dart';
import '../../../../data/vehicles_data.dart';
import '../../home/state/feed_controller.dart';
import '../../marketplace/state/marketplace_controller.dart';

enum SavedCategory { posts, marketplace, vehicles }

enum SavedContentType { post, product, vehicle }

/// Record identifying a saved item across the application
class SavedItemRecord {
  final SavedContentType type;
  final String itemId;
  final DateTime savedAt;

  const SavedItemRecord({
    required this.type,
    required this.itemId,
    required this.savedAt,
  });
}

/// Unified controller for all saved content in AutoVerse:
/// 1. Social posts from Home / FYP
/// 2. Components from Marketplace
/// 3. Vehicles from Vehicle Showcase / Garage
class SavedItemsController extends ChangeNotifier {
  final FeedController feedController;
  final MarketplaceController marketplaceController;

  final Set<String> _savedVehicleIds = {'veh_porsche_gt3'};

  SavedCategory _selectedCategory = SavedCategory.posts;
  SavedCategory get selectedCategory => _selectedCategory;

  SavedItemsController({
    required this.feedController,
    required this.marketplaceController,
    Set<String>? initialSavedVehicleIds,
  }) {
    if (initialSavedVehicleIds != null) {
      _savedVehicleIds.clear();
      _savedVehicleIds.addAll(initialSavedVehicleIds);
    }
    // Synchronize whenever source controllers change
    feedController.addListener(_onSourceChanged);
    marketplaceController.addListener(_onSourceChanged);
  }

  void _onSourceChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    feedController.removeListener(_onSourceChanged);
    marketplaceController.removeListener(_onSourceChanged);
    super.dispose();
  }

  void setSelectedCategory(SavedCategory category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      notifyListeners();
    }
  }

  // ── 1. POSTS ──
  List<PostModel> get savedPosts =>
      feedController.allPosts.where((p) => p.isSaved).toList();

  int get savedPostsCount => savedPosts.length;

  bool isPostSaved(String postId) => feedController.isSaved(postId);

  void toggleSavePost(String postId) {
    feedController.toggleSave(postId);
  }

  void unsavePost(String postId) {
    if (isPostSaved(postId)) {
      feedController.toggleSave(postId);
    }
  }

  // ── 2. MARKETPLACE PRODUCTS ──
  List<ProductModel> get savedProducts =>
      marketplaceController.savedProducts;

  int get savedProductsCount => savedProducts.length;

  bool isProductSaved(String productId) {
    final prod = marketplaceController.getById(productId);
    return prod?.isSaved ?? false;
  }

  void toggleSaveProduct(String productId) {
    marketplaceController.toggleSave(productId);
  }

  void unsaveProduct(String productId) {
    if (isProductSaved(productId)) {
      marketplaceController.toggleSave(productId);
    }
  }

  // ── 3. VEHICLES ──
  List<VehicleModel> get savedVehicles {
    final all = VehiclesData.getAdityaGarageVehicles();
    return all.where((v) => _savedVehicleIds.contains(v.id)).toList();
  }

  int get savedVehiclesCount => _savedVehicleIds.length;

  bool isVehicleSaved(String vehicleId) => _savedVehicleIds.contains(vehicleId);

  void toggleSaveVehicle(String vehicleId) {
    if (_savedVehicleIds.contains(vehicleId)) {
      _savedVehicleIds.remove(vehicleId);
    } else {
      _savedVehicleIds.add(vehicleId);
    }
    notifyListeners();
  }

  void saveVehicle(String vehicleId) {
    if (!_savedVehicleIds.contains(vehicleId)) {
      _savedVehicleIds.add(vehicleId);
      notifyListeners();
    }
  }

  void unsaveVehicle(String vehicleId) {
    if (_savedVehicleIds.remove(vehicleId)) {
      notifyListeners();
    }
  }

  VehicleModel? getVehicleById(String vehicleId) {
    try {
      return VehiclesData.getAdityaGarageVehicles()
          .firstWhere((v) => v.id == vehicleId);
    } catch (_) {
      return null;
    }
  }

  int get totalSavedCount =>
      savedPostsCount + savedProductsCount + savedVehiclesCount;
}
