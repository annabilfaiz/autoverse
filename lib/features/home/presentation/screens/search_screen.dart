import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class SearchScreen extends StatefulWidget {
  final ValueChanged<String>? onSelectVehicle;
  final ValueChanged<String>? onSelectUser;

  const SearchScreen({super.key, this.onSelectVehicle, this.onSelectUser});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  final List<String> _trendingTags = [
    '#Porsche911',
    '#Akrapovic',
    '#TrackBuild',
    '#13BREW',
    '#SentulCircuit',
    '#Rotary',
    '#TypeRFK8',
    '#GT3Touring',
  ];

  final List<Map<String, String>> _suggestedVehicles = [
    {
      'title': '2022 Porsche 911 GT3 (992.1)',
      'subtitle': '4.0L Flat-6 · Track Spec · Aditya Pratama',
      'tag': 'Featured Build',
    },
    {
      'title': '1994 Mazda RX-7 FD3S',
      'subtitle': 'Twin-Turbo 13B-REW · Kenji Sato',
      'tag': 'Rotary Build',
    },
    {
      'title': '2018 Honda Civic Type R FK8',
      'subtitle': '306 HP K20C1 · Dimas Rizky',
      'tag': 'Track Spec',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: AppColors.iceWhite,
                    ),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColors.carbon,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.steel),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            size: 20,
                            color: AppColors.titanium,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              autofocus: true,
                              style: AppTypography.body.copyWith(
                                color: AppColors.iceWhite,
                              ),
                              decoration: InputDecoration(
                                hintText:
                                    'Cari modifikasi, kendaraan, komponen...',
                                hintStyle: AppTypography.body.copyWith(
                                  color: AppColors.mutedSteel,
                                  fontSize: 13,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _query = val;
                                });
                              },
                            ),
                          ),
                          if (_query.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                setState(() {
                                  _query = '';
                                });
                              },
                              child: const Icon(
                                Icons.cancel,
                                size: 18,
                                color: AppColors.titanium,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(color: AppColors.steel, height: 1),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // Trending Tags
                  Text(
                    'Tag Otomotif Populer',
                    style: AppTypography.headlineH3.copyWith(
                      fontSize: 15,
                      color: AppColors.iceWhite,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _trendingTags.map((tag) {
                      return GestureDetector(
                        onTap: () {
                          _searchController.text = tag;
                          setState(() {
                            _query = tag;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.graphite,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.steel),
                          ),
                          child: Text(
                            tag,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.performanceLime,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 28),

                  // Suggested Builds
                  Text(
                    'Rekomendasi Modifikasi Komunitas',
                    style: AppTypography.headlineH3.copyWith(
                      fontSize: 15,
                      color: AppColors.iceWhite,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ..._suggestedVehicles.map((v) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.carbon,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.steel),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.graphite,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.steel),
                            ),
                            child: const Icon(
                              Icons.directions_car,
                              color: AppColors.performanceLime,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        v['title']!,
                                        style: AppTypography.bodyStrong
                                            .copyWith(
                                              color: AppColors.iceWhite,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.limeSoft,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        v['tag']!,
                                        style: AppTypography.micro.copyWith(
                                          color: AppColors.performanceLime,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  v['subtitle']!,
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.titanium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
