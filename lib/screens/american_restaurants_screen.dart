import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../models/restaurant_model.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';
import 'restaurant_details_screen.dart';

class AmericanRestaurantsScreen extends StatelessWidget {
  const AmericanRestaurantsScreen({super.key});

  static const List<Restaurant> restaurants = [
    Restaurant(
      name: 'مطعم أبل بيز',
      googleRating: 4.7,
      image: 'assets/images/applebees.png',
      gallery: [
        'assets/images/applebees1.png',
        'assets/images/applebees2.png',
        'assets/images/applebees3.png',
      ],
      subtitle: 'أمريكي، برجر، باستا وستيك',
      type: 'مطاعم',
      category: 'أمريكي',
      description: 'وجهة لعشاق المطبخ الأمريكي في حائل، يقدم أبل بيز تشكيلة متنوعة من الأطباق الشهية في أجواء عصرية تناسب العائلات والأصدقاء.',
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
      googleRating: 4.5,
      image: 'assets/images/kfc.jpeg',
      gallery: [
        'assets/images/kfc1.png',
        'assets/images/kfc2.png',
        'assets/images/kfc3.png',
      ],
      subtitle: 'دجاج مقلي وسندويتشات',
      type: 'مطاعم',
      category: 'أمريكي',
      description: ' اشهر وجهات الدجاج المقرمش في العالم، يقدم كنتاكي تجربة مميزة لعشاق الوجبات السريعة من خلال وصفته الشهيرة للدجاج المقلي والساندويتشات المتنوعة، في أجواء مناسبة للعائلات والأصدقاء. ويُعد من المطاعم المفضلة للباحثين عن وجبة سريعة بطابع أمريكي مميز.',
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
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            loc.americanRestaurants,
            style: AppTextStyles.headline2,
          ),
          centerTitle: true,
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: restaurants.length,separatorBuilder: (_, __) => const SizedBox(height: 16),
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

  Future<void> _toggleFavorite(List<Map<String, String>> favs) async {
    final isFav = favs.any(
      (item) => item['title'] == restaurant.name,
    );

    if (isFav) {
      await FavoritesService.removeFavorite(restaurant.name);
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
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.divider),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.07),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      restaurant.image,
                      width: 88,
                      height: 88,
                      fit: BoxFit.cover,
                      errorBuilder: (_,__ , ___) => Container(
                        width: 88,
                        height: 88,
                        color: AppColors.background,
                        child: const Icon(
                          Icons.image_not_supported,
                          color: AppColors.primary,
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
                          (item) => item['title'] == restaurant.name,
                        );return GestureDetector(
                          onTap: () => _toggleFavorite(favs),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.surface.withOpacity(0.92),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.10),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              size: 18,
                              color: isFav
                                  ? AppColors.deleteRed
                                  : AppColors.textSecondary,
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
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      restaurant.subtitle,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          restaurant.googleRating.toString(),
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.star_rounded,
                          color: AppColors.accent,
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}