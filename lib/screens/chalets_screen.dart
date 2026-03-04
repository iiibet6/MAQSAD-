import 'package:flutter/material.dart';
import '../models/place_model.dart';
import 'place_details_screen.dart';
import '../services/favorites_service.dart';

class ChaletsScreen extends StatelessWidget {
  const ChaletsScreen({super.key});

  static final List<Place> _chalets = [
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
  image: 'assets/images/almasia.jpg', // حطي صورة الشاليه هنا
  description:
      'شاليه الماسية من الوجهات الفاخرة في حائل، يوفر جلسات خاصة ومسبح وأجواء هادئة مناسبة للعائلات.',
  workingHours: 'على مدار الساعة',
  modelPath: 'assets/models/example.glb',
  category: 'شاليهات ومنتجعات',
  locationName: 'حائل',
  latitude: 27.900000,  // عدليها حسب موقعه الحقيقي
  longitude: 41.700000,
  plusCode: "7HV39HRC+5H", 
),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('شاليهات ومنتجعات'),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _chalets.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final place = _chalets[index];

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
                      /// الصورة
                      Positioned.fill(
                        child: Image.asset(
                          place.image,
                          fit: BoxFit.cover,
                        ),
                      ),

                      /// ❤️ زر المفضلة
                      Positioned(
                        top: 10,
                        left: 10,
                        child: ValueListenableBuilder<
                            List<Map<String, String>>>(
                          valueListenable: FavoritesService.favorites,
                          builder: (context, favs, _) {
                            final isFav = favs
                                .any((item) => item['title'] == place.title);

                            return GestureDetector(
                              onTap: () {
                                if (isFav) {
                                  FavoritesService.favorites.value =
                                      List.from(favs)
                                        ..removeWhere((item) =>
                                            item['title'] == place.title);
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

                      /// اسم الشاليه
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
          },
        ),
      ),
    );
  }
}