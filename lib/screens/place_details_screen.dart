import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final String title;
  final String image;

  const PlaceDetailsScreen({
    super.key,
    required this.title,
    required this.image,
  });

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

                /// 🔙 سهم + تقييم
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    const Text("4.5 ⭐"),
                  ],
                ),

                /// 🏷️ العنوان
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                /// 📷 الصورة
                ClipRRect(
  borderRadius: BorderRadius.circular(18),
  child: SizedBox(
    height: 220, // 👈 صغّري / كبّري حسب ذوقك
    width: double.infinity,
    child: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text("AR"),
          ),
        ),
      ],
    ),
  ),
),
                const SizedBox(height: 20),

                /// 📖 عن المكان
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: const Text(
"تُعد منازل حاتم الطائي في قرية توارن -موطن الكرم العربي الأصيل وموطن حاتم الطائي- رمز الجود والسخاء في التراث العربي. بآثارها، وواديها، وجبالها المحيطة، تبقى شاهدًا حيًا على تاريخٍ خالد، ووجهة سياحية تعزز مكانة حائل كحاضنة للتراث والتاريخ."                  ),
                ),

                const SizedBox(height: 20),

                /// ⏰ أوقات العمل
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
  child: const Center(
    child: Text(
      "مفتوح طوال الوقت",
      style: TextStyle(fontWeight: FontWeight.w500),
    ),
  ),
),

                const SizedBox(height: 20),

                /// 🗺️ الخريطة
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6DCD2),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Center(
                    child: Text("خريطة الموقع"),
                  ),
                ),

                const SizedBox(height: 20),

                /// 🔘 شريط الأيقونات السفلي
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: const [
    _ActionIcon(Icons.favorite_border, "أضف للمفضلة"),
    _ActionIcon(Icons.star_border, "قيم تجربتك"),
    _ActionIcon(Icons.photo_camera_outlined, "التقط"),
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