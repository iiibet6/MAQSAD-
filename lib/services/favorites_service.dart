import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesService {
  static final ValueNotifier<List<Map<String, String>>> favorites =
      ValueNotifier<List<Map<String, String>>>([]);

  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static Future<void> addFavorite(
    Map<String, String> item,
  ) async {
    final current = List<Map<String, String>>.from(favorites.value);

    final exists = current.any(
      (fav) => fav['title'] == item['title'],
    );

    if (!exists) {
      current.add(item);
      favorites.value = current;
    }

    final user = _auth.currentUser;

    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({
        'favorites': current,
      });
    }
  }

  static Future<void> removeFavorite(
    String title,
  ) async {
    final current = List<Map<String, String>>.from(favorites.value);

    current.removeWhere(
      (item) => item['title'] == title,
    );

    favorites.value = current;

    final user = _auth.currentUser;

    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({
        'favorites': current,
      });
    }
  }

  static Future<void> loadFavorites() async {
    final user = _auth.currentUser;

    if (user == null) return;

    final doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .get();

    if (!doc.exists) return;

    final data = doc.data();

    if (data == null) return;

    final favs = List<Map<String, String>>.from(
      (data['favorites'] ?? []).map(
        (e) => Map<String, String>.from(e),
      ),
    );

    favorites.value = favs;
  }
}