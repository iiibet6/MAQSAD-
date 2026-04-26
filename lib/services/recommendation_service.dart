import 'dart:math';

import '../screens/saudi_restaurants_screen.dart';
import '../screens/italian_restaurants_screen.dart';
import '../screens/indian_restaurants_screen.dart';
import '../screens/american_restaurants_screen.dart';
import '../screens/egyptian_restaurants_screen.dart';
import '../screens/cafes_screen.dart';
import '../screens/hotels_screen.dart';
import '../screens/shopping_screen.dart';
import '../screens/nature_places_screen.dart';
import '../screens/chalets_screen.dart';

class RecommendationItem {
  final String title;
  final String image;
  final String subtitle;
  final String type;
  final String category;
  final List<String> tags;

  const RecommendationItem({
    required this.title,
    required this.image,
    required this.subtitle,
    required this.type,
    required this.category,
    required this.tags,
  });
}

class RecommendationService {
  static List<RecommendationItem> get allItems {
    final items = <RecommendationItem>[];

    final restaurants = [
      ...SaudiRestaurantsScreen.restaurants,
      ...ItalianRestaurantsScreen.restaurants,
      ...IndianRestaurantsScreen.restaurants,
      ...AmericanRestaurantsScreen.restaurants,
      ...EgyptianRestaurantsScreen.restaurants,
      ...CafesScreen.cafes,
    ];

    for (final r in restaurants) {
      items.add(
        RecommendationItem(
          title: r.name,
          image: r.image,
          subtitle: r.subtitle,
          type: r.type,
          category: r.category,
          tags: r.tags,
        ),
      );
    }

    for (final h in HotelsScreen.hotels) {
      items.add(
        RecommendationItem(
          title: h.name,
          image: h.image,
          subtitle: h.description,
          type: 'فنادق',
          category: h.category,
          tags: h.tags,
        ),
      );
    }

    for (final s in shoppingPlaces) {
      items.add(
        RecommendationItem(
          title: s.name,
          image: s.image,
          subtitle: s.description,
          type: 'تسوق',
          category: s.category,
          tags: s.tags,
        ),
      );
    }

    for (final p in NaturePlacesScreen.places) {
      items.add(
        RecommendationItem(
          title: p.title,
          image: p.image,
          subtitle: p.category == 'تاريخي'
              ? 'معلم تاريخي وسياحي في حائل'
              : 'وجهة طبيعية وسياحية في حائل',
          type: 'سياحة',
          category: p.category,
          tags: _natureTags(p.title, p.category),
        ),
      );
    }

    for (final c in ChaletsScreen.chalets) {
      items.add(
        RecommendationItem(
          title: c.title,
          image: c.image,
          subtitle: c.title == 'الماسية'
              ? 'شاليه فاخر مع مسبح'
              : 'منتجع هادئ بأجواء طبيعية',
          type: 'شاليهات',
          category: 'منتجع',
          tags: _chaletTags(c.title),
        ),
      );
    }

    return items;
  }

  static List<RecommendationItem> getRecommendations(
    List<Map<String, String>> favorites,
  ) {
    final items = allItems;

    if (favorites.isEmpty) {
      return items.take(6).toList();
    }

    final favoriteTitles = favorites
        .map((fav) => fav['title'] ?? '')
        .where((title) => title.isNotEmpty)
        .toSet();

    final vocabulary = _buildVocabulary(items, favorites);
    final userVector = _buildUserVector(favorites, vocabulary);

    final scoredItems = items
        .where((item) => !favoriteTitles.contains(item.title))
        .map((item) {
          final itemVector = _buildItemVector(item, vocabulary);
          final score = _cosineSimilarity(userVector, itemVector);

          return {
            'item': item,
            'score': score,
          };
        })
        .toList();

    scoredItems.sort(
      (a, b) => (b['score'] as double).compareTo(a['score'] as double),
    );

    final recommendations = scoredItems
        .where((e) => (e['score'] as double) > 0)
        .map((e) => e['item'] as RecommendationItem)
        .take(6)
        .toList();
if (recommendations.isEmpty) {
      return items
          .where((item) => !favoriteTitles.contains(item.title))
          .take(6)
          .toList();
    }

    return recommendations;
  }

