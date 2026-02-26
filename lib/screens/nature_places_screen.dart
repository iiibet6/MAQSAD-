import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import 'place_details_screen.dart';

class NaturePlacesScreen extends StatelessWidget {
  const NaturePlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'أماكن طبيعية وسياحية',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                /// Grid
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
                        final place = _places[index];
                        return _PlaceCard(
                          title: place['title']!,
                          image: place['image']!,
                        );
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

/// بيانات الأماكن
final List<Map<String, String>> _places = [
  {
    'title': 'منازل حاتم الطائي',
    'image': 'assets/images/hatem_house.png',
  },
  {
    'title': 'قلعة أعيرف',
    'image': 'assets/images/aref.png',
  },
  {
    'title': 'جبل محجة',
    'image': 'assets/images/mhaja.png',
  },
  {
    'title': 'عقدة السياحية',
    'image': 'assets/images/oqda.png',
  },
  {
    'title': 'مدينة فيد التاريخية',
    'image': 'assets/images/fayd.png',
  },
  {
    'title': 'منتزه مشار',
    'image': 'assets/images/mashar.png',
  },
];

/// كرت المكان
class _PlaceCard extends StatelessWidget {
  final String title;
  final String image;

  const _PlaceCard({
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlaceDetailsScreen(
              title: title,
              image: image,
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
                  image,
                  fit: BoxFit.cover,
                ),
              ),

              /// ❤️ القلب مع المفضلات
              Positioned(
                top: 10,
                left: 10,
                child: ValueListenableBuilder<List<Map<String, String>>>(
                  valueListenable: FavoritesService.favorites,
                  builder: (context, favs, _) {
                    final isFav =
                        favs.any((item) => item['title'] == title);

                    return GestureDetector(
                      onTap: () {
                        if (isFav) {
                          FavoritesService.favorites.value =
                              List.from(favs)
                                ..removeWhere(
                                    (item) => item['title'] == title);
                        } else {
                          FavoritesService.favorites.value =
                              List.from(favs)
                                ..add({'title': title, 'image': image});
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.white,
                  child: Text(
                    title,
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