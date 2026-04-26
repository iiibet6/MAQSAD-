import 'package:flutter/foundation.dart';

class FavoritesService {
  static final ValueNotifier<List<Map<String, String>>> favorites =
      ValueNotifier<List<Map<String, String>>>([]);
}