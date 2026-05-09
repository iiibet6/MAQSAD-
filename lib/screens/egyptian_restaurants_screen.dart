import 'package:flutter/material.dart';

import '../models/restaurant_model.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';
import 'restaurant_details_screen.dart';

class EgyptianRestaurantsScreen extends StatelessWidget {
  const EgyptianRestaurantsScreen({super.key});

  static const List<Restaurant> restaurants = [
    Restaurant(
      name: 'مطعم كوخ القاهرة',
      googleRating: 4.7,
      image: 'assets/images/cairo_hut.jpeg',
      gallery: [
  'assets/images/cairo_hut1.png',
  'assets/images/cairo_hut2.png',
  'assets/images/cairo_hut3.png',
],
      subtitle: 'أكلات مصرية وكشري وحواوشي',
      type: 'مطاعم',
      category: 'مصري',
      tags: ['مطاعم', 'مصري', 'كشري', 'حواوشي', 'طواجن', 'شعبي'],
      categories: ['الكشري', 'الحواوشي', 'الطواجن', 'المشروبات'],
      menu: [
        MenuItem(name: 'كشري مصري', price: '0', image: 'assets/images/koshary.png', category: 'الكشري'),
        MenuItem(name: 'حواوشي', price: '0', image: 'assets/images/hawawshi.png', category: 'الحواوشي'),
        MenuItem(name: 'طاجن مكرونة باللحم', price: '0', image: 'assets/images/pasta_meat_tajin.png', category: 'الطواجن'),
        MenuItem(name: 'شاي كرك', price: '0', image: 'assets/images/tea.png', category: 'المشروبات'),
      ],
    ),
    Restaurant(
      name: 'مطعم ريف القاهرة',
      googleRating: 4.7,
      image: 'assets/images/reef_cairo.png',
      gallery: [
  'assets/images/reef_cairo1.png',
  'assets/images/reef_cairo2.png',
  'assets/images/reef_cairo3.png',
],
      subtitle: 'مشويات وأطباق مصرية',
      type: 'مطاعم',
      category: 'مصري',
      tags: ['مطاعم', 'مصري', 'مشويات', 'كفتة', 'حمام', 'بط', 'طواجن'],
      categories: ['المشويات', 'اللحوم', 'الدجاج', 'الطواجن', 'المشروبات'],
      menu: [
        MenuItem(name: 'موزة لحم مشوية', price: '80', image: 'assets/images/reef_moza.png', category: 'المشويات'),
        MenuItem(name: 'كفتة بتلو - لشخص واحد', price: '46', image: 'assets/images/reef_kofta.png', category: 'المشويات'),
        MenuItem(name: 'وجبة بط محمر', price: '42', image: 'assets/images/reef_duck.png', category: 'اللحوم'),
        MenuItem(name: 'حمام محشي', price: '57', image: 'assets/images/reef_pigeon.png', category: 'اللحوم'),
        MenuItem(name: 'شيش فراخ عظم - نص حبة', price: '25', image: 'assets/images/reef_chicken.png', category: 'الدجاج'),
        MenuItem(name: 'طاجن بطاطس لحمة', price: '0', image: 'assets/images/reef_tajin.png', category: 'الطواجن'),
      ],
    ),
    Restaurant(
      name: 'مطعم كشريتا',
      googleRating: 4.7,
      image: 'assets/images/kosharita.jpeg',
       gallery: [
  'assets/images/kosharita1.png',
  'assets/images/kosharita2.png',
  'assets/images/kosharita3.png',
],
      subtitle: 'كشري مصري وطواجن',
      type: 'مطاعم',
      category: 'مصري',
      tags: ['مطاعم', 'مصري', 'كشري', 'طواجن', 'مكرونة', 'شعبي'],
      categories: ['الكشري', 'الطواجن', 'السندوتشات', 'الحلى', 'المشروبات'],
      menu: [
        MenuItem(name: 'كشري بشاميل', price: '18', image: 'assets/images/kosharita_bashamel.png', category: 'الكشري'),
        MenuItem(name: 'كشري الأصلي بصلصة الطماطم - صغير', price: '14', image: 'assets/images/kosharita_original.png', category: 'الكشري'),
        MenuItem(name: 'كشري تكا مسالا - كبير', price: '31', image: 'assets/images/kosharita_tikka.png', category: 'الكشري'),
        MenuItem(name: 'كشري كريمة الدجاج - كبير', price: '37', image: 'assets/images/kosharita_chicken_cream.png', category: 'الكشري'),
        MenuItem(name: 'كشري اللحم المفروم - كبير', price: '37', image: 'assets/images/kosharita_meat.png', category: 'الكشري'),
        MenuItem(name: 'طاجن مكرونة بالكبدة الاسكندراني', price: '25', image: 'assets/images/kosharita_liver_pasta.png', category: 'الطواجن'),
        MenuItem(name: 'طاجن مكرونة باللحمة المفرومة', price: '25', image: 'assets/images/kosharita_meat_pasta.png', category: 'الطواجن'),
        MenuItem(name: 'مهلبية', price: '0', image: 'assets/images/muhalabia.png', category: 'الحلى'),
      ],
    ),
    Restaurant(
      name: 'مطعم كشري وحواوشي',
      googleRating: 4.7,
      image: 'assets/images/koshary_hawawshi.jpeg',
       gallery: [
  'assets/images/koshary_hawawshi1.png',
  'assets/images/koshary_hawawshi2.png',
  'assets/images/koshary_hawawshi3.png',
],
      subtitle: 'كشري وحواوشي وعصائر',
      type: 'مطاعم',
      category: 'مصري',
      tags: ['مطاعم', 'مصري', 'كشري', 'حواوشي', 'عصائر', 'شعبي'],
      categories: ['الحواوشي', 'الكشري', 'العصائر', 'المشروبات'],
      menu: [
        MenuItem(name: 'سبايسي حواوشي', price: '27', image: 'assets/images/spicy_hawawshi.png', category: 'الحواوشي'),
        MenuItem(name: 'حواوشي بالجبنة', price: '29', image: 'assets/images/cheese_hawawshi.png', category: 'الحواوشي'),
        MenuItem(name: 'كشري مصري', price: '0', image: 'assets/images/koshary.png', category: 'الكشري'),
        MenuItem(name: 'عصير البرتقال الطازج', price: '0', image: 'assets/images/orange_juice.png', category: 'العصائر'),
        MenuItem(name: 'ماء', price: '0', image: 'assets/images/water.png', category: 'المشروبات'),
      ],
    ),
    Restaurant(
      name: 'مطعم العمدة',
      googleRating: 4.7,
      image: 'assets/images/omda.jpeg',
      gallery: [
  'assets/images/omda1.png',
  'assets/images/omda2.png',
  'assets/images/omda3.png',
],
      subtitle: 'مشويات وأكلات مصرية',
      type: 'مطاعم',
      category: 'مصري',
      tags: ['مطاعم', 'مصري', 'مشويات', 'كفتة', 'حواوشي', 'ملوخية', 'شعبي'],
      categories: ['المشويات', 'الأطباق المصرية', 'السندوتشات', 'المشروبات'],
      menu: [
        MenuItem(name: 'كفتة مشوية', price: '0', image: 'assets/images/omda_kofta.png', category: 'المشويات'),
        MenuItem(name: 'طرب مشوي', price: '0', image: 'assets/images/omda_tarb.png', category: 'المشويات'),
        MenuItem(name: 'ملوخية', price: '0', image: 'assets/images/molokhia.png', category: 'الأطباق المصرية'),
        MenuItem(name: 'حواوشي', price: '0', image: 'assets/images/hawawshi.png', category: 'السندوتشات'),
        MenuItem(name: 'بيبسي', price: '0', image: 'assets/images/cola.png', category: 'المشروبات'),
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
          title: Text(t.egyptianRestaurants),
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
                      width: 80,height: 80,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported),
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