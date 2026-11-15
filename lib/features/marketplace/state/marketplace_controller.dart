import 'package:flutter/foundation.dart';
import '../../../data/models/product_model.dart';
import '../../../data/marketplace_data.dart';

enum MarketplaceSortOrder { priceLowToHigh, priceHighToLow, newest }

class MarketplaceController extends ChangeNotifier {
  final List<ProductModel> _allProducts = MarketplaceData.getInitialProducts();

  String _searchQuery = '';
  String _selectedCategory = 'All';
  MarketplaceSortOrder _sortOrder = MarketplaceSortOrder.newest;
  String _compatibilityFilter = '';

  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  MarketplaceSortOrder get sortOrder => _sortOrder;
  String get compatibilityFilter => _compatibilityFilter;

  List<String> get categories => ['All', 'Engine', 'Exhaust', 'Wheels', 'Suspension', 'Brakes', 'Exterior'];

  List<ProductModel> get filteredProducts {
    var products = List<ProductModel>.from(_allProducts);

    // Search filter
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      products = products.where((p) =>
          p.name.toLowerCase().contains(q) ||
          p.brand.toLowerCase().contains(q) ||
          p.description.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q)).toList();
    }

    // Category filter
    if (_selectedCategory != 'All') {
      products = products.where((p) => p.category == _selectedCategory).toList();
    }

    // Compatibility filter
    if (_compatibilityFilter.isNotEmpty) {
      final cf = _compatibilityFilter.toLowerCase();
      products = products.where((p) =>
          p.compatibleVehicles.any((v) => v.toLowerCase().contains(cf))).toList();
    }

    // Sort
    switch (_sortOrder) {
      case MarketplaceSortOrder.priceLowToHigh:
        products.sort((a, b) => a.priceIdr.compareTo(b.priceIdr));
        break;
      case MarketplaceSortOrder.priceHighToLow:
        products.sort((a, b) => b.priceIdr.compareTo(a.priceIdr));
        break;
      case MarketplaceSortOrder.newest:
        products.sort((a, b) => (b.isNewListing ? 1 : 0).compareTo(a.isNewListing ? 1 : 0));
        break;
    }

    return products;
  }

  List<ProductModel> get featuredProducts =>
      _allProducts.where((p) => !p.isNewListing).take(3).toList();

  List<ProductModel> get savedProducts =>
      _allProducts.where((p) => p.isSaved).toList();

  bool get hasActiveFilters =>
      _searchQuery.isNotEmpty ||
      _selectedCategory != 'All' ||
      _compatibilityFilter.isNotEmpty ||
      _sortOrder != MarketplaceSortOrder.newest;

  void setSearchQuery(String q) {
    _searchQuery = q;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSortOrder(MarketplaceSortOrder order) {
    _sortOrder = order;
    notifyListeners();
  }

  void setCompatibilityFilter(String filter) {
    _compatibilityFilter = filter;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = 'All';
    _sortOrder = MarketplaceSortOrder.newest;
    _compatibilityFilter = '';
    notifyListeners();
  }

  void toggleSave(String productId) {
    final idx = _allProducts.indexWhere((p) => p.id == productId);
    if (idx != -1) {
      _allProducts[idx].isSaved = !_allProducts[idx].isSaved;
      notifyListeners();
    }
  }

  void addListing(ProductModel product) {
    _allProducts.insert(0, product);
    notifyListeners();
  }

  ProductModel? getById(String id) {
    try {
      return _allProducts.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}

