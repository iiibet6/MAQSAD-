import 'package:flutter/material.dart';

class FavoritesService {
  static final ValueNotifier<List<Map<String, String>>> favorites =
      ValueNotifier([]);
}