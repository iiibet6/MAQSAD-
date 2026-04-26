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
    String uid = FirebaseAuth.instance.currentUser!.uid;

    List<String> selected = _interests
        .where((interest) => interest.selected)
        .map((interest) => interest.label)
        .toList();

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'interests': selected,
    });
  }

  Future<void> _handleNext() async {
    await _saveSelectedInterests();
    Navigator.pushReplacementNamed(context, '/mood');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        body: Column(
          children: [
            const PatternBorderFallback(),
            const _InterestsHero(),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    _InterestsHeader(onNext: _handleNext),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.0,
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
            ),
          ],
        ),
      ),
    );
  }
}

class _InterestsHero extends StatelessWidget {
  const _InterestsHero();

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
        color: Color(0xFF4A7B4A),
      ),
      child: Text(
        t.interestsHeroTitle,
        style: AppTextStyles.headline2.copyWith(
          color: Colors.white,
          fontSize: 22,
        ),
        textAlign: TextAlign.right,
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
            t.favoriteHobbiesQuestion,
            style: AppTextStyles.sectionTitle,
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
            Container(color: Colors.black.withOpacity(0.15)),
            if (interest.selected)
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
                  interest.label,
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