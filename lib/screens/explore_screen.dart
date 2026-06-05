import 'package:flutter/material.dart';

import '../widgets/shared_widgets.dart';
import '../models/place_model.dart';
import 'place_details_screen.dart';
import 'nature_places_screen.dart';
import 'restaurants_screen.dart';
import 'saudi_restaurants_screen.dart';
import 'italian_restaurants_screen.dart';
import 'indian_restaurants_screen.dart';
import 'american_restaurants_screen.dart';
import 'egyptian_restaurants_screen.dart';
import 'restaurant_details_screen.dart';
import 'chalets_screen.dart';
import 'cafes_screen.dart';
import 'hotels_screen.dart';
import 'shopping_screen.dart';
import '../l10n/app_localizations.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_SearchResult> _buildResults(BuildContext context, AppLocalizations t) {
    final results = <_SearchResult>[];

    results.addAll([
      _SearchResult(
        title: t.restaurants,
        subtitle: t.discoverHail,
        image: 'assets/images/restaurants.png',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RestaurantsScreen()),
        ),
      ),
      _SearchResult(
        title: t.natureAndTourismPlaces,
        subtitle: t.discoverHail,
        image: 'assets/images/nature.png',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const NaturePlacesScreen()),
        ),
      ),
      _SearchResult(
        title: t.cafes,
        subtitle: t.discoverHail,
        image: 'assets/images/cafes.png',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CafesScreen()),
        ),
      ),
      _SearchResult(
        title: t.chaletsAndResorts,
        subtitle: t.discoverHail,
        image: 'assets/images/chalets.png',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ChaletsScreen()),
        ),
      ),
      _SearchResult(
        title: t.hotels,
        subtitle: t.other,
        image: 'assets/images/hotel.png',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HotelsScreen()),
        ),
      ),
      _SearchResult(
        title: t.shopping,
        subtitle: t.other,
        image: 'assets/images/mall.png',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ShoppingScreen()),
        ),
      ),
    ]);

    final allRestaurants = [
      ...SaudiRestaurantsScreen.restaurants,
      ...ItalianRestaurantsScreen.restaurants,
      ...IndianRestaurantsScreen.restaurants,
      ...AmericanRestaurantsScreen.restaurants,
      ...EgyptianRestaurantsScreen.restaurants,
      ...CafesScreen.cafes,
    ];

    for (final restaurant in allRestaurants) {
      results.add(
        _SearchResult(
          title: restaurant.name,
          subtitle: restaurant.subtitle,
          image: restaurant.image,
          keywords:
              '${restaurant.name} ${restaurant.subtitle} ${restaurant.type} ${restaurant.category} ${restaurant.tags.join(" ")}',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RestaurantDetailsScreen(
                restaurant: restaurant,
              ),
            ),
          ),
        ),
      );
    } final places = [
      ...NaturePlacesScreen.places,
      ...ChaletsScreen.chalets,
      Place(
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
      Place(
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
    ];

    for (final place in places) {
      results.add(
        _SearchResult(
          title: place.title,
          subtitle: place.description,
          image: place.image,
          keywords:
              '${place.title} ${place.description} ${place.category} ${place.locationName}',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PlaceDetailsScreen(place: place),
            ),
          ),
        ),
      );
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final allResults = _buildResults(context, t);

    final filteredResults = _query.trim().isEmpty
        ? <_SearchResult>[]
        : allResults.where((result) {
            final q = _query.trim().toLowerCase();
            return result.title.toLowerCase().contains(q) ||
                result.subtitle.toLowerCase().contains(q) ||
                result.keywords.toLowerCase().contains(q);
          }).toList();

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
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _query = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: t.search,
                          border: InputBorder.none,
                          icon: const Icon(Icons.search),
                          suffixIcon: _query.isEmpty
                              ? null
                              : IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      _query = '';
                                    });
                                  },
                                ),
                        ),
                      ),),


                      
                    if (_query.trim().isNotEmpty) ...[
                      const SizedBox(height: 14),
                      if (filteredResults.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Text('لا توجد نتائج'),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredResults.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final result = filteredResults[index];

                            return _SearchResultTile(result: result);
                          },
                        ),
                    ] else ...[
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
                                        modelPath:
                                            "assets/models/aref_castle.glb",
                                        category: t.historical,
                                        locationName: t.aerifCastleLocation,
                                        latitude: 27.5219,
                                        longitude: 41.6905,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            _CirclePlace(
                              title: t.hatimHouse,
                              image: 'assets/images/hatem_house.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PlaceDetailsScreen(
                                      place: Place(
                                        title: t.hatimHouse,
                                        image:
                                            "assets/images/hatem_house.png",
                                        description: t.hatimHouseDescription,
                                        workingHours: t.openAllDay,
                                        modelPath:
                                            "assets/models/hatems_home.glb",
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
                                  builder: (_) =>
                                      const NaturePlacesScreen(),
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
                      const SizedBox(height: 1),
                      Text(
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
                                MaterialPageRoute(builder: (_) => const HotelsScreen(),
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

class _SearchResult {
  final String title;
  final String subtitle;
  final String image;
  final String keywords;
  final VoidCallback onTap;

  const _SearchResult({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
    this.keywords = '',
  });
}

class _SearchResultTile extends StatelessWidget {
  final _SearchResult result;

  const _SearchResultTile({
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: result.onTap,
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      tileColor: Colors.white,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          result.image,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            width: 56,
            height: 56,
            color: Colors.grey.shade200,
            child: const Icon(Icons.image_not_supported),
          ),
        ),
      ),
      title: Text(
        result.title,
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        result.subtitle,
        textAlign: TextAlign.right,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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
  });@override
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