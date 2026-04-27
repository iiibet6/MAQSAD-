import 'package:flutter/material.dart';

import '../models/restaurant_model.dart';
import 'restaurant_menu_screen.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';

class CafesScreen extends StatelessWidget {
  const CafesScreen({super.key});

  static const List<Restaurant> cafes = [
    Restaurant(
      name: 'ساكورا',
      image: 'assets/images/sakura.jpeg',
      subtitle: 'قهوة مختصة ومخبوزات',
      type: 'مقاهي',
      category: 'قهوة مختصة',
      tags: ['مقاهي', 'قهوة', 'مختصة', 'مخبوزات', 'V60', 'هادئ', 'حلويات'],
      categories: ['القهوة', 'المشروبات الباردة', 'المخبوزات', 'البوكسات'],
      menu: [
        MenuItem(name: 'قهوة اليوم حار', price: '8', image: 'assets/images/sakura_hot_coffee.png', category: 'القهوة'),
        MenuItem(name: 'قهوة اليوم بارد', price: '8', image: 'assets/images/sakura_ice_coffee.png', category: 'المشروبات الباردة'),
        MenuItem(name: 'V60 حار', price: '16', image: 'assets/images/sakura_v60.png', category: 'القهوة'),
        MenuItem(name: 'V60 بارد', price: '16', image: 'assets/images/sakura_ice_v60.png', category: 'المشروبات الباردة'),
        MenuItem(name: 'أمريكانو حار', price: '14', image: 'assets/images/sakura_americano.png', category: 'القهوة'),
        MenuItem(name: 'فلات وايت', price: '14', image: 'assets/images/sakura_flatwhite.png', category: 'القهوة'),
        MenuItem(name: 'ميني كروسان لوز', price: '7', image: 'assets/images/sakura_croissant.png', category: 'المخبوزات'),
        MenuItem(name: 'بوكس كركديه كبير ٢ لتر', price: '69', image: 'assets/images/sakura_karkadeh_box.png', category: 'البوكسات'),
      ],
    ),
    Restaurant(
      name: 'سنس',
      image: 'assets/images/sns.jpeg',
      subtitle: 'قهوة وحلويات وبوكسات',
      type: 'مقاهي',
      category: 'قهوة وحلويات',
      tags: ['مقاهي', 'قهوة', 'حلويات', 'بوكسات', 'ماتشا', 'فرنش توست', 'كوفي'],
      categories: ['العروض', 'القهوة', 'الحلويات', 'البوكسات'],
      menu: [
        MenuItem(name: 'كيكة التمر بالبيكان + بوكس قهوة اليوم ٢ لتر', price: '89', image: 'assets/images/sns_date_cake_offer.png', category: 'العروض'),
        MenuItem(name: 'بوكس محاصيل سنس', price: '129', image: 'assets/images/sns_crop_box.png', category: 'البوكسات'),
        MenuItem(name: 'سويت اوفر', price: '28', image: 'assets/images/sns_sweet_over.png', category: 'الحلويات'),
        MenuItem(name: 'فرنش توست مليت اوفر', price: '25', image: 'assets/images/sns_french_toast.png', category: 'الحلويات'),
        MenuItem(name: 'بوكس قهوة اليوم', price: '49', image: 'assets/images/sns_coffee_box.png', category: 'البوكسات'),
        MenuItem(name: 'بوكس ماتشا بارد', price: '55', image: 'assets/images/sns_matcha_box.png', category: 'البوكسات'),
        MenuItem(name: 'اسبرسو', price: '10', image: 'assets/images/sns_espresso.png', category: 'القهوة'),
        MenuItem(name: 'أمريكانو', price: '13', image: 'assets/images/sns_americano.png', category: 'القهوة'),
      ],
    ),
    Restaurant(
      name: 'إلتون',
      image: 'assets/images/ltone.jpeg',
      subtitle: 'محمصة وقهوة مختصة',
      type: 'مقاهي',
      category: 'قهوة مختصة',
      tags: ['مقاهي', 'قهوة', 'مختصة', 'محمصة', 'محاصيل', 'V60', 'بوكسات'],
      categories: ['القهوة', 'المحاصيل', 'البوكسات'],
      menu: [
        MenuItem(name: 'قهوة اليوم', price: '0', image: 'assets/images/ltone_daily.png', category: 'القهوة'),
        MenuItem(name: 'V60', price: '0', image: 'assets/images/ltone_v60.png', category: 'القهوة'),
        MenuItem(name: 'كولومبيا لافريسا', price: '0', image: 'assets/images/ltone_colombia.png', category: 'المحاصيل'),
        MenuItem(name: 'إندونيسيا وانويا', price: '0', image: 'assets/images/ltone_indonesia.png', category: 'المحاصيل'),
        MenuItem(name: 'البوكس الفاكهي', price: '0', image: 'assets/images/ltone_fruity_box.png', category: 'البوكسات'),
      ],
    ),
    Restaurant(
      name: 'ناف',
      image: 'assets/images/naf.png',
      subtitle: 'قهوة مختصة ومنتجات',
      type: 'مقاهي',
      category: 'قهوة مختصة',tags: ['مقاهي', 'قهوة', 'مختصة', 'لاتيه', 'بارد', 'منتجات'],
      categories: ['القهوة', 'المشروبات الباردة', 'المنتجات'],
      menu: [
        MenuItem(name: 'قهوة اليوم', price: '0', image: 'assets/images/naf_daily.png', category: 'القهوة'),
        MenuItem(name: 'لاتيه', price: '0', image: 'assets/images/naf_latte.png', category: 'القهوة'),
        MenuItem(name: 'آيس لاتيه', price: '0', image: 'assets/images/naf_ice_latte.png', category: 'المشروبات الباردة'),
        MenuItem(name: 'NAF Okeanos Bottle 500ml', price: '0', image: 'assets/images/naf_bottle.png', category: 'المنتجات'),
      ],
    ),
    Restaurant(
      name: 'ساوث',
      image: 'assets/images/south.png',
      subtitle: 'قهوة وحلويات',
      type: 'مقاهي',
      category: 'قهوة وحلويات',
      tags: ['مقاهي', 'قهوة', 'لاتيه', 'سبانش لاتيه', 'حلويات', 'كوكيز'],
      categories: ['القهوة', 'المشروبات الباردة', 'الحلويات'],
      menu: [
        MenuItem(name: 'أمريكانو', price: '0', image: 'assets/images/south_americano.png', category: 'القهوة'),
        MenuItem(name: 'لاتيه', price: '0', image: 'assets/images/south_latte.png', category: 'القهوة'),
        MenuItem(name: 'آيس سبانش لاتيه', price: '0', image: 'assets/images/south_spanish.png', category: 'المشروبات الباردة'),
        MenuItem(name: 'كوكيز', price: '0', image: 'assets/images/south_cookies.png', category: 'الحلويات'),
      ],
    ),
    Restaurant(
      name: 'رواية',
      image: 'assets/images/riwaya.png',
      subtitle: 'قهوة وأجواء هادئة',
      type: 'مقاهي',
      category: 'قهوة هادئة',
      tags: ['مقاهي', 'قهوة', 'هادئ', 'جلسات', 'كورتادو', 'كيك', 'قراءة'],
      categories: ['القهوة', 'المشروبات الباردة', 'الحلويات'],
      menu: [
        MenuItem(name: 'قهوة اليوم', price: '0', image: 'assets/images/riwaya_daily.png', category: 'القهوة'),
        MenuItem(name: 'كورتادو', price: '0', image: 'assets/images/riwaya_cortado.png', category: 'القهوة'),
        MenuItem(name: 'آيس لاتيه', price: '0', image: 'assets/images/riwaya_ice_latte.png', category: 'المشروبات الباردة'),
        MenuItem(name: 'كيك', price: '0', image: 'assets/images/riwaya_cake.png', category: 'الحلويات'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.cafes),
          centerTitle: true,
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: cafes.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final cafe = cafes[index];

            return _CafeCard(
              cafe: cafe,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RestaurantMenuScreen(
                      restaurant: cafe,
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

class _CafeCard extends StatelessWidget {
  final Restaurant cafe;
  final VoidCallback onTap;

  const _CafeCard({
    required this.cafe,
    required this.onTap,
  });

  Future<void> _toggleFavorite(
  List<Map<String, String>> favs,
) async {
  final isFav = favs.any(
    (item) => item['title'] == cafe.name,
  );

  if (isFav) {
    await FavoritesService.removeFavorite(
      cafe.name,
    );
  } else {
    await FavoritesService.addFavorite({
      'title': cafe.name,
      'image': cafe.image,
      'subtitle': cafe.subtitle,
      'type': cafe.type,
      'category': cafe.category,
      'tags': cafe.tags.join(','),
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
                    cafe.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_,__ , ___) => Container(
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
                        (item) => item['title'] == cafe.name,
                      );return GestureDetector(
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
                    cafe.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cafe.subtitle,
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