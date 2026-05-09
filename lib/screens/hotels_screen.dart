import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';

class Hotel {
  final String name;
  final String image;
  final String description;
  final String price;
  final String rating;
  final String category;
  final List<String> tags;
  final double googleRating;


  const Hotel({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.tags,
   this.googleRating = 5.0,

  });
}

class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  static const List<Hotel> hotels = [
    Hotel(
      name: 'فندق ميلينيوم حائل',
            googleRating: 4.7,

      image: 'assets/images/millennium_hail.jpg',
      description:
          'فندق 5 نجوم مناسب للعائلات ورجال الأعمال، ويضم مرافق فندقية وخدمات راقية.',
      price: 'ابتداءً من 399 ر.س تقريباً',
      rating: '8.5',
      category: 'فاخر',
      tags: ['فنادق', 'فندق', 'إقامة', 'فاخر', '5 نجوم', 'عائلي', 'رجال أعمال'],
    ),
    Hotel(
      name: 'فندق سكناي رويال',
            googleRating: 4.7,

      image: 'assets/images/suknai_royal.jpg',
      description:
          'فندق مميز قريب من جامعة حائل وبحيرة أجا، مناسب للإقامة الهادئة.',
      price: 'ابتداءً من 568 ر.س تقريباً',
      rating: '8.3',
      category: 'هادئ',
      tags: ['فنادق', 'فندق', 'إقامة', 'هادئ', 'عائلي', 'جامعة حائل'],
    ),
    Hotel(
      name: 'مستقر للشقق المخدومة - النقرة',
            googleRating: 4.7,

      image: 'assets/images/mostaqar.jpeg',
      description:
          'شقق مخدومة قريبة من ملعب حائل وقلعة أعيرف، مناسبة للعائلات.',
      price: 'ابتداءً من 240 ر.س تقريباً',
      rating: '8.3',
      category: 'شقق مخدومة',
      tags: ['فنادق', 'شقق', 'إقامة', 'اقتصادي', 'عائلي', 'قلعة أعيرف'],
    ),
    Hotel(
      name: 'ديزرت روز',
            googleRating: 4.7,

      image: 'assets/images/desert_rose.jpg',
      description:
          'إقامة فندقية توفر مطعماً وحديقة وخدمة غرف، قريبة نسبياً من مطار حائل.',
      price: 'يتغير حسب تاريخ الحجز',
      rating: 'جيد',
      category: 'إقامة فندقية',
      tags: ['فنادق', 'إقامة', 'حديقة', 'مطعم', 'خدمة غرف', 'مطار'],
    ),
    Hotel(
      name: 'دولف للشقق الفندقية',
            googleRating: 4.7,

      image: 'assets/images/doolv.jpeg',
      description:
          'شقق فندقية مع مسبح خارجي ومواقف مجانية، مناسبة للإقامة الاقتصادية.',
      price: 'ابتداءً من 200 ر.س تقريباً',
      rating: '7.9',
      category: 'شقق فندقية',
      tags: ['فنادق', 'شقق', 'إقامة', 'اقتصادي', 'مسبح', 'مواقف'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F4EF),
        appBar: AppBar(
          title: Text(t.hotels),
          centerTitle: true,
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: hotels.length,
          separatorBuilder: (_,__ ) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final hotel = hotels[index];
            return _HotelCard(hotel: hotel);
          },
        ),
      ),
    );
  }
}

class _HotelCard extends StatelessWidget {
  final Hotel hotel;

  const _HotelCard({
    required this.hotel,
  });

  Future<void> _toggleFavorite(
  List<Map<String, String>> favs,
) async {
  final isFav = favs.any(
    (item) => item['title'] == hotel.name,
  );

  if (isFav) {
    await FavoritesService.removeFavorite(
      hotel.name,
    );
  } else {
    await FavoritesService.addFavorite({
      'title': hotel.name,
      'image': hotel.image,
      'subtitle': hotel.description,
      'type': 'فنادق',
      'category': hotel.category,
      'tags': hotel.tags.join(','),
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  hotel.image,
                  width: 95,
                  height: 95,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 95,
                    height: 95,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.hotel, size: 38),
                  ),
                ),
              ),
              Positioned(
                top: 6,
                left: 6,
                child: ValueListenableBuilder<List<Map<String, String>>>(
                  valueListenable: FavoritesService.favorites,
                  builder: (context, favs, _) {
                    final isFav =
                        favs.any((item) => item['title'] == hotel.name);
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
                  hotel.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 6),
                Text(
                  hotel.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        hotel.price,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8A4B00),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 3),
                    Text(
                      hotel.rating,
                      style: const TextStyle(fontSize: 13),
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