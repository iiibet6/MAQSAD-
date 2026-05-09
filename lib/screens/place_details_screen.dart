import 'dart:io';

import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/place_model.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final Place place;

  const PlaceDetailsScreen({
    super.key,
    required this.place,
  });

  Future<void> _captureAndUpload(BuildContext context) async {
    try {
      final picker = ImagePicker();

      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (pickedFile == null) return;

      final appDir = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      final savedImage = await File(pickedFile.path).copy(
        '${appDir.path}/$fileName',
      );

      final prefs = await SharedPreferences.getInstance();
      final photos = prefs.getStringList('local_photos') ?? [];

      photos.add(savedImage.path);

      await prefs.setStringList('local_photos', photos);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حفظ الصورة في ألبوم الذكريات'),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء حفظ الصورة: $e'),
        ),
      );
    }
  }

  Future<void> _saveRating(BuildContext context, int rating) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب تسجيل الدخول لحفظ التقييم'),
        ),
      );
      return;
    }

    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    final snapshot = await userRef.get();
    final data = snapshot.data() ?? {};

    List ratings = data['ratings'] ?? [];

    ratings.removeWhere(
      (item) => item['title'] == place.title,
    );

    ratings.add({
      'title': place.title,
      'type': place.category,
      'category': place.category,
      'tags': '${place.category},${place.locationName}',
      'rating': rating,
    });

    await userRef.update({
      'ratings': ratings,
    });

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم حفظ تقييمك: $rating نجوم'),
      ),
    );
  }

  void _rateExperience(BuildContext context) {
    int selectedRating = 0;showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 55,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'قيّم تجربتك',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => GestureDetector(
                          onTap: () {
                            setModalState(() {
                              selectedRating = index + 1;
                            });
                          },
                          child: Icon(
                            index < selectedRating
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            color: Colors.amber,
                            size: 42,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: selectedRating == 0
                            ? null
                            : () async {
                                Navigator.pop(context);
                                await _saveRating(context, selectedRating);
                              },
                        child: const Text('حفظ التقييم'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _openMap() async {
    Uri url;

    if (place.plusCode != null && place.plusCode!.isNotEmpty) {
      url = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(place.plusCode!)}",
      );
    } else {
      url = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${place.latitude},${place.longitude}",
      );
    }

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }@override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  place.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            place.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ARViewPage(modelPath: place.modelPath),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text("AR"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "عن المكان",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(place.description),
                ),
                const SizedBox(height: 20),
                const Text(
                  "أوقات العمل",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(place.workingHours),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "موقع المكان",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("العنوان: ${place.locationName}"),
                      const SizedBox(height: 6),
                      Text("الإحداثيات: ${place.latitude}, ${place.longitude}"),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: _openMap,
                        icon: const Icon(Icons.location_on),
                        label: const Text("فتح في خرائط Google"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => _rateExperience(context),
                        child: const _ActionIcon(
                          Icons.star_border,
                          "قيم تجربتك",
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _captureAndUpload(context),
                        child: const _ActionIcon(
                          Icons.photo_camera_outlined,
                          "التقط",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ARViewPage extends StatelessWidget {
  final String modelPath;

  const ARViewPage({super.key, required this.modelPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الواقع المعزز")),
      body: ModelViewer(
        src: modelPath,
        ar: true,
        autoRotate: true,
        cameraControls: true,
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionIcon(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11),
        ),
      ],
    );
  }
}