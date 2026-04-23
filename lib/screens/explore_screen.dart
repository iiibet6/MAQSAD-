import 'package:flutter/material.dart';
import '../widgets/shared_widgets.dart';
import '../models/place_model.dart';
import 'place_details_screen.dart';
import 'nature_places_screen.dart';
import 'restaurants_screen.dart';
import 'chalets_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            const PatternBorderFallback(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// العنوان
                    const Text(
                      'اكتشف حائل !',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// شريط البحث
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "ابحث",
                          border: InputBorder.none,
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// الأماكن المميزة
                    const Text(
                      'الأماكن المميزة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      height: 110,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [

                          _CirclePlace(
                            title: 'قلعة أعيرف',
                            image: 'assets/images/aref.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PlaceDetailsScreen(
                                    place: Place(
                                      title: "قلعة أعيرف",
                                      image: "assets/images/aref.png",
                                      description:
                                          "تُعد قلعة أعيرف من أقدم المعالم التاريخية في حائل.",
                                      workingHours: "مفتوح طوال الوقت",
                                      modelPath: "assets/models/aref_castle.glb",
                                      category: "تاريخي",
                                      locationName: "جبل أعيرف - حائل",
                                      latitude: 27.5219,
                                      longitude: 41.6905,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          _CirclePlace(
                            title: 'منازل حاتم الطائي',
                            image: 'assets/images/hatem_house.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => PlaceDetailsScreen(
                                    place: Place(
                                      title: "منازل حاتم الطائي",
                                      image: "assets/images/hatem_house.png",
                                      description: "رمز الكرم العربي في حائل.",
                                      workingHours: "مفتوح طوال الوقت",
                                      modelPath: "assets/models/hatems_home.glb",
                                      category: "تاريخي",
                                      locationName: "قرية توارن - حائل",
                                      latitude: 27.5600,
                                      longitude: 41.6900,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(height: 1),

                    /// التصنيفات الرئيسية
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                      children: [

                        _CategoryCard(
                          title: 'مطاعم',
                          image: 'assets/images/restaurants.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RestaurantsScreen(),
                              ),
                            );
                          },
                        ),

                        _CategoryCard(
                          title: 'أماكن طبيعية وسياحية',
                          image: 'assets/images/nature.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const NaturePlacesScreen(),
                              ),
                            );
                          },
                        ),

                        const _CategoryCard(
                          title: 'مقاهي',
                          image: 'assets/images/cafes.png',
                        ),

                        _CategoryCard(
                          title: 'شاليهات ومنتجعات',
                          image: 'assets/images/chalets.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ChaletsScreen(),
                              ),
                            );
                          },
                        ),

                      ],
                    ),

                    const SizedBox(height: 1),

                    /// قسم أخرى
                    const Text(
                      'أخرى',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                      children: const [

                        _CategoryCard(
                          title: 'فنادق',

image: 'assets/images/hotel.png',
                        ),

                        _CategoryCard(
                          title: 'تسوق',
                          image: 'assets/images/mall.png',
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),

            const AppBottomNavBar(currentIndex: 2),

          ],
        ),
      ),
    );
  }
}

/// كرت التصنيف
class _CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback? onTap;

  const _CategoryCard({
    required this.title,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.35),
              ),
            ),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// الأماكن الدائرية
class _CirclePlace extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback? onTap;

  const _CirclePlace({
    required this.title,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(image),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 70,
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}