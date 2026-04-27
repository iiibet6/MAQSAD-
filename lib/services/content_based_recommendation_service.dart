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
  final String content;
  final double rating;

  const RecommendationItem({
    required this.title,
    required this.image,
    required this.subtitle,
    required this.content,
    this.rating = 5.0,
  });
}

class ContentBasedRecommendationService {
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
          content:
              '${r.name} ${r.subtitle} ${r.type} ${r.category} ${r.tags.join(" ")}',
        ),
      );
    }

    for (final h in HotelsScreen.hotels) {
      items.add(
        RecommendationItem(
          title: h.name,
          image: h.image,
          subtitle: h.description,
          rating: double.tryParse(h.rating) ?? 5.0,
          content:
              '${h.name} ${h.description} فنادق ${h.category} ${h.tags.join(" ")}',
        ),
      );
    }

    for (final s in shoppingPlaces) {
      items.add(
        RecommendationItem(
          title: s.name,
          image: s.image,
          subtitle: s.description,
          content:
              '${s.name} ${s.description} تسوق ${s.category} ${s.tags.join(" ")}',
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
          content:
              '${p.title} ${p.description} سياحة ${p.category} ${p.locationName}',
        ),
      );
    }

    for (final c in ChaletsScreen.chalets) {
      items.add(
        RecommendationItem(
          title: c.title,
          image: c.image,
          subtitle: c.description,
          content:
              '${c.title} ${c.description} شاليهات منتجع ${c.category} ${c.locationName}',
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

    final documents = items.map((e) => e.content).toList();

    final vocabulary = _buildVocabulary(documents);
    final idf = _buildIdf(documents, vocabulary);

    final tfidfMatrix = documents
        .map((doc) => _buildTfIdfVector(doc, vocabulary, idf))
        .toList();

    final similarityMatrix = _buildSimilarityMatrix(tfidfMatrix);

    final favoriteIndexes = <int>[];

    for (final title in favoriteTitles) {
      final index = items.indexWhere((item) => item.title == title);
      if (index != -1) {
        favoriteIndexes.add(index);
      }
    }

    if (favoriteIndexes.isEmpty) {
      return items.take(6).toList();
    }

    final scoredItems = <Map<String, dynamic>>[];

    for (int i = 0; i < items.length; i++) {
      if (favoriteIndexes.contains(i)) continue;

      double totalSimilarity = 0;for (final favIndex in favoriteIndexes) {
        totalSimilarity += similarityMatrix[favIndex][i];
      }

      double score = totalSimilarity / favoriteIndexes.length;

      // نفس فكرة البنات: score * rating / 5
      score = score * (items[i].rating / 5);

      scoredItems.add({
        'item': items[i],
        'score': score,
      });
    }

    scoredItems.sort(
      (a, b) => (b['score'] as double).compareTo(a['score'] as double),
    );

    return scoredItems
        .where((e) => (e['score'] as double) > 0)
        .take(6)
        .map((e) => e['item'] as RecommendationItem)
        .toList();
  }

  static List<String> _tokenize(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\u0600-\u06FFa-zA-Z0-9\s]'), ' ')
        .split(RegExp(r'\s+'))
        .map((w) => w.trim())
        .where((w) => w.isNotEmpty)
        .toList();
  }

  static List<String> _buildVocabulary(List<String> documents) {
    final vocab = <String>{};

    for (final doc in documents) {
      vocab.addAll(_tokenize(doc));
    }

    return vocab.toList();
  }

  static Map<String, double> _buildIdf(
    List<String> documents,
    List<String> vocabulary,
  ) {
    final idf = <String, double>{};
    final totalDocs = documents.length;

    for (final word in vocabulary) {
      int count = 0;

      for (final doc in documents) {
        if (_tokenize(doc).toSet().contains(word)) {
          count++;
        }
      }

      idf[word] = log((totalDocs + 1) / (count + 1)) + 1;
    }

    return idf;
  }

  static List<double> _buildTfIdfVector(
    String document,
    List<String> vocabulary,
    Map<String, double> idf,
  ) {
    final tokens = _tokenize(document);
    final vector = List<double>.filled(vocabulary.length, 0);

    for (int i = 0; i < vocabulary.length; i++) {
      final word = vocabulary[i];

      final tf = tokens.isEmpty
          ? 0.0
          : tokens.where((token) => token == word).length / tokens.length;

      vector[i] = tf * (idf[word] ?? 0);
    }

    return vector;
  }

  static List<List<double>> _buildSimilarityMatrix(
    List<List<double>> tfidfMatrix,
  ) {
    final matrix = <List<double>>[];

    for (int i = 0; i < tfidfMatrix.length; i++) {
      final row = <double>[];

      for (int j = 0; j < tfidfMatrix.length; j++) {
        row.add(_cosineSimilarity(tfidfMatrix[i], tfidfMatrix[j]));
      }

      matrix.add(row);
    }

    return matrix;
  }

  static double _cosineSimilarity(
    List<double> vectorA,
    List<double> vectorB,
  ) {
    double dot = 0;
    double normA = 0;
    double normB = 0;

    for (int i = 0; i < vectorA.length; i++) {
      dot += vectorA[i] * vectorB[i];
      normA += vectorA[i] * vectorA[i];
      normB += vectorB[i] * vectorB[i];
    }

    if (normA == 0 || normB == 0) return 0;

    return dot / (sqrt(normA) * sqrt(normB));
  }
}