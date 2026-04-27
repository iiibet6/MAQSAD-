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
  ShopPlace(
    name: 'جراند مول حائل',
    image: 'assets/images/grandmall.jpeg',
    description: 'مجمع تجاري مشهور يضم مطاعم وكافيهات ومتاجر متنوعة.',
    hours: '10 ص - 12 م',
    category: 'مولات',
    tags: ['تسوق', 'مولات', 'مول', 'مطاعم', 'كافيهات', 'عائلي'],
  ),

  ShopPlace(
    name: 'جاردن مول',
    image: 'assets/images/gardenmall.jpeg',
    description: 'مول عائلي يضم متاجر عالمية ومطاعم ومقاهي.',
    hours: '10 ص - 11 م',
    category: 'مولات',
    tags: ['تسوق', 'مولات', 'مول', 'عائلي', 'مطاعم', 'مقاهي'],
  ),

  ShopPlace(
    name: 'حائل مول',
    image: 'assets/images/hailmall.jpeg',
    description: 'مركز تسوق يحتوي على متاجر متنوعة للعائلة.',
    hours: '10 ص - 11 م',
    category: 'مولات',
    tags: ['تسوق', 'مولات', 'مول', 'عائلي', 'متاجر'],
  ),

  ShopPlace(
    name: 'ام جي فاشن بوتيك',
    image: 'assets/images/MG.jpeg',
    description: 'أزياء نسائية عصرية وشبابية.',
    hours: '10 ص - 11 م',
    category: 'ملابس نسائية',
    tags: ['تسوق', 'ملابس', 'نسائي', 'بوتيك', 'أزياء', 'موضة'],
  ),

  ShopPlace(
    name: 'سنبل',
    image: 'assets/images/sonbol.png',
    description: 'ملابس شبابية وإكسسوارات نسائية.',
    hours: '10 ص - 11 م',
    category: 'ملابس نسائية',
    tags: ['تسوق', 'ملابس', 'نسائي', 'إكسسوارات', 'أزياء'],
  ),

  ShopPlace(
    name: 'كاتان بوتيك',
    image: 'assets/images/catanBoutiq.jpg',
    description: 'ملابس نسائية بأسعار مناسبة.',
    hours: '2:30 ص - 8:30 م',
    category: 'ملابس نسائية',
    tags: ['تسوق', 'ملابس', 'نسائي', 'بوتيك', 'أزياء'],
  ),

  ShopPlace(
    name: 'تاسومة | Tasooma',
    image: 'assets/images/tasooma.jpeg',
    description: 'أحذية ومستلزمات رجالية راقية.',
    hours: '10 ص - 11 م',
    category: 'ملابس رجالية',
    tags: ['تسوق', 'ملابس', 'رجالي', 'أحذية', 'مستلزمات رجالية'],
  ),

  ShopPlace(
    name: 'التويجري للمستلزمات الرجالية',
    image: 'assets/images/altwijri.jpg',
    description: 'ملابس رجالية متنوعة بأسعار مناسبة.',
    hours: '10 ص - 11 م',
    category: 'ملابس رجالية',
    tags: ['تسوق', 'ملابس', 'رجالي', 'ثياب', 'مستلزمات رجالية'],
  ),

  ShopPlace(
    name: 'أبيض و أسود',
    image: 'assets/images/blackandw.png',
    description: 'ملابس رجالية كاجوال وعملية.',
    hours: '10 ص - 11 م',
    category: 'ملابس رجالية',
    tags: ['تسوق', 'ملابس', 'رجالي', 'كاجوال', 'أزياء'],
  ),

  ShopPlace(
    name: 'ممنون لملابس الاطفال',
    image: 'assets/images/mmnoon.png',
    description: 'ملابس أطفال متنوعة.',
    hours: '10 ص - 11 م',
    category: 'ملابس أطفال',
    tags: ['تسوق', 'ملابس', 'أطفال', 'عائلي', 'أزياء أطفال'],
  ),

  ShopPlace(
    name: 'بسكوتي',
    image: 'assets/images/biscoti.png',
    description: 'ملابس أطفال بأسعار مناسبة.',
    hours: '10 ص - 11 م',
    category: 'ملابس أطفال',
    tags: ['تسوق', 'ملابس', 'أطفال', 'عائلي', 'أزياء أطفال'],
  ),

  ShopPlace(
    name: 'الهزاز',
    image: 'assets/images/alhazzaz.jpeg',
    description: 'أدوات منزلية وديكور ومستلزمات بيت.',
    hours: '9 ص - 11 م',
    category: 'بيت',
    tags: ['تسوق', 'بيت', 'منزل', 'ديكور', 'أدوات منزلية'],
  ),

  ShopPlace(
    name: 'راحتي',
    image: 'assets/images/rahaty.jpeg',
    description: 'مستلزمات منزلية ومنتجات للبيت.',
    hours: '9 ص - 11 م',
    category: 'بيت',
    tags: ['تسوق', 'بيت', 'منزل', 'راحة', 'ديكور'],
  ),

  ShopPlace(
    name: 'سولارا',
    image: 'assets/images/solara.png',
    description: 'متجر مستحضرات تجميل وعناية ومنتجات مميزة.',
    hours: '10 ص - 11 م',
    category: 'تجميل',
    tags: ['تسوق', 'تجميل', 'مكياج', 'عناية', 'عطور', 'بنات'],
  ),

  ShopPlace(
    name: 'محل الأكليل',
    image: 'assets/images/alaklil.jpeg',
    description: 'عطور ومستحضرات تجميل ومنتجات عناية.',
    hours: '10 ص - 11 م',
    category: 'تجميل',
    tags: ['تسوق', 'تجميل', 'عطور', 'عناية', 'مكياج'],
  ),

  ShopPlace(
    name: 'مكتبة جرير',
    image: 'assets/images/jarir.png',
    description: 'إلكترونيات وكتب وأجهزة ذكية.',
    hours: '10 ص - 11 م',
    category: 'إلكترونيات',
    tags: ['تسوق', 'إلكترونيات', 'كتب', 'أجهزة', 'تقنية'],
  ),ShopPlace(
    name: 'اكسترا',
    image: 'assets/images/extra.png',
    description: 'إلكترونيات وأجهزة منزلية متنوعة.',
    hours: '10 ص - 11 م',
    category: 'إلكترونيات',
    tags: ['تسوق', 'إلكترونيات', 'أجهزة', 'تقنية', 'منزل'],
  ),
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

 Future<void> _toggleFavorite(
  List<Map<String, String>> favs,
) async {
  final isFav = favs.any(
    (item) => item['title'] == place.name,
  );

  if (isFav) {
    await FavoritesService.removeFavorite(
      place.name,
    );
  } else {
    await FavoritesService.addFavorite({
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