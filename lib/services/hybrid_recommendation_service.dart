import 'content_based_recommendation_service.dart';
import 'collaborative_recommendation_service.dart';

class HybridRecommendationService {
  static Future<List<RecommendationItem>> getRecommendations(
    List<Map<String, String>> favorites,
  ) async {
    const double alpha = 0.7;

    final contentRecommendations =
        ContentBasedRecommendationService.getRecommendations(favorites);

    final collaborativeRecommendations =
        await CollaborativeRecommendationService.getRecommendations();

    final scores = <String, double>{};
    final itemsMap = <String, RecommendationItem>{};

    for (int i = 0; i < contentRecommendations.length; i++) {
      final item = contentRecommendations[i];
      final score = alpha * (1 / (i + 1));

      scores[item.title] = (scores[item.title] ?? 0) + score;
      itemsMap[item.title] = item;
    }

    for (int i = 0; i < collaborativeRecommendations.length; i++) {
      final item = collaborativeRecommendations[i];
      final score = (1 - alpha) * (1 / (i + 1));

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
}