import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../l10n/app_localizations.dart';

class Interest {
  final String label;
  final String imageAsset;
  bool selected;

  Interest({
    required this.label,
    required this.imageAsset,
    this.selected = false,
  });
}

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  late List<Interest> _interests;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final t = AppLocalizations.of(context)!;

    _interests = [
      Interest(label: t.videoGames, imageAsset: 'assets/images/interest_videogames.png'),
      Interest(label: t.chess, imageAsset: 'assets/images/interest_chess.jpg'),
      Interest(label: t.basketball, imageAsset: 'assets/images/interest_basketball.jpg'),
      Interest(label: t.volleyball, imageAsset: 'assets/images/interest_volleyball.jpg'),
      Interest(label: t.football, imageAsset: 'assets/images/interest_football.png'),
      Interest(label: t.swimming, imageAsset: 'assets/images/interest_swimming.jpg'),
      Interest(label: t.drawing, imageAsset: 'assets/images/interest_drawing.jpg'),
      Interest(label: t.horseRiding, imageAsset: 'assets/images/interest_horses.jpg'),
      Interest(label: t.cooking, imageAsset: 'assets/images/interest_cooking.jpg'),
      Interest(label: t.photography, imageAsset: 'assets/images/interest_photography.jpg'),
    ];
  }

  void _toggle(int index) {
    setState(() {
      _interests[index].selected = !_interests[index].selected;
    });
  }

  Future<void> _saveSelectedInterests() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final selected = _interests
        .where((interest) => interest.selected)
        .map((interest) => interest.label)
        .toList();

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'interests': selected,
    });
  }

  Future<void> _handleNext() async {
    await _saveSelectedInterests();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/mood');
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
                  _InterestsHeader(onNext: _handleNext),
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
                      itemCount: _interests.length,
                      itemBuilder: (ctx, i) => InterestCard(
                        interest: _interests[i],
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
                t.interestsHeroTitle,
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

class _InterestsHeader extends StatelessWidget {
  final VoidCallback onNext;

  const _InterestsHeader({required this.onNext});

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
              t.favoriteHobbiesQuestion,
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

class InterestCard extends StatelessWidget {
  final Interest interest;
  final VoidCallback onTap;

  const InterestCard({
    super.key,
    required this.interest,
    required this.onTap,
  });@override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: interest.selected
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
                interest.imageAsset,
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
              if (interest.selected)
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
                    interest.label,
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