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
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final selected = _moods
        .where((mood) => mood.selected)
        .map((mood) => mood.label)
        .toList();

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'moods': selected,
    });
  }

  Future<void> _finish() async {
    await _saveMoods();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/cuisine');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Image.asset(
  'assets/images/gh.png',
  width: double.infinity,
  height: 45,
  fit: BoxFit.cover,
),
            const _TopImageHero(),
            Expanded(
              child: Column(
                children: [
                  _MoodHeader(onNext: _finish),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        childAspectRatio: 1.05,
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
          ],
        ),
      ),
    );
  }
}

class _TopImageHero extends StatelessWidget {
  const _TopImageHero();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;return SizedBox(
      width: double.infinity,
      height: 88,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/auth_bg.png',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.38),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                t.moodHeroTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
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
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onNext,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF8A4F08),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Row(
                children: [
                  Text(
                    t.next,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 17,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Text(
              t.choosePreferredMood,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2B1B0F),
              ),
            ),
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
  });@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: mood.selected
              ? Border.all(
                  color: const Color(0xFF8A4F08),
                  width: 3,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                mood.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.border,
                  child: const Icon(
                    Icons.image,
                    color: AppColors.textSecondary,
                    size: 40,
                  ),
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.18),
              ),
              if (mood.selected)
                Container(
                  color: const Color(0xFF8A4F08).withOpacity(0.25),
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
                  color: Colors.black.withOpacity(0.42),
                  child: Text(
                    mood.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}