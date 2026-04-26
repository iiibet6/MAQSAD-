import 'package:flutter/material.dart';
import '../models/place_model.dart';
import 'place_details_screen.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';

class ChaletsScreen extends StatelessWidget {
  const ChaletsScreen({super.key});

  static final List<Place> chalets = [
    Place(
      title: 'ريف الطوالة',
      image: 'assets/images/reef_tuwala.jpg',
      description:
          'منتجع ريف الطوالة من الوجهات الهادئة في حائل، يوفر جلسات خاصة وأجواء طبيعية مناسبة للعائلات.',
      workingHours: 'على مدار الساعة',
      modelPath: 'assets/models/example.glb',
      category: 'شاليهات ومنتجعات',
      locationName: 'الطوالة - حائل',
      latitude: 27.9152673,
      longitude: 41.6834382,
    ),
    Place(
      title: 'الماسية',
      image: 'assets/images/almasia.jpg',
      description:
          'شاليه الماسية من الوجهات الفاخرة في حائل، يوفر جلسات خاصة ومسبح وأجواء هادئة مناسبة للعائلات.',
      workingHours: 'على مدار الساعة',
      modelPath: 'assets/models/example.glb',
      category: 'شاليهات ومنتجعات',
      locationName: 'حائل',
      latitude: 27.900000,
      longitude: 41.700000,
      plusCode: "7HV39HRC+5H",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(t.chaletsAndResorts),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: chalets.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final place = chalets[index];
            return _ChaletCard(place: place);
          },
        ),
      ),
    );
  }
}

class _ChaletCard extends StatelessWidget {
  final Place place;

  const _ChaletCard({
    required this.place,
  });

  List<String> get _tags {
    switch (place.title) {
      case 'ريف الطوالة':
        return [
          'شاليهات',
          'منتجع',
          'طبيعة',
          'هدوء',
          'عائلات',
          'جلسات',
          'استرخاء',
        ];

      case 'الماسية':
        return [
          'شاليهات',
          'فاخر',
          'مسبح',
          'عائلات',
          'منتجع',
          'جلسات خاصة',
          'استجمام',
        ];

      default:
        return [
          'شاليهات',
          'منتجع',
        ];
    }
  }

  String get _subtitle {
    switch (place.title) {
      case 'ريف الطوالة':
        return 'منتجع هادئ بأجواء طبيعية';

      case 'الماسية':
        return 'شاليه فاخر مع مسبح';

      default:
        return 'شاليهات ومنتجعات';
    }
  }

  void _toggleFavorite(List<Map<String, String>> favs) {
    final isFav = favs.any(
      (item) => item['title'] == place.title,
    );

    if (isFav) {
      FavoritesService.favorites.value = List.from(favs)
        ..removeWhere(
          (item) => item['title'] == place.title,
        );
    } else {
      FavoritesService.favorites.value = List.from(favs)
        ..add({
          'title': place.title,
          'image': place.image,
          'subtitle': _subtitle,
          'type': 'شاليهات',
          'category': 'منتجع',
          'tags': _tags.join(','),
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlaceDetailsScreen(place: place),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  place.image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: ValueListenableBuilder<List<Map<String, String>>>(
                  valueListenable: FavoritesService.favorites,
                  builder: (context, favs, _) {
                    final isFav = favs.any(
                      (item) => item['title'] == place.title,
                    );

                    return GestureDetector(
                      onTap: () => _toggleFavorite(favs),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.grey,
                          size: 18,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.white,
                  child: Text(
                    place.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}