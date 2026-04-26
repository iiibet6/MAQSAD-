import 'package:flutter/material.dart';
import 'place_details_screen.dart';
import '../models/place_model.dart';
import '../services/favorites_service.dart';
import '../l10n/app_localizations.dart';

class NaturePlacesScreen extends StatelessWidget {
  const NaturePlacesScreen({super.key});

  static final List<Place> places = [
    Place(
      title: 'منازل حاتم الطائي',
      image: 'assets/images/hatem_house.png',
      description: 'رمز الكرم العربي في حائل',
      workingHours: 'مفتوح طوال الوقت',
      modelPath: 'assets/models/hatems_home.glb',
      category: 'تاريخي',
      locationName: 'توارن - حائل',
      latitude: 27.5600,
      longitude: 41.6900,
    ),

    Place(
      title: 'قلعة أعيرف',
      image: 'assets/images/aref.png',
      description: 'من أقدم القلاع التاريخية في حائل',
      workingHours: 'مفتوح طوال الوقت',
      modelPath: 'assets/models/aref_castle.glb',
      category: 'تاريخي',
      locationName: 'حائل',
      latitude: 27.5219,
      longitude: 41.6905,
    ),

    Place(
      title: 'جبل محجة',
      image: 'assets/images/mhaja.png',
      description: 'موقع طبيعي مميز في حائل',
      workingHours: 'مفتوح طوال الوقت',
      modelPath: 'assets/models/example.glb',
      category: 'طبيعي',
      locationName: 'حائل',
      latitude: 27.5114,
      longitude: 41.7208,
    ),
  ];

  List<Place> _places(AppLocalizations t) => [
        Place(
          title: t.hatimHouse,
          image: 'assets/images/hatem_house.png',
          description: t.hatimHouseFullDescription,
          workingHours: t.openAllDay,
          modelPath: 'assets/models/hatems_home.glb',
          category: t.historical,
          locationName: t.hatimHouseLocation,
          latitude: 27.5600,
          longitude: 41.6900,
        ),

        Place(
          title: t.aerifCastle,
          image: 'assets/images/aref.png',
          description: t.aerifCastleFullDescription,
          workingHours: t.openAllDay,
          modelPath: 'assets/models/aref_castle.glb',
          category: t.historical,
          locationName: t.aerifCastleLocation,
          latitude: 27.5219,
          longitude: 41.6905,
        ),

        Place(
          title: t.mahjaMountain,
          image: 'assets/images/mhaja.png',
          description: t.mahjaMountainDescription,
          workingHours: t.openAllDay,
          modelPath: 'assets/models/example.glb',
          category: t.natural,
          locationName: t.hail,
          latitude: 27.5114,
          longitude: 41.7208,
        ),

        Place(
          title: t.oqdahTouristArea,
          image: 'assets/images/oqda.png',
          description: t.oqdahTouristAreaDescription,
          workingHours: t.openAllDay,
          modelPath: 'assets/models/example.glb',
          category: t.natural,
          locationName: t.hail,
          latitude: 27.5300,
          longitude: 41.7000,
        ),

        Place(
          title: t.faydHistoricalCity,
          image: 'assets/images/fayd.png',
          description: t.faydHistoricalCityDescription,
          workingHours: t.openAllDay,
          modelPath: 'assets/models/example.glb',
          category: t.historical,
          locationName: t.faydLocation,
          latitude: 27.4430,
          longitude: 42.1040,
        ),

        Place(
          title: t.masharPark,
          image: 'assets/images/mashar.png',
          description: t.masharParkDescription,
          workingHours: t.masharWorkingHours,
          modelPath: 'assets/models/example.glb',
          category: t.natural,
          locationName: t.hail,
          latitude: 27.5200,
          longitude: 41.7500,
        ),

        Place(
          title: t.tawaranValley,
          image: 'assets/images/Twarn.jpg',
          description: t.tawaranValleyDescription,
          workingHours: t.openAllDay,
          modelPath: 'assets/models/aref_castle.glb',
          category: t.natural,
          locationName: t.tawaranLocation,
          latitude: 27.5219,
          longitude: 41.6905,
        ),
      ];@override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final places = _places(t);

    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            t.natureAndTourismPlaces,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFE8EDF3),
                Color(0xFFD9E1EC),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),

              child: GridView.builder(
                itemCount: places.length,

                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),

                itemBuilder: (context, index) {
                  return _PlaceCard(
                    place: places[index],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  final Place place;

  const _PlaceCard({
    required this.place,
  });

  String _subtitle(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    if (place.category == t.historical) {
      return t.historicalTouristLandmark;
    }

    return t.naturalTouristDestination;
  }

  void _toggleFavorite(
    BuildContext context,
    List<Map<String, String>> favs,
  ) {
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
          'subtitle': _subtitle(context),
          'type': AppLocalizations.of(context)!.tourism,
          'category': place.category,
          'tags':
              '${AppLocalizations.of(context)!.tourism},${place.category}',
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
            builder: (_) => PlaceDetailsScreen(
              place: place,
            ),
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

                child:
                    ValueListenableBuilder<List<Map<String, String>>>(
                  valueListenable: FavoritesService.favorites,

                  builder: (context, favs, _) {
                    final isFav = favs.any(
                      (item) => item['title'] == place.title,
                    );

                    return GestureDetector(
                      onTap: () =>
                          _toggleFavorite(context, favs),child: Container(
                        padding: const EdgeInsets.all(6),

                        decoration: BoxDecoration(
                          color:
                              Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),

                        child: Icon(
                          isFav
                              ? Icons.favorite
                              : Icons.favorite_border,

                          color:
                              isFav ? Colors.red : Colors.grey,

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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8),

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