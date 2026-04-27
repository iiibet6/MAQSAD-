import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'content_based_recommendation_service.dart';

class CollaborativeRecommendationService {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static Future<List<RecommendationItem>> getRecommendations() async {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      return [];
    }

    final usersSnapshot = await _firestore.collection('users').get();

    final currentUserDoc = usersSnapshot.docs.firstWhere(
      (doc) => doc.id == currentUser.uid,
      orElse: () => throw Exception('Current user not found'),
    );

    final currentData = currentUserDoc.data();

    final currentPreferences = _buildUserProfile(currentData);
    final currentFavorites = _getFavorites(currentData);

    final scoredFavorites = <String, double>{};

    for (final doc in usersSnapshot.docs) {
      if (doc.id == currentUser.uid) continue;

      final otherData = doc.data();

      final otherPreferences = _buildUserProfile(otherData);
      final otherFavorites = _getFavorites(otherData);

      if (otherFavorites.isEmpty) continue;

      final similarity = _jaccardSimilarity(
        currentPreferences,
        otherPreferences,
      );
      

      if (similarity <= 0) continue;

      for (final fav in otherFavorites) {
        final title = fav['title'];

        if (title == null  || title.isEmpty) continue;

        final alreadyInCurrentFavorites = currentFavorites.any(
          (item) => item['title'] == title,
        );

        if (alreadyInCurrentFavorites) continue;

        scoredFavorites[title] = (scoredFavorites[title] ?? 0) + similarity;
      }
    }

    final sortedTitles = scoredFavorites.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final allItems = ContentBasedRecommendationService.allItems;

    final recommendations = <RecommendationItem>[];

    for (final entry in sortedTitles) {
      final item = allItems.where((e) => e.title == entry.key).toList();

      if (item.isNotEmpty) {
        recommendations.add(item.first);
      }

      if (recommendations.length == 6) break;
    }

    return recommendations;
  }

  static List<String> _buildUserProfile(Map<String, dynamic> data) {
    final profile = <String>[];

    profile.addAll(_toStringList(data['favoriteCuisine']));
    profile.addAll(_toStringList(data['moods']));
    profile.addAll(_toStringList(data['interests']));

    final favorites = _getFavorites(data);

    for (final fav in favorites) {
      profile.add(fav['title'] ?? '');
      profile.add(fav['category'] ?? '');
      profile.add(fav['type'] ?? '');

      final tags = fav['tags'];
      if (tags != null && tags.isNotEmpty) {
        profile.addAll(tags.split(','));
      }
    }

    return profile
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();
  }

  static List<Map<String, String>> _getFavorites(Map<String, dynamic> data) {
    final rawFavorites = data['favorites'];

    if (rawFavorites == null || rawFavorites is! List) {
      return [];
    }

    return rawFavorites.map<Map<String, String>>((item) {
      final map = Map<String, dynamic>.from(item);

      return map.map(
        (key, value) => MapEntry(
          key,
          value?.toString() ?? '',
        ),
      );
    }).toList();
  }

  static List<String> _toStringList(dynamic value) {
    if (value == null || value is! List) {
      return [];
    }

    return value.map((e) => e.toString()).toList();
  }

  static double _jaccardSimilarity(
    List<String> userA,
    List<String> userB,
  ) {
    final setA = userA.toSet();
    final setB = userB.toSet();

    if (setA.isEmpty || setB.isEmpty) {
      return 0;
    }

    final intersection = setA.intersection(setB).length;
    final union = setA.union(setB).length;

    return intersection / union;
  }
}