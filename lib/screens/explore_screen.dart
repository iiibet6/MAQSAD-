import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import 'nature_places_screen.dart';

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

                    const Text(
                      'اكتشف حائل',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Search
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(
                            'ابحث',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'الأماكن المميزة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Featured Circles
                    SizedBox(
                      height: 110,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:  [
                          _CirclePlace(
                            title: 'قلعة أعيرف',
                            image: 'assets/images/aref.png',
                          ),
                          _CirclePlace(
                            title: 'مطل حاتم الطائي',
                            image: 'assets/images/hatem_view.png',
                          ),
                          _CirclePlace(
                            title: 'منازل حاتم الطائي',
                            image: 'assets/images/hatem_house.png',
                          ),
                          _CirclePlace(
                            title: 'قصر القشلة',
                            image: 'assets/images/qashlah.png',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// =========================
                    /// GRID 2x2 (مربعات)
                    /// =========================
                    Center(
  child: SizedBox(
    width: MediaQuery.of(context).size.width * 0.80, // 👈 يصغر العرض
    child: GridView.count(
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
        _CategoryCard(
          title: 'مقاهي',
          image: 'assets/images/cafes.png',
        ),
        _CategoryCard(
          title: 'شاليهات ومنتجعات',
          image: 'assets/images/chalets.png',
        ),
      ],
    ),
  ),
),

                    const SizedBox(height: 24),

                    const Text(
                      'أخرى',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Center(
  child: SizedBox(
    width: MediaQuery.of(context).size.width * 0.85,
    child: GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1,
      children: [
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
  ),
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
  final VoidCallback? onTap; // 👈 أضفنا هذا

  const _CategoryCard({
    required this.title,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // 👈 هنا يصير الضغط
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
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
      ),
    );
  }
}
class _CirclePlace extends StatelessWidget {
  final String title;
  final String image;

  const _CirclePlace({
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(image),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 80,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}