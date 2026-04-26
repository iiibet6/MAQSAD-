import 'package:flutter/material.dart';
import 'saudi_restaurants_screen.dart';
import 'italian_restaurants_screen.dart';
import 'indian_restaurants_screen.dart';
import 'american_restaurants_screen.dart';
import 'egyptian_restaurants_screen.dart';
import '../l10n/app_localizations.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: Directionality.of(context),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            t.restaurants,
                            style: const TextStyle(
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

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.9,
                      children: [
                        _FlagCard(
                          title: t.italian,
                          image: 'assets/images/italy.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const ItalianRestaurantsScreen(),
                              ),
                            );
                          },
                        ),
                        _FlagCard(
                          title: t.saudi,
                          image: 'assets/images/saudi.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const SaudiRestaurantsScreen(),
                              ),
                            );
                          },
                        ),
                        _FlagCard(
                          title: t.american,
                          image: 'assets/images/usa.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const AmericanRestaurantsScreen(),
                              ),
                            );
                          },
                        ),
                        _FlagCard(
                          title: t.indian,
                          image: 'assets/images/india.png',
                          onTap: () {Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const IndianRestaurantsScreen(),
                              ),
                            );
                          },
                        ),
                        _FlagCard(
                          title: t.chinese,
                          image: 'assets/images/china.png',
                        ),
                        _FlagCard(
                          title: t.egyptian,
                          image: 'assets/images/egypt.png',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const EgyptianRestaurantsScreen(),
                              ),
                            );
                          },
                        ),
                      ],
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

class _FlagCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback? onTap;

  const _FlagCard({
    required this.title,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.white,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
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