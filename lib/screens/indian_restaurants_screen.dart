import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../models/restaurant_model.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';
import 'restaurant_details_screen.dart';

class IndianRestaurantsScreen extends StatelessWidget {
  const IndianRestaurantsScreen({super.key});

  static const List<Restaurant> restaurants = [
Restaurant(
      name: 'مطعم تاج محل',
            googleRating: 4.7,

      image: 'assets/images/taj_mahal.jpeg',
      gallery: [
  'assets/images/taj_mahal1.png',
  'assets/images/taj_mahal2.png',
  'assets/images/taj_mahal3.png',
],
      subtitle: 'مطعم هندي كلاسيكي ومأكولات بحرية',
      type: 'مطاعم',
      category: 'هندي',
      tags: ['مطاعم', 'هندي', 'برياني', 'دجاج', 'روبيان', 'بهارات', 'حار'],
      categories: ['المقبلات', 'الدجاج', 'البرياني', 'المشروبات'],
      menu: [
        MenuItem(name: 'كوكتيل روبيان', price: '55', image: 'assets/images/taj_shrimp_cocktail.png', category: 'المقبلات'),
        MenuItem(name: 'روبيان كوليوادا', price: '45', image: 'assets/images/taj_shrimp_koliwada.png', category: 'المقبلات'),
        MenuItem(name: 'دجاج شنغهاي', price: '28', image: 'assets/images/taj_shanghai_chicken.png', category: 'الدجاج'),
        MenuItem(name: 'لولي بوب دجاج', price: '28', image: 'assets/images/taj_lollipop.png', category: 'الدجاج'),
        MenuItem(name: 'دجاج 65', price: '0', image: 'assets/images/taj_chicken65.png', category: 'الدجاج'),
      ],
    ),
    Restaurant(
      name: 'مطعم بهارات المذاق الهندي',
            googleRating: 4.7,

      image: 'assets/images/buharat.png',
       gallery: [
  'assets/images/buharat1.png',
  'assets/images/buharat2.png',
  'assets/images/buharat3.png',
],
      subtitle: 'أطباق هندية ومشويات وفخار',
      type: 'مطاعم',
      category: 'هندي',
      tags: ['مطاعم', 'هندي', 'بهارات', 'مشويات', 'فخار', 'كباب', 'حار'],
      categories: ['المشويات', 'الفخار', 'الأطباق الرئيسية', 'الحلى'],
      menu: [
        MenuItem(name: 'طبق كباب الإمبراطور', price: '55.5', image: 'assets/images/buharat_emperor.png', category: 'المشويات'),
        MenuItem(name: 'دجاج فخار', price: '46', image: 'assets/images/buharat_chicken_pot.png', category: 'الفخار'),
        MenuItem(name: 'لحم فخار', price: '48.5', image: 'assets/images/buharat_meat_pot.png', category: 'الفخار'),
        MenuItem(name: 'كباب دجاج عربي', price: '50', image: 'assets/images/buharat_chicken_kebab.png', category: 'المشويات'),
        MenuItem(name: 'لحم كباب عربي', price: '58', image: 'assets/images/buharat_meat_kebab.png', category: 'المشويات'),
        MenuItem(name: 'أم علي', price: '16', image: 'assets/images/um_ali.png', category: 'الحلى'),
        MenuItem(name: 'جولاب جومون', price: '13', image: 'assets/images/gulab_jamun.png', category: 'الحلى'),
      ],
    ),
    Restaurant(
      name: 'مطعم عرفة دربار',
            googleRating: 4.7,

      image: 'assets/images/arafa_darbar.jpeg',
       gallery: [
  'assets/images/arafa_darbar1.png',
  'assets/images/arafa_darbar2.png',
  'assets/images/arafa_darbar3.png',
],
      subtitle: 'برياني وتندوري ومأكولات هندية',
      type: 'مطاعم',
      category: 'هندي',
      tags: ['مطاعم', 'هندي', 'برياني', 'تندوري', 'كباب', 'نودلز', 'حار'],
      categories: ['البرياني', 'التندوري', 'النودلز', 'المشويات'],
      menu: [
        MenuItem(name: 'وعاء برياني دجاج', price: '52', image: 'assets/images/arafa_chicken_biryani.png', category: 'البرياني'),
        MenuItem(name: 'وعاء برياني لحم حيدر آباد', price: '0', image: 'assets/images/arafa_meat_biryani.png', category: 'البرياني'),
        MenuItem(name: 'دجاج تندوري مشكل - كبير', price: '80', image: 'assets/images/arafa_tandoori_mix.png', category: 'التندوري'),
        MenuItem(name: 'دجاج تندوري مشكل - صغير', price: '55', image: 'assets/images/arafa_tandoori_small.png', category: 'التندوري'),
        MenuItem(name: 'دجاج كباب مالاي', price: '30.3', image: 'assets/images/arafa_malai_kebab.png', category: 'المشويات'),
        MenuItem(name: 'دجاج تندوري لولي بوب', price: '26', image: 'assets/images/arafa_lollipop.png', category: 'التندوري'),
        MenuItem(name: 'دجاج تكا', price: '28.7', image: 'assets/images/arafa_tikka.png', category: 'التندوري'),
        MenuItem(name: 'المعكرونة بالخضار', price: '19', image: 'assets/images/arafa_veg_noodles.png', category: 'النودلز'),
        MenuItem(name: 'المعكرونة المشكلة', price: '30', image: 'assets/images/arafa_mix_noodles.png', category: 'النودلز'),
      ],
    ),
    Restaurant(
      name: 'مطعم أنان',
            googleRating: 4.7,

      image: 'assets/images/anaan.jpeg',
       gallery: [
  'assets/images/anaan1.png',
  'assets/images/anaan2.png',
  'assets/images/anaan3.png',
],
      subtitle: 'رولات تكا وبرياني بطريقة عصرية',
      type: 'مطاعم',
      category: 'هندي',
      tags: ['مطاعم', 'هندي', 'رولات', 'تكا', 'برياني', 'سبايسي', 'عصري'],
      categories: ['الرولات', 'البرياني', 'البروتين'],
      menu: [
        MenuItem(name: 'تكا رول عادي', price: '10.5', image: 'assets/images/anaan_tikka_roll.png', category: 'الرولات'),
        MenuItem(name: 'تكا رول سبايسي', price: '10.5', image: 'assets/images/anaan_spicy_roll.png', category: 'الرولات'),
        MenuItem(name: 'سيجنتشر تكا رول', price: '11.5', image: 'assets/images/anaan_signature_roll.png', category: 'الرولات'),
        MenuItem(name: 'برياني دجاج - بارد', price: '19', image: 'assets/images/anaan_biryani_mild.png', category: 'البرياني'),
        MenuItem(name: 'برياني دجاج - حار', price: '19', image: 'assets/images/anaan_biryani_spicy.png', category: 'البرياني'),
        MenuItem(name: 'تكا بروتين - بارد', price: '19', image: 'assets/images/anaan_protein_mild.png', category: 'البروتين'),
        MenuItem(name: 'تكا بروتين - حار', price: '19', image: 'assets/images/anaan_protein_spicy.png', category: 'البروتين'),
      ],
    ),
    Restaurant(
      name: 'مطعم كومار',
            googleRating: 4.7,

      image: 'assets/images/kumar.jpeg',
      gallery: [
  'assets/images/kumar1.png',
  'assets/images/kumar2.png',
  'assets/images/kumar3.png',
],
      subtitle: 'تجربة هندية عصرية وأطباق مميزة',
      type: 'مطاعم',
      category: 'هندي',
      tags: ['مطاعم', 'هندي', 'عصري', 'دجاج بالزبدة', 'كباب', 'سلطات', 'تندوري'],
      categories: ['المقبلات', 'الأطباق الرئيسية', 'السلطات', 'الإضافات'],
      menu: [
        MenuItem(name: 'سلطة الجرجير الخاصة بكومار', price: '45', image: 'assets/images/kumar_rocket_salad.png', category: 'السلطات'),
        MenuItem(name: 'سلطة الذرة الخاصة من كومار', price: '40', image: 'assets/images/kumar_corn_salad.png', category: 'السلطات'),
        MenuItem(name: 'سلطة كومار تشيكن سيزر', price: '40', image: 'assets/images/kumar_caesar.png', category: 'السلطات'),
        MenuItem(name: 'رايتا', price: '10', image: 'assets/images/kumar_raita.png', category: 'الإضافات'),
        MenuItem(name: 'مومباي بفز', price: '24', image: 'assets/images/kumar_mumbai_puffs.png', category: 'المقبلات'),
        MenuItem(name: 'دجاج بالزبدة تاكو', price: '34', image: 'assets/images/kumar_butter_taco.png', category: 'المقبلات'),
        MenuItem(name: 'كوبيدي تندوري كباب', price: '72', image: 'assets/images/kumar_kebab.png', category: 'الأطباق الرئيسية'),
        MenuItem(name: 'دجاج بالزبدة سجنتشر', price: '67', image: 'assets/images/kumar_butter_chicken.png', category: 'الأطباق الرئيسية'),
        MenuItem(name: 'الدجاج كاداي', price: '67', image: 'assets/images/kumar_kadai_chicken.png', category: 'الأطباق الرئيسية'),
      ],
    ),  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            t.indianRestaurants,
            style: AppTextStyles.headline2,
          ),
          centerTitle: true,
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
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
                        );

                        return GestureDetector(
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
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.right,
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

