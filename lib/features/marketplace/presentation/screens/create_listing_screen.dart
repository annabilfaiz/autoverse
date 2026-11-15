import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/product_model.dart';
import '../../../../features/marketplace/state/marketplace_controller.dart';

class CreateListingScreen extends StatefulWidget {
  final MarketplaceController controller;
  const CreateListingScreen({super.key, required this.controller});

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _brandCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _compatCtrl = TextEditingController();

  String _selectedCategory = 'Engine';
  String _selectedCondition = 'New';
  bool _isPublishing = false;

  final List<Map<String, String>> _categories = [
    {'key': 'Engine', 'label': 'Mesin'},
    {'key': 'Exhaust', 'label': 'Knalpot'},
    {'key': 'Wheels', 'label': 'Velg'},
    {'key': 'Suspension', 'label': 'Suspensi'},
    {'key': 'Brakes', 'label': 'Rem'},
    {'key': 'Exterior', 'label': 'Eksterior'},
  ];

  final List<Map<String, String>> _conditions = [
    {'key': 'New', 'label': 'Baru'},
    {'key': 'Used', 'label': 'Bekas'},
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _brandCtrl.dispose();
    _priceCtrl.dispose();
    _descCtrl.dispose();
    _compatCtrl.dispose();
    super.dispose();
  }

  Future<void> _publish() async {
    if (!_formKey.currentState!.validate()) return;

    final rawPrice = _priceCtrl.text.replaceAll(RegExp(r'[^0-9]'), '');
    final price = int.tryParse(rawPrice) ?? 0;
    if (price <= 0) {
      _showError('Masukkan harga yang valid dalam Rupiah.');
      return;
    }

    final compatList = _compatCtrl.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    if (compatList.isEmpty) {
      _showError('Masukkan minimal satu kendaraan yang kompatibel.');
      return;
    }

    setState(() => _isPublishing = true);
    await Future.delayed(const Duration(milliseconds: 600));

    final listing = ProductModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: _nameCtrl.text.trim(),
      brand: _brandCtrl.text.trim(),
      category: _selectedCategory,
      priceIdr: price,
      sellerName: 'Aditya Pratama',
      sellerUsername: '@aditya_gt3',
      description: _descCtrl.text.trim(),
      specifications: {'Condition': _selectedCondition},
      compatibleVehicles: compatList,
      imageAsset: 'assets/images/products/product_titanium_exhaust.jpg',
      isNewListing: true,
      condition: _selectedCondition,
    );

