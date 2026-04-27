import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/favorites_service.dart';
import '../services/content_based_recommendation_service.dart';
import '../l10n/app_localizations.dart';

class OfferItem {
  final String imageAsset;
  final String title;
  const OfferItem({required this.imageAsset, required this.title});
}

class NearbyPlace {
  final String name;
  final String distance;
  final String imageAsset;

  const NearbyPlace({
    required this.name,
    required this.distance,
    required this.imageAsset,
  });
}

const _offers = [
  OfferItem(imageAsset: 'assets/images/offer_coffee.png', title: 'coffee'),
  OfferItem(imageAsset: 'assets/images/offer_restaurants.png', title: 'restaurants'),
  OfferItem(imageAsset: 'assets/images/offer_chalets.png', title: 'chalets'),
];

const _nearby = [
  NearbyPlace(
    name: 'مطعم لوفت',
    distance: '0.4 ك.م',
    imageAsset: 'assets/images/nearby1.png',
  ),
  NearbyPlace(
    name: 'عنوان القهوة',
    distance: '0.4 ك.م',
    imageAsset: 'assets/images/nearby2.png',
  ),
  NearbyPlace(
    name: 'مطعم روقا روكو',
    distance: '0.3 ك.م',
    imageAsset: 'assets/images/nearby3.png',
  ),
  NearbyPlace(
    name: 'اوسول كوفي',
    distance: '0.2 ك.م',
    imageAsset: 'assets/images/nearby4.png',
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            const ArabicPatternBorder(),
            const _HomeAppBar(),
            const Expanded(child: _HomeContent()),
          ],
        ),
        floatingActionButton: Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.30),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                Navigator.pushNamed(context, '/chatbot');
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  'assets/images/robot.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar();

  Future<String> _getUserName(BuildContext context) async {
    final t = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return t.guestName;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final data = doc.data();

      if (data != null &&
          data['name'] != null &&
          data['name'].toString().trim().isNotEmpty) {
        return data['name'].toString().trim();
      }

      if (user.displayName != null && user.displayName!.trim().isNotEmpty) {
        return user.displayName!.trim();
      }

      return t.guestName;
    } catch (_) {
      return user.displayName ?? t.guestName;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 18),
      child: Row(
        children: [
          const Row(
            children: [
              _IconBadge(icon: Icons.local_offer_outlined),
              SizedBox(width: 8),
              _IconBadge(icon: Icons.notifications_outlined),
            ],
          ),
          const Spacer(),
          FutureBuilder<String>(
            future: _getUserName(context),
            builder: (context, snapshot) {
              final name = snapshot.data ?? t.guestName;

              return Text(
                '${t.welcomeGreeting} $name!',
                style: AppTextStyles.headline2,
              );
            },
          ),
          const SizedBox(width: 12),
          const Icon(Icons.menu, size: 26),
        ],
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final IconData icon;

  const _IconBadge({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.divider),
      ),
      child: Icon(icon, size: 20),
    );
  }
}

BoxDecoration premiumShadow(double radius) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 30,
        offset: const Offset(0, 20),
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.03),
        blurRadius: 8,
        offset: const Offset(0, 6),
      ),
    ],
  );
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: const [
        _OffersSection(),
        SizedBox(height: 28),
        _RecommendedSection(),
        SizedBox(height: 28),
        _NearbySection(),
        SizedBox(height: 28),
        _TrendingSection(),
        SizedBox(height: 24),
      ],
    );
  }
}

class _OffersSection extends StatelessWidget {
  const _OffersSection();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SectionHeader(title: t.todayOffers),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 190,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _offers.length,
            separatorBuilder: (_,__) => const SizedBox(width: 18),
            itemBuilder: (ctx, i) {
              final offer = _offers[i];

              return Container(
                width: 175,
                decoration: premiumShadow(22),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    offer.imageAsset,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RecommendedSection extends StatelessWidget {
  const _RecommendedSection();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return ValueListenableBuilder<List<Map<String, String>>>(
      valueListenable: FavoritesService.favorites,
      builder: (context, favs, _) {
        final recommendations =ContentBasedRecommendationService.getRecommendations(favs);

        return _horizontalPlaces(
          title: t.pickedForYou,
          height: 190,
          width: 125,
          imageHeight: 115,
          items: recommendations.map((e) => e.image).toList(),
          names: recommendations.map((e) => e.title).toList(),
          subtitles: recommendations.map((e) => e.subtitle).toList(),
        );
      },
    );
  }
}

class _NearbySection extends StatelessWidget {
  const _NearbySection();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return _horizontalPlaces(
      title: t.nearbyPlaces,
      height: 150,
      width: 115,
      imageHeight: 95,
      items: _nearby.map((e) => e.imageAsset).toList(),
      names: _nearby.map((e) => e.name).toList(),
      subtitles: _nearby.map((e) => e.distance).toList(),
    );
  }
}

class _TrendingSection extends StatelessWidget {
  const _TrendingSection();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return _horizontalPlaces(
      title: t.giftSectionTitle,
      height: 170,
      width: 145,
      imageHeight: 115,
      items: const [
        'assets/images/trending1.png',
        'assets/images/trending2.png',
      ],
      names: [
        t.flowerGift,
        t.giftCourier,
      ],
      subtitles: [
        t.flowersAndGifts,
        t.sameDayDelivery,
      ],
    );
  }
}

Widget _horizontalPlaces({
  required String title,
  required double height,
  required double width,
  required double imageHeight,
  required List<String> items,
  required List<String> names,
  required List<String> subtitles,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SectionHeader(title: title),
      ),
      const SizedBox(height: 14),
      SizedBox(
        height: height,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (context, i) {
            return SizedBox(
              width: width,
              child: Column(
                children: [
                  Container(
                    decoration: premiumShadow(18),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        items[i],height: imageHeight,
                        width: width,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    names[i],
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    subtitles[i],
                    style: AppTextStyles.caption,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}