import 'package:flutter/material.dart';

import '../models/restaurant_model.dart';
import 'restaurant_menu_screen.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';

class AmericanRestaurantsScreen extends StatelessWidget {
  const AmericanRestaurantsScreen({super.key});

  static const List<Restaurant> restaurants = [
    Restaurant(
      name: 'مطعم أبل بيز',
      image: 'assets/images/applebees.png',
      subtitle: 'أمريكي، برجر، باستا وستيك',
      type: 'مطاعم',
      category: 'أمريكي',
      tags: ['مطاعم', 'أمريكي', 'برجر', 'ستيك', 'باستا', 'عشاء', 'فاست فود'],
      categories: ['المقبلات', 'البرجر', 'الستيك', 'الباستا', 'الحلى'],
      menu: [
        MenuItem(
          name: 'فيلادلفيا تشيزستيك كاساديا',
          price: '75',
          image: 'assets/images/applebees_quesadilla.png',
          category: 'المقبلات',
        ),
        MenuItem(
          name: 'ذا سامبلر',
          price: '75',
          image: 'assets/images/applebees_sampler.png',
          category: 'المقبلات',
        ),
      ],
    ),

    Restaurant(
      name: 'كنتاكي',
      image: 'assets/images/kfc.jpeg',
      subtitle: 'دجاج مقلي وسندويتشات',
      type: 'مطاعم',
      category: 'أمريكي',
      tags: ['مطاعم', 'أمريكي', 'دجاج', 'مقلي', 'فاست فود'],
      categories: ['السندويتشات', 'الوجبات'],
      menu: [
        MenuItem(
          name: 'كرنشر ساندويتش',
          price: '14',
          image: 'assets/images/kfc_cruncher.png',
          category: 'السندويتشات',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(loc.americanRestaurants),
          centerTitle: true,
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: restaurants.length,
          separatorBuilder: (_,__ ) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final restaurant = restaurants[index];

            return _RestaurantCard(
              restaurant: restaurant,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RestaurantMenuScreen(
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

  void _toggleFavorite(List<Map<String, String>> favs) {
    final isFav = favs.any(
      (item) => item['title'] == restaurant.name,
    );

    if (isFav) {
      FavoritesService.favorites.value = List.from(favs)
        ..removeWhere(
          (item) => item['title'] == restaurant.name,
        );
    } else {
      FavoritesService.favorites.value = List.from(favs)
        ..add({
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
                  child: Image.asset(restaurant.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __ , ___) => Container(
                      width: 80,
                      height: 80,
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
                            isFav
                                ? Icons.favorite
                                : Icons.favorite_border,
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
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
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