  static List<String> _buildVocabulary(
    List<RecommendationItem> items,
    List<Map<String, String>> favorites,
  ) {
    final vocabulary = <String>{};

    for (final item in items) {
      vocabulary.add(item.type);
      vocabulary.add(item.category);
      vocabulary.addAll(item.tags);
    }

    for (final fav in favorites) {
      final type = fav['type'];
      final category = fav['category'];
      final tags = fav['tags'] ?? '';

      if (type != null && type.trim().isNotEmpty) vocabulary.add(type.trim());
      if (category != null && category.trim().isNotEmpty) {
        vocabulary.add(category.trim());
      }

      vocabulary.addAll(
        tags
            .split(',')
            .map((tag) => tag.trim())
            .where((tag) => tag.isNotEmpty),
      );
    }

    return vocabulary.toList();
  }

  static List<double> _buildUserVector(
    List<Map<String, String>> favorites,
    List<String> vocabulary,
  ) {
    final vector = List<double>.filled(vocabulary.length, 0);

    for (final fav in favorites) {
      final features = <String>[];

      final type = fav['type'];
      final category = fav['category'];
      final tags = fav['tags'] ?? '';

      if (type != null && type.trim().isNotEmpty) features.add(type.trim());
      if (category != null && category.trim().isNotEmpty) {
        features.add(category.trim());
      }

      features.addAll(
        tags
            .split(',')
            .map((tag) => tag.trim())
            .where((tag) => tag.isNotEmpty),
      );

      for (final feature in features) {
        final index = vocabulary.indexOf(feature);
        if (index != -1) {
          vector[index] += 1;
        }
      }
    }

    return vector;
  }

  static List<double> _buildItemVector(
    RecommendationItem item,
    List<String> vocabulary,
  ) {
    final vector = List<double>.filled(vocabulary.length, 0);

    final features = [
      item.type,
      item.category,
      ...item.tags,
    ];

    for (final feature in features) {
      final index = vocabulary.indexOf(feature);
      if (index != -1) {
        vector[index] += 1;
      }
    }

    return vector;
  }

  static double _cosineSimilarity(
    List<double> vectorA,
    List<double> vectorB,
  ) {
    double dotProduct = 0;
    double normA = 0;
    double normB = 0;

    for (int i = 0; i < vectorA.length; i++) {
      dotProduct += vectorA[i] * vectorB[i];
      normA += vectorA[i] * vectorA[i];
      normB += vectorB[i] * vectorB[i];
    }

    if (normA == 0 || normB == 0) return 0;

    return dotProduct / (sqrt(normA) * sqrt(normB));
  }

  static List<String> _natureTags(String title, String category) {
    switch (title) {
      case 'منازل حاتم الطائي':
        return ['سياحة', 'تاريخي', 'تراث', 'حاتم الطائي', 'توارن', 'معالم'];
      case 'قلعة أعيرف':
        return ['سياحة', 'تاريخي', 'قلعة', 'جبل', 'تراث', 'معالم'];
      case 'جبل محجة':
        return ['سياحة', 'طبيعة', 'جبل', 'هدوء', 'تصوير', 'مغامرة'];
      case 'عقدة السياحية':
        return ['سياحة', 'طبيعة', 'جبال', 'خضرة', 'تنزه', 'عوائل'];
      case 'مدينة فيد التاريخية':
        return ['سياحة', 'تاريخي', 'تراث', 'طريق زبيدة', 'آثار', 'معالم'];
      case 'منتزه مشار':
        return ['سياحة', 'طبيعة', 'منتزه', 'عوائل', 'تنزه', 'هدوء'];
      case 'شعيب توارن':
        return ['سياحة', 'طبيعة', 'توارن', 'مغامرة', 'تنزه', 'أشجار'];
      default:
        return ['سياحة', category];
    }
  }

  static List<String> _chaletTags(String title) {
    switch (title) {
      case 'ريف الطوالة':
        return ['شاليهات', 'منتجع', 'طبيعة', 'هدوء', 'عائلات', 'جلسات'];
      case 'الماسية':
        return ['شاليهات', 'فاخر', 'مسبح', 'عائلات', 'منتجع', 'استجمام'];
      default:
        return ['شاليهات', 'منتجع'];
    }
  }
}