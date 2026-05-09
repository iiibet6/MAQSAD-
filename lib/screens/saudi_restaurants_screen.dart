import 'package:flutter/material.dart';

import '../models/restaurant_model.dart';
import 'restaurant_details_screen.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';

class SaudiRestaurantsScreen extends StatelessWidget {
  const SaudiRestaurantsScreen({super.key});

  static const List<Restaurant> restaurants = [
    Restaurant(
      name: 'مطعم سفرة السعف',
            googleRating: 4.7,

      image: 'assets/images/sofra.png',
      gallery: [
    'assets/images/sofra1.png',
    'assets/images/sofra2.png',
    'assets/images/sofra3.png',
  ],
      subtitle: 'مأكولات سعودية حساوية',
      type: 'مطاعم',
      category: 'سعودي',
      tags: ['مطاعم', 'سعودي', 'حساوي', 'مندي', 'كبسة', 'رز', 'شعبي'],
      categories: ['الأكثر مبيعًا', 'الأطباق الرئيسية', 'المشروبات'],
      menu: [
        MenuItem(name: 'مندي حساوي - نصف دجاجة', price: '30', image: 'assets/images/menu1.png', category: 'الأكثر مبيعًا'),
        MenuItem(name: 'كبسة رز مزه - نصف دجاجة', price: '30', image: 'assets/images/menu2.png', category: 'الأكثر مبيعًا'),
        MenuItem(name: 'مكرونة', price: '21', image: 'assets/images/menu3.png', category: 'الأكثر مبيعًا'),
        MenuItem(name: 'كبسة رز حساوي', price: '38', image: 'assets/images/menu4.png', category: 'الأطباق الرئيسية'),
        MenuItem(name: 'بيبسي', price: '4', image: 'assets/images/menu5.png', category: 'المشروبات'),
      ],
    ),
    Restaurant(
      name: 'مطعم بخاري ناز',
            googleRating: 4.7,

      image: 'assets/images/naz.png',
      gallery: [
    'assets/images/naz1.png',
    'assets/images/naz2.png',
    'assets/images/naz3.png',
    'assets/images/naz4.png',
  ],
      subtitle: 'بخاري ودجاج على الفحم',
      type: 'مطاعم',
      category: 'سعودي',
      tags: ['مطاعم', 'سعودي', 'بخاري', 'دجاج', 'رز', 'مشويات'],
      categories: ['الأكثر مبيعًا', 'الأطباق الرئيسية', 'المشروبات'],
      menu: [
        MenuItem(name: 'بخاري دجاج', price: '24', image: 'assets/images/bukhari1.png', category: 'الأكثر مبيعًا'),
        MenuItem(name: 'نصف دجاجة على الفحم', price: '32', image: 'assets/images/bukhari2.png', category: 'الأطباق الرئيسية'),
        MenuItem(name: 'بيبسي', price: '4', image: 'assets/images/cola.png', category: 'المشروبات'),
      ],
    ),
    Restaurant(
      name: 'مطعم نكهة ديرتنا',
            googleRating: 4.7,

      image: 'assets/images/dayratna.png',
      gallery: [
    'assets/images/dayratna1.png',
    'assets/images/dayratna2.png',
    'assets/images/dayratna3.png',
    'assets/images/dayratna4.png',
  ],
      subtitle: 'أكلات شعبية سعودية',
      type: 'مطاعم',
      category: 'سعودي',
      tags: ['مطاعم', 'سعودي', 'شعبي', 'كبسة', 'مندي', 'لحم', 'دجاج'],
      categories: ['الأكثر مبيعًا', 'الأطباق الرئيسية', 'المشروبات'],
      menu: [
        MenuItem(name: 'كبسة دجاج', price: '28', image: 'assets/images/dayratna1.png', category: 'الأكثر مبيعًا'),
        MenuItem(name: 'مندي لحم', price: '55', image: 'assets/images/dayratna2.png', category: 'الأطباق الرئيسية'),
        MenuItem(name: 'لبن', price: '5', image: 'assets/images/drink1.png', category: 'المشروبات'),
      ],
    ),
    Restaurant(
      name: 'مطعم ضيوف الأصالة',
            googleRating: 4.7,

      image: 'assets/images/alasala.png',
      gallery: [
    'assets/images/alasala1.png',
    'assets/images/alasala2.png',
    'assets/images/alasala3.png',
    'assets/images/alasala4.png',
  ],
      subtitle: 'مأكولات تراثية وأرز',
      type: 'مطاعم',
      category: 'سعودي',
      tags: ['مطاعم', 'سعودي', 'تراثي', 'مضغوط', 'مظبي', 'رز', 'لحم'],
      categories: ['الأكثر مبيعًا', 'الأطباق الرئيسية', 'المشروبات'],
      menu: [
        MenuItem(name: 'مضغوط دجاج', price: '30', image: 'assets/images/alasala1.png', category: 'الأكثر مبيعًا'),
        MenuItem(name: 'مظبي لحم', price: '60', image: 'assets/images/alasala2.png', category: 'الأطباق الرئيسية'),
        MenuItem(name: 'ماء', price: '2', image: 'assets/images/water.png', category: 'المشروبات'),
      ],
    ),
    Restaurant(
      name: 'مطعم السدة',
            googleRating: 4.7,

      image: 'assets/images/alsaddah.png',
      gallery: [
    'assets/images/alsaddah1.png',
    'assets/images/alsaddah2.png',
    'assets/images/alsaddah3.png',
    'assets/images/alsaddah4.png',
  ],
      subtitle: 'أطباق سعودية شعبية',
      type: 'مطاعم',
      category: 'سعودي',
      tags: ['مطاعم', 'سعودي', 'شعبي', 'مندي', 'جريش', 'دجاج', 'رز'],
      categories: ['الأكثر مبيعًا', 'الأطباق الرئيسية', 'المشروبات'],
      menu: [
        MenuItem(name: 'مندي دجاج', price: '29', image: 'assets/images/alsaddah1.png', category: 'الأكثر مبيعًا'),
        MenuItem(name: 'جريش', price: '18', image: 'assets/images/alsaddah2.png', category: 'الأطباق الرئيسية'),
        MenuItem(name: 'بيبسي', price: '4', image: 'assets/images/cola.png', category: 'المشروبات'),
      ],
    ),
    Restaurant(
      name: 'مطعم الوادي المبارك',
            googleRating: 4.7,

      image: 'assets/images/alwadi.jpeg',
      gallery: [
    'assets/images/alwadi1.png',
    'assets/images/alwadi2.png',
    'assets/images/alwadi3.png',
    'assets/images/alwadi4.png',
  ],
      subtitle: 'بخاري ومشويات',
      type: 'مطاعم',
      category: 'سعودي',
      tags: ['مطاعم', 'سعودي', 'بخاري', 'مشويات', 'دجاج', 'رز', 'شواية'],
      categories: ['الأكثر مبيعًا', 'الأطباق الرئيسية', 'المشروبات'],
      menu: [
        MenuItem(name: 'رز بخاري مع دجاج', price: '25', image: 'assets/images/alwadi1.png', category: 'الأكثر مبيعًا'),
        MenuItem(name: 'دجاج شواية', price: '22', image: 'assets/images/alwadi2.png', category: 'الأطباق الرئيسية'),
        MenuItem(name: 'عصير', price: '6', image: 'assets/images/juice.png', category: 'المشروبات'),
      ],
    ),
    Restaurant(
      name: 'مطعم القصرين',
            googleRating: 4.7,

      image: 'assets/images/alqasrain.jpeg',
      gallery: [
    'assets/images/alqasrain1.png',
    'assets/images/alqasrain2.png',
    'assets/images/alqasrain3.png',
    'assets/images/alqasrain4.png',
  ],
      subtitle: 'مندي وكبسات',
      type: 'مطاعم',
      category: 'سعودي',
      tags: ['مطاعم', 'سعودي', 'مندي', 'كبسة', 'رز', 'لحم', 'دجاج'],
      categories: ['الأكثر مبيعًا', 'الأطباق الرئيسية', 'المشروبات'],
      menu: [
        MenuItem(name: 'كبسة لحم', price: '58', image: 'assets/images/alqasrain1.png', category: 'الأكثر مبيعًا'),
        MenuItem(name: 'مندي دجاج', price: '30', image: 'assets/images/alqasrain2.png', category: 'الأطباق الرئيسية'),
        MenuItem(name: 'لبن', price: '5', image: 'assets/images/drink1.png', category: 'المشروبات'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.saudiRestaurants),
          centerTitle: true,
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: restaurants.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final restaurant = restaurants[index];

            return _RestaurantCard(
              restaurant: restaurant,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RestaurantDetailsScreen(
                      restaurant: restaurant,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;

  const _RestaurantCard({
    required this.restaurant,
    required this.onTap,
  });

  Future<void> _toggleFavorite(
  List<Map<String, String>> favs,
) async {
  final isFav = favs.any(
    (item) => item['title'] == restaurant.name,
  );

  if (isFav) {
    await FavoritesService.removeFavorite(
      restaurant.name,
    );
  } else {
    await FavoritesService.addFavorite({
      'title': restaurant.name,
      'image': restaurant.image,
      'subtitle': restaurant.subtitle,
      'type': restaurant.type,
      'category': restaurant.category,
      'tags': restaurant.tags.join(','),
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    restaurant.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey.shade200,child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 4,
                  child: ValueListenableBuilder<List<Map<String, String>>>(
                    valueListenable: FavoritesService.favorites,
                    builder: (context, favs, _) {
                      final isFav = favs.any(
                        (item) => item['title'] == restaurant.name,
                      );

                      return GestureDetector(
                        onTap: () => _toggleFavorite(favs),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(4),
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
                    restaurant.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    restaurant.subtitle,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}