import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _controller = PageController();
  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      "image": "assets/images/onboard1.jpg",
      "title": "اكتشف أفضل الأماكن في حائل",
      "desc":
          "استعرض المقاهي والمطاعم والوجهات المميزة بسهولة في مكان واحد",
    },
    {
      "image": "assets/images/onboard2.jpg",
      "title": "توصيات تناسبك!",
      "desc":
          "مقصد يقترح لك أماكن بناءً على تقييمات المستخدمين واهتماماتك",
    },
    {
      "image": "assets/images/onboard3.jpg",
      "title": "اسأل حاتم",
      "desc":
          "تحدث مع حاتم، المساعد الذكي في مقصد، واحصل على اقتراحات لأفضل الأماكن في حائل",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [

            /// زر تخطي
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/auth-choice");
                },
                child: const Text("تخطي"),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {

                  final page = pages[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        /// الصورة
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          child: Image.asset(
                            page["image"]!,
                            height: 220,
                          ),
                        ),

                        const SizedBox(height: 40),
                        Text(
                          page["title"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// الوصف
                        Text(
                          page["desc"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            /// المؤشرات
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.all(4),
                  height: 8,
                  width: currentPage == index ? 20 : 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? Colors.brown
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

),

            const SizedBox(height: 20),

            /// زر التالي
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3E2A1E),
 minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {

                  if (currentPage == pages.length - 1) {
                    Navigator.pushReplacementNamed(context, "/auth-choice");
                  } else {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut);
                  }
                },
                child: Text(
                  currentPage == pages.length - 1
                      ? "ابدأ الآن"
                      : "التالي",
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}