    widget.controller.addListing(listing);
    if (mounted) {
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
              const Icon(Icons.check_circle_rounded,
                  size: 18, color: AppColors.performanceLime),
              const SizedBox(width: 10),
              Expanded(
                child: Text('Iklan komponen Anda berhasil diterbitkan!',
                    style: AppTypography.body
                        .copyWith(color: AppColors.iceWhite)),
              ),
            ],
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.error.withValues(alpha: 0.9),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 90),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(msg,
            style: AppTypography.body.copyWith(color: Colors.white)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        backgroundColor: AppColors.voidBlack,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.carbon,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.steel),
            ),
            child: const Icon(Icons.close_rounded,
                size: 18, color: AppColors.iceWhite),
          ),
        ),
        title: Text('Buat Iklan Komponen',
            style: AppTypography.headlineH3
                .copyWith(color: AppColors.iceWhite)),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
          children: [
            // Image placeholder
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.carbon,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: AppColors.steel,
                    style: BorderStyle.solid),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.photo_library_outlined,
                      size: 32, color: AppColors.mutedSteel),
                  const SizedBox(height: 8),
                  Text('Foto Komponen (Katalog Bawaan)',
                      style: AppTypography.bodyStrong
                          .copyWith(color: AppColors.titanium, fontSize: 13)),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Unggah foto kustom belum tersedia. Foto katalog akan disematkan secara otomatis saat diterbitkan.',
                      style: AppTypography.micro
                          .copyWith(color: AppColors.mutedSteel),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _sectionLabel('Kategori'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _categories.map((cat) {
                final sel = _selectedCategory == cat['key'];
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat['key']!),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: sel
                          ? AppColors.performanceLime
                          .withValues(alpha: 0.15)
                          : AppColors.carbon,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: sel
                              ? AppColors.performanceLime
                              : AppColors.steel),
                    ),
                    child: Text(cat['label']!,
                        style: AppTypography.caption.copyWith(
                            color: sel
                                ? AppColors.performanceLime
                                : AppColors.iceWhite,
                            fontWeight: FontWeight.w600)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            _sectionLabel('Kondisi'),
            const SizedBox(height: 8),
            Row(
              children: _conditions.map((cond) {
                final sel = _selectedCondition == cond['key'];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _selectedCondition = cond['key']!),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: sel
                            ? AppColors.performanceLime
                            .withValues(alpha: 0.15)
                            : AppColors.carbon,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: sel
                                ? AppColors.performanceLime
                                : AppColors.steel),
                      ),
                      child: Text(cond['label']!,
                          style: AppTypography.body.copyWith(
                              color: sel
                                  ? AppColors.performanceLime
                                  : AppColors.iceWhite,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            _field(
              label: 'Nama Komponen *',
              controller: _nameCtrl,
              hint: 'Contoh: Akrapovič Titanium Exhaust',
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 16),

            _field(
              label: 'Merek *',
              controller: _brandCtrl,
              hint: 'Contoh: Akrapovič',
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 16),

            _field(
              label: 'Harga (Rp) *',
              controller: _priceCtrl,
              hint: 'Contoh: 48500000',
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Wajib diisi';
                final raw = v.replaceAll(RegExp(r'[^0-9]'), '');
                if (int.tryParse(raw) == null) return 'Masukkan angka yang valid';
                return null;
              },
            ),
            const SizedBox(height: 16),

            _field(
              label: 'Deskripsi *',
              controller: _descCtrl,
              hint: 'Jelaskan kondisi komponen dan kelengkapannya...',
              maxLines: 4,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 16),

            _field(
              label: 'Kompatibilitas Kendaraan *',
              controller: _compatCtrl,
              hint: 'Contoh: Porsche 911 GT3, Mazda RX-7 FD3S',
              hint2: 'Pisahkan beberapa kendaraan dengan tanda koma',
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Wajib diisi';
                final parts = v.split(',').where((s) => s.trim().isNotEmpty);
                if (parts.isEmpty) return 'Masukkan minimal satu kendaraan';
                return null;
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
        decoration: BoxDecoration(
          color: AppColors.carbon.withValues(alpha: 0.97),
          border: const Border(top: BorderSide(color: AppColors.steel)),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: _isPublishing ? null : _publish,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: _isPublishing
                    ? AppColors.performanceLime.withValues(alpha: 0.5)
                    : AppColors.performanceLime,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: _isPublishing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.voidBlack,
                        ),
                      )
                    : Text('Terbitkan Iklan',
                        style: AppTypography.button.copyWith(
                            color: AppColors.voidBlack,
                            fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) => Text(text,
      style: AppTypography.caption.copyWith(
          color: AppColors.titanium, fontWeight: FontWeight.w600));

  Widget _field({
    required String label,
    required TextEditingController controller,
    required String hint,
    String? hint2,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTypography.caption.copyWith(
                color: AppColors.titanium, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style:
              AppTypography.body.copyWith(color: AppColors.iceWhite),
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.body
                .copyWith(color: AppColors.mutedSteel),
            helperText: hint2,
            helperStyle: AppTypography.micro.copyWith(
                color: AppColors.mutedSteel),
            filled: true,
            fillColor: AppColors.carbon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.steel),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.steel),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: AppColors.performanceLime, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.error, width: 1.5),
            ),
            errorStyle:
                const TextStyle(color: AppColors.error, fontSize: 11),
          ),
        ),
      ],
    );
  }
}
