// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/place_model.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final Place place;

  const PlaceDetailsScreen({
    super.key,
    required this.place,
  });

  /// 📸 التقاط صورة
  Future<void> _captureAndUpload(BuildContext context) async {
    // الكود الأصلي الخاص بالتقاط الصورة ورفعها إلى Firebase Storage
    // موقوف مؤقتًا بسبب مشكلة iOS simulator مع firebase_storage.
    //
    // كان ممكن يكون فيه شيء مثل:
    // final picker = ImagePicker();
    // final pickedFile = await picker.pickImage(source: ImageSource.camera);
    // if (pickedFile == null) return;
    //
    // final user = FirebaseAuth.instance.currentUser;
    // if (user == null) return;
    //
    // final file = File(pickedFile.path);
    // final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    //
    // final ref = FirebaseStorage.instance
    //     .ref()
    //     .child('users/${user.uid}/photos/$fileName.jpg');
    //
    
    // await ref.putFile(file);
    // final imageUrl = await ref.getDownloadURL();
    //
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(user.uid)
    //     .collection('photos')
    //     .add({
    //   'imageUrl': imageUrl,
    //   'createdAt': FieldValue.serverTimestamp(),
    // });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ميزة التقاط ورفع الصورغير  متاحة حاليا'),
      ),
    );
  }

  /// ⭐️ تقييم
  void _rateExperience(BuildContext context) {
    // ضعي منطق التقييم هنا لاحقًا
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
  }

  @override
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
                /// الصورة + AR
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

                /// 📍 الموقع
                const Text(
                  "موقع المكان",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                Container(
                  padding: const EdgeInsets.all(12),
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

                /// الأزرار
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