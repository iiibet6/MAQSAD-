import 'package:flutter/material.dart';

import '../models/restaurant_model.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';
import 'restaurant_details_screen.dart';

class ItalianRestaurantsScreen extends StatelessWidget {
  const ItalianRestaurantsScreen({super.key});

  static const List<Restaurant> restaurants = [
    Restaurant(
      name: 'بيكوال',
      image: 'assets/images/picual.jpeg',
      gallery: [
  'assets/images/picual1.png',
  'assets/images/picual2.png',
  'assets/images/picual3.png',
],
      subtitle: 'نكهات إيطالية وباستا وبيتزا',
      type: 'مطاعم',
      category: 'إيطالي',
      tags: ['مطاعم', 'إيطالي', 'بيتزا', 'باستا', 'ترافل', 'عشاء'],
      categories: ['البيتزا', 'الباستا', 'الصوصات'],
      menu: [
        MenuItem(name: 'بيتزا مارجريتا', price: '38', image: 'assets/images/picual_margherita.png', category: 'البيتزا'),
        MenuItem(name: 'بيتزا روكا', price: '40', image: 'assets/images/picual_rocca.png', category: 'البيتزا'),
        MenuItem(name: 'باستا تشيكن بيستو', price: '41', image: 'assets/images/picual_pesto.png', category: 'الباستا'),
        MenuItem(name: 'ترافل باستا', price: '39', image: 'assets/images/picual_truffle.png', category: 'الباستا'),
        MenuItem(name: 'بافلو صوص', price: '4', image: 'assets/images/sauce.png', category: 'الصوصات'),
      ],
    ),
    Restaurant(
      name: 'روقا روكو',
            googleRating: 4.7,

      image: 'assets/images/rougaro.png',
      gallery: [
  'assets/images/rougaro1.png',
  'assets/images/rougaro2.png',
  'assets/images/rougaro3.png',
],
      subtitle: 'تجربة إيطالية بطابع حائلي',
      type: 'مطاعم',
      category: 'إيطالي',
      tags: ['مطاعم', 'إيطالي', 'بيتزا', 'باستا', 'سلطات', 'عشاء'],
      categories: ['السلطات', 'البيتزا', 'الباستا', 'أوفن'],
      menu: [
        MenuItem(name: 'سلطة روكا', price: '0', image: 'assets/images/rugaroko_salad.png', category: 'السلطات'),
        MenuItem(name: 'بيتزا روكا', price: '0', image: 'assets/images/rugaroko_pizza.png', category: 'البيتزا'),
        MenuItem(name: 'باستا كريمية', price: '0', image: 'assets/images/rugaroko_pasta.png', category: 'الباستا'),
        MenuItem(name: 'طبق أوفن', price: '0', image: 'assets/images/rugaroko_oven.png', category: 'أوفن'),
      ],
    ),
    Restaurant(
      name: 'أوبالو',
            googleRating: 4.7,

      image: 'assets/images/opalo.jpeg',
       gallery: [
  'assets/images/opalo1.png',
  'assets/images/opalo2.png',
  'assets/images/opalo3.png',
],
      subtitle: 'بيتزا وباستا وروزيتو',
      type: 'مطاعم',
      category: 'إيطالي',
      tags: ['مطاعم', 'إيطالي', 'بيتزا', 'باستا', 'روزيتو', 'حلويات'],
      categories: ['السلطة', 'البيتزا', 'الباستا والروزيتو', 'الحلويات'],
      menu: [
        MenuItem(name: 'بيتروت فيتا تشيز رافيولي', price: '42', image: 'assets/images/opalo_salad.png', category: 'السلطة'),
        MenuItem(name: 'بوراتا', price: '0', image: 'assets/images/opalo_burrata.png', category: 'السلطة'),
        MenuItem(name: 'بيتزا أوبالو', price: '0', image: 'assets/images/opalo_pizza.png', category: 'البيتزا'),
        MenuItem(name: 'باستا إيطالية', price: '0', image: 'assets/images/opalo_pasta.png', category: 'الباستا والروزيتو'),
        MenuItem(name: 'تيراميسو إيطالي', price: '0', image: 'assets/images/opalo_tiramisu.png', category: 'الحلويات'),
      ],
    ),
    Restaurant(
      name: 'روما وي',
            googleRating: 4.7,

      image: 'assets/images/romaway.png',
       gallery: [
  'assets/images/romaway1.png',
  'assets/images/romaway2.png',
  'assets/images/romaway3.png',
],
      subtitle: 'بيتزا وباستا ولازانيا',
      type: 'مطاعم',
      category: 'إيطالي',
      tags: ['مطاعم', 'إيطالي', 'بيتزا', 'لازانيا', 'باستا', 'تيراميسو'],
      categories: ['العروض', 'البيتزا', 'الباستا', 'المقبلات', 'الحلويات'],
      menu: [
        MenuItem(name: 'بوكس الباستا', price: '95', image: 'assets/images/romaway_pasta_box.png', category: 'العروض'),
        MenuItem(name: 'بوكس لازانيا', price: '128', image: 'assets/images/romaway_lasagna_box.png', category: 'العروض'),
        MenuItem(name: 'بيتزا دجاج باربيكيو - وسط', price: '22', image: 'assets/images/romaway_bbq.png', category: 'البيتزا'),
        MenuItem(name: 'بيتزا مارجريتا - وسط', price: '22', image: 'assets/images/romaway_margherita.png', category: 'البيتزا'),
        MenuItem(name: 'مكرونة الدجاج', price: '32', image: 'assets/images/romaway_chicken_pasta.png', category: 'الباستا'),
        MenuItem(name: 'لازانيا', price: '26', image: 'assets/images/romaway_lasagna.png', category: 'الباستا'),
        MenuItem(name: 'خبز الثوم والجبن', price: '12', image: 'assets/images/romaway_garlic_bread.png', category: 'المقبلات'),
        MenuItem(name: 'تيراميسو', price: '12', image: 'assets/images/romaway_tiramisu.png', category: 'الحلويات'),
      ],
    ),
    Restaurant(
      name: 'مايسترو بيتزا',
            googleRating: 4.7,

      image: 'assets/images/maestro.png',
      gallery: [
  'assets/images/maestro1.png',
  'assets/images/maestro2.png',
  'assets/images/maestro3.png',
],
      subtitle: 'بيتزا سريعة وعروض متنوعة',
      type: 'مطاعم',
      category: 'إيطالي',
      tags: ['مطاعم', 'إيطالي', 'بيتزا', 'فاست فود', 'بيبروني', 'عروض'],
      categories: ['العروض', 'البيتزا الأصلية', 'اختيارات الشيف', 'المشروبات'],
      menu: [
        MenuItem(name: 'كومبو اللمة', price: '110', image: 'assets/images/maestro_combo.png', category: 'العروض'),
        MenuItem(name: 'مارغريتا بيتزا', price: '36', image: 'assets/images/maestro_margherita.png', category: 'البيتزا الأصلية'),
        MenuItem(name: 'بيبروني وسط', price: '46', image: 'assets/images/maestro_pepperoni.png', category: 'البيتزا الأصلية'),
        MenuItem(name: 'رانشي الأصلية', price: '46', image: 'assets/images/maestro_ranch.png', category: 'البيتزا الأصلية'),
        MenuItem(name: 'بيستو زيت الزيتون', price: '42', image: 'assets/images/maestro_pesto.png', category: 'اختيارات الشيف'),
        MenuItem(name: 'سبرايت 330 مل', price: '4', image: 'assets/images/sprite.png', category: 'المشروبات'),
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
          title: Text(t.italianRestaurants),
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