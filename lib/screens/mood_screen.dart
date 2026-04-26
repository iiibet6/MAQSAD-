import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../l10n/app_localizations.dart';

class Mood {
  final String label;
  final String imageAsset;
  bool selected;

  Mood({
    required this.label,
    required this.imageAsset,
    this.selected = false,
  });
}

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  late List<Mood> _moods;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final t = AppLocalizations.of(context)!;

    _moods = [
      Mood(label: t.calmMood, imageAsset: 'assets/images/mood_calm.jpg'),
      Mood(label: t.familyMood, imageAsset: 'assets/images/mood_family.jpg'),
      Mood(label: t.livelyMood, imageAsset: 'assets/images/mood_lively.jpg'),
      Mood(label: t.romanticMood, imageAsset: 'assets/images/mood_romantic.jpg'),
      Mood(label: t.natureMood, imageAsset: 'assets/images/mood_nature.jpg'),
      Mood(label: t.adventureMood, imageAsset: 'assets/images/mood_adventure.jpg'),
    ];
  }

  void _toggle(int index) {
    setState(() {
      _moods[index].selected = !_moods[index].selected;
    });
  }

  Future<void> _saveMoods() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    List<String> selected = _moods
        .where((mood) => mood.selected)
        .map((mood) => mood.label)
        .toList();

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'moods': selected,
    });
  }

  Future<void> _finish() async {
    await _saveMoods();
    Navigator.pushReplacementNamed(context, '/cuisine');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        body: Column(
          children: [
            const PatternBorderFallback(),
            const _MoodHero(),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    _MoodHeader(onNext: _finish),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                        itemCount: _moods.length,
                        itemBuilder: (ctx, i) => MoodCard(
                          mood: _moods[i],
                          onTap: () => _toggle(i),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodHero extends StatelessWidget {
  const _MoodHero();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/auth_bg.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
        ),
      ),
      child: Text(
        t.moodHeroTitle,
        style: AppTextStyles.headline2.copyWith(
          color: Colors.white,
          fontSize: 22,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }
}

class _MoodHeader extends StatelessWidget {
  final VoidCallback onNext;

  const _MoodHeader({required this.onNext});
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onNext,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(
                    t.next,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          Text(
            t.choosePreferredMood,
            style: AppTextStyles.sectionTitle,
          ),
        ],
      ),
    );
  }
}

class MoodCard extends StatelessWidget {
  final Mood mood;
  final VoidCallback onTap;

  const MoodCard({
    super.key,
    required this.mood,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              mood.imageAsset,
              fit: BoxFit.cover,
            ),
            Container(color: Colors.black.withOpacity(0.2)),
            if (mood.selected)
              Container(
                color: AppColors.accent.withOpacity(0.45),
                child: const Center(
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                color: Colors.black.withOpacity(0.35),
                child: Text(
                  mood.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}