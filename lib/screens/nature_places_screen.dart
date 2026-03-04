import 'package:flutter/material.dart';
import 'place_details_screen.dart';
import '../models/place_model.dart';
import '../services/favorites_service.dart';

class NaturePlacesScreen extends StatelessWidget {
  const NaturePlacesScreen({super.key});

  /// ============================
  /// 📍 قائمة الأماكن (بيانات كاملة)
  /// ============================
  static final List<Place> _places = [
    Place(
      title: 'منازل حاتم الطائي',
      image: 'assets/images/hatem_house.png',
      description:
          'رمز الكرم العربي في حائل، تقع في قرية توارن وتعد من أبرز المعالم التاريخية.',
      workingHours: 'مفتوح طوال الوقت',
      modelPath: 'assets/models/hatems_home.glb',
      category: 'تاريخي',
      locationName: 'قرية توارن - حائل',
      latitude: 27.5600,
      longitude: 41.6900,
    ),
    Place(
      title: 'قلعة أعيرف',
      image: 'assets/images/aref.png',
      description:
          'من أقدم القلاع في مدينة حائل، تقع على جبل يطل على المدينة وتعد معلمًا تاريخيًا بارزًا.',
      workingHours: 'مفتوح طوال الوقت',
      modelPath: 'assets/models/aref_castle.glb',
      category: 'تاريخي',
      locationName: 'جبل أعيرف - حائل',
      latitude: 27.5219,
      longitude: 41.6905,
    ),
    Place(
      title: 'جبل محجة',
      image: 'assets/images/mhaja.png',
      description:
          'موقع طبيعي مميز في حائل يتميز بتضاريسه الجميلة وأجوائه الهادئة.',
      workingHours: 'مفتوح طوال الوقت',
      modelPath: 'assets/models/example.glb',
      category: 'طبيعي',
      locationName: 'حائل',
      latitude: 27.5114,
      longitude: 41.7208,
    ),
    Place(
      title: 'عقدة السياحية',
      image: 'assets/images/oqda.png',
      description:
          'وجهة سياحية طبيعية تشتهر بالمناظر الجبلية والمسطحات الخضراء.',
      workingHours: 'مفتوح طوال الوقت',
      modelPath: 'assets/models/example.glb',
      category: 'طبيعي',
      locationName: 'حائل',
      latitude: 27.5300,
      longitude: 41.7000,
    ),
    Place(
      title: 'مدينة فيد التاريخية',
      image: 'assets/images/fayd.png',
      description:
          'مدينة تاريخية قديمة كانت محطة مهمة للحجاج عبر طريق زبيدة.',
      workingHours: 'مفتوح طوال الوقت',
      modelPath: 'assets/models/example.glb',
      category: 'تاريخي',
      locationName: 'فيد - حائل',
      latitude: 27.4430,
      longitude: 42.1040,
    ),
    Place(
      title: 'منتزه مشار',
      image: 'assets/images/mashar.png',
      description:
          'منتزه طبيعي جميل يقصده السكان للتنزه والاستجمام وسط الطبيعة.',
      workingHours: '6 صباحًا - 12 منتصف الليل',
      modelPath: 'assets/models/example.glb',
      category: 'طبيعي',
      locationName: 'حائل',
      latitude: 27.5200,
      longitude: 41.7500,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'أماكن طبيعية وسياحية',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
    body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE8EDF3), Color(0xFFD9E1EC)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
     /// 🔙 العنوان + رجوع
               

                /// 🟦 Grid الأماكن
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                      itemCount: _places.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, index) {
                        return _PlaceCard(place: _places[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ============================
/// /// 🟫 كرت المكان
/// ============================
class _PlaceCard extends StatelessWidget {
  final Place place;

  const _PlaceCard({required this.place});

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

              /// ❤️ القلب (مفضلة)
              Positioned(
                top: 10,
                left: 10,
                child: ValueListenableBuilder<List<Map<String, String>>>(
                  valueListenable: FavoritesService.favorites,
                  builder: (context, favs, _) {
                    final isFav =
                        favs.any((item) => item['title'] == place.title);

                    return GestureDetector(
                      onTap: () {
                        if (isFav) {
                          FavoritesService.favorites.value =
                              List.from(favs)
                                ..removeWhere(
                                    (item) => item['title'] == place.title);
                        } else {
                          FavoritesService.favorites.value =
                              List.from(favs)
                                ..add({
                                  'title': place.title,
                                  'image': place.image
                                });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
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

              /// العنوان
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