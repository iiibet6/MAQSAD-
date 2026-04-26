import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';

class ShopPlace {
  final String name;
  final String image;
  final String description;
  final String hours;
  final String category;
  final List<String> tags;

  const ShopPlace({
    required this.name,
    required this.image,
    required this.description,
    required this.hours,
    required this.category,
    required this.tags,
  });
}

const List<ShopPlace> shoppingPlaces = [
  // نفس بياناتك كما هي بدون تغيير
];

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  String selectedCategoryKey = 'all';

  List<Map<String, String>> _categories(AppLocalizations t) => [
        {'key': 'all', 'label': t.all},
        {'key': 'malls', 'label': t.malls},
        {'key': 'womenClothes', 'label': t.womenClothes},
        {'key': 'menClothes', 'label': t.menClothes},
        {'key': 'kidsClothes', 'label': t.kidsClothes},
        {'key': 'homeCategory', 'label': t.homeCategory},
        {'key': 'beauty', 'label': t.beauty},
        {'key': 'electronics', 'label': t.electronics},
      ];

  String _categoryArabicValue(String key) {
    switch (key) {
      case 'malls':
        return 'مولات';
      case 'womenClothes':
        return 'ملابس نسائية';
      case 'menClothes':
        return 'ملابس رجالية';
      case 'kidsClothes':
        return 'ملابس أطفال';
      case 'homeCategory':
        return 'بيت';
      case 'beauty':
        return 'تجميل';
      case 'electronics':
        return 'إلكترونيات';
      default:
        return 'الكل';
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final categories = _categories(t);

    final filteredPlaces = selectedCategoryKey == 'all'
        ? shoppingPlaces
        : shoppingPlaces
            .where((p) => p.category == _categoryArabicValue(selectedCategoryKey))
            .toList();return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.shopping),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 58,
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final key = category['key']!;
                  final label = category['label']!;
                  final isSelected = key == selectedCategoryKey;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryKey = key;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF3E2A1E)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF3E2A1E)
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          label,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPlaces.length,
                itemBuilder: (context, index) {
                  return _ShopCard(
                    place: filteredPlaces[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShopCard extends StatelessWidget {
  final ShopPlace place;

  const _ShopCard({
    required this.place,
  });

  void _toggleFavorite(List<Map<String, String>> favs) {
    final isFav = favs.any(
      (item) => item['title'] == place.name,
    );

    if (isFav) {
      FavoritesService.favorites.value = List.from(favs)
        ..removeWhere(
          (item) => item['title'] == place.name,
        );
    } else {
      FavoritesService.favorites.value = List.from(favs)
        ..add({
          'title': place.name,
          'image': place.image,
          'subtitle': place.description,
          'type': 'تسوق',
          'category': place.category,
          'tags': place.tags.join(','),
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  place.image,
                  width: 95,
                  height: 95,
                  fit: BoxFit.cover,errorBuilder: (_, __, ___) => Container(
                    width: 95,
                    height: 95,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.shopping_bag,
                      size: 38,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 6,
                left: 6,
                child: ValueListenableBuilder<List<Map<String, String>>>(
                  valueListenable: FavoritesService.favorites,
                  builder: (context, favs, _) {
                    final isFav = favs.any(
                      (item) => item['title'] == place.name,
                    );

                    return GestureDetector(
                      onTap: () => _toggleFavorite(favs),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  place.name,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  place.description,
                  textAlign: TextAlign.right,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      place.hours,
                      style: const TextStyle(
                        color: Color(0xFF8A4B00),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Color(0xFF8A4B00),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}