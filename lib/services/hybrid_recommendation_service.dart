import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'content_based_recommendation_service.dart';
import 'collaborative_recommendation_service.dart';

class HybridRecommendationService {
  static Future<List<RecommendationItem>> getRecommendations(
    List<Map<String, String>> favorites,
  ) async {
    const double alpha = 0.7;

    final userRatings = await _getUserHighRatings();

    final preferenceInputs = [
      ...favorites,
      ...userRatings,
    ];

    final contentRecommendations =
        ContentBasedRecommendationService.getRecommendations(preferenceInputs);

    final collaborativeRecommendations =
        await CollaborativeRecommendationService.getRecommendations();

    final scores = <String, double>{};
    final itemsMap = <String, RecommendationItem>{};

    for (int i = 0; i < contentRecommendations.length; i++) {
      final item = contentRecommendations[i];

      double score = alpha * (1 / (i + 1));

      score = score * (item.rating / 5);

      scores[item.title] = (scores[item.title] ?? 0) + score;
      itemsMap[item.title] = item;
    }

    for (int i = 0; i < collaborativeRecommendations.length; i++) {
      final item = collaborativeRecommendations[i];

      double score = (1 - alpha) * (1 / (i + 1));

      score = score * (item.rating / 5);

      scores[item.title] = (scores[item.title] ?? 0) + score;
      itemsMap[item.title] = item;
    }

    final sortedItems = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedItems
        .take(6)
        .map((entry) => itemsMap[entry.key]!)
        .toList();
  }

  static Future<List<Map<String, String>>> _getUserHighRatings() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return [];
    }

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final data = doc.data();

    if (data == null ||  data['ratings'] == null  || data['ratings'] is! List) {
      return [];
    }

    final ratings = data['ratings'] as List;

    return ratings
        .map((item) => Map<String, dynamic>.from(item))
        .where((item) {
          final rating = item['rating'];

          if (rating is int) {
            return rating >= 4;
          }

          if (rating is double) {
            return rating >= 4;
          }

          return false;
        })
        .map<Map<String, String>>((item) {
          return {
            'title': item['title']?.toString() ?? '',
            'type': item['type']?.toString() ?? '',
            'category': item['category']?.toString() ?? '',
            'tags': item['tags']?.toString() ?? '',
          };
        })
        .where((item) => item['title']!.isNotEmpty)
        .toList();
  }
}