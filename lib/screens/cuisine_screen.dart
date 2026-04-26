import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../l10n/app_localizations.dart';

class Cuisine {
  final String label;
  final String imageAsset;
  bool selected;

  Cuisine({
    required this.label,
    required this.imageAsset,
    this.selected = false,
  });
}

class CuisineScreen extends StatefulWidget {
  const CuisineScreen({super.key});

  @override
  State<CuisineScreen> createState() => _CuisineScreenState();
}

class _CuisineScreenState extends State<CuisineScreen> {
  late List<Cuisine> _cuisines;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final t = AppLocalizations.of(context)!;

    _cuisines = [
      Cuisine(label: t.saudiCuisine, imageAsset: 'assets/images/cuisine_saudi.jpg'),
      Cuisine(label: t.gulfCuisine, imageAsset: 'assets/images/cuisine_gulf.jpg'),
      Cuisine(label: t.levantineCuisine, imageAsset: 'assets/images/cuisine_syr.jpg'),
      Cuisine(label: t.turkishCuisine, imageAsset: 'assets/images/cuisine_turkish.jpg'),
      Cuisine(label: t.italianCuisine, imageAsset: 'assets/images/cuisine_italian.jpg'),
      Cuisine(label: t.americanCuisine, imageAsset: 'assets/images/cuisine_american.jpg'),
      Cuisine(label: t.indianCuisine, imageAsset: 'assets/images/cuisine_indian.jpg'),
      Cuisine(label: t.chineseCuisine, imageAsset: 'assets/images/cuisine_chinese.jpg'),
      Cuisine(label: t.japaneseCuisine, imageAsset: 'assets/images/cuisine_japanese.jpg'),
      Cuisine(label: t.seafoodCuisine, imageAsset: 'assets/images/cuisine_seafood.jpg'),
      Cuisine(label: t.fastFoodCuisine, imageAsset: 'assets/images/cuisine_fastfood.jpg'),
      Cuisine(label: t.dessertsAndCafes, imageAsset: 'assets/images/cuisine_dessert.jpg'),
    ];
  }

  void _toggle(int index) {
    setState(() {
      _cuisines[index].selected = !_cuisines[index].selected;
    });
  }

  Future<void> _saveCuisines() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    List<String> selected = _cuisines
        .where((c) => c.selected)
        .map((c) => c.label)
        .toList();

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'favoriteCuisine': selected,
    });
  }

  Future<void> _finish() async {
    await _saveCuisines();
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.chooseFavoriteCuisine),
          centerTitle: true,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _cuisines.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final cuisine = _cuisines[index];
            return GestureDetector(
              onTap: () => _toggle(index),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      cuisine.imageAsset,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    if (cuisine.selected)
                      Container(
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8,
                        ),
                        color: Colors.black54,
                        child: Text(
                          cuisine.label,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _finish,
            child: Text(t.next),
          ),
        ),
      ),
    );
  }
} 