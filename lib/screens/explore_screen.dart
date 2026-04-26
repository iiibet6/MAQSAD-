import 'package:flutter/material.dart';
import '../widgets/shared_widgets.dart';
import '../models/place_model.dart';
import 'place_details_screen.dart';
import 'nature_places_screen.dart';
import 'restaurants_screen.dart';
import 'chalets_screen.dart';
import 'cafes_screen.dart';
import 'hotels_screen.dart';
import 'shopping_screen.dart';
import '../l10n/app_localizations.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        body: Column(
          children: [
            Image.asset(
              'assets/images/gh.png',
              width: double.infinity,
              height: 45,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.discoverHail,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: t.search,
                          border: InputBorder.none,
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      t.featuredPlaces,
                      style: const TextStyle(
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
                            title: t.aerifCastle,
                            image: 'assets/images/aref.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PlaceDetailsScreen(
                                    place: Place(
                                      title: t.aerifCastle,
                                      image: "assets/images/aref.png",
                                      description: t.aerifCastleDescription,
                                      workingHours: t.openAllDay,
                                      modelPath: "assets/models/aref_castle.glb",
                                      category: t.historical,
                                      locationName: t.aerifCastleLocation,
                                      latitude: 27.5219,
                                      longitude: 41.6905,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),_CirclePlace(
                            title: t.hatimHouse,
                            image: 'assets/images/hatem_house.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PlaceDetailsScreen(
                                    place: Place(
                                      title: t.hatimHouse,
                                      image: "assets/images/hatem_house.png",
                                      description: t.hatimHouseDescription,
                                      workingHours: t.openAllDay,
                                      modelPath: "assets/models/hatems_home.glb",
                                      category: t.historical,
                                      locationName: t.hatimHouseLocation,
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

                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                      children: [
                        _CategoryCard(
                          title: t.restaurants,
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
                          title: t.natureAndTourismPlaces,
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

                        _CategoryCard(
                          title: t.cafes,
                          image: 'assets/images/cafes.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CafesScreen(),
                              ),
                            );
                          },
                        ),

                        _CategoryCard(
                          title: t.chaletsAndResorts,
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

                    const SizedBox(height: 1),Text(
                      t.other,
                      style: const TextStyle(
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
                      children: [
                        _CategoryCard(
                          title: t.hotels,
                          image: 'assets/images/hotel.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HotelsScreen(),
                              ),
                            );
                          },
                        ),

                        _CategoryCard(
                          title: t.shopping,
                          image: 'assets/images/mall.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ShoppingScreen(),
                              ),
                            );
                          },
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