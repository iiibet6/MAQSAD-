import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../l10n/app_localizations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/language');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.of(context),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: _WelcomeBody(),
      ),
    );
  }
}

class _WelcomeBody extends StatelessWidget {
  const _WelcomeBody();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Expanded(
          flex: 55,
          child: _TopSection(screenWidth: size.width),
        ),
        const Expanded(
          flex: 45,
          child: _BottomPhoto(),
        ),
      ],
    );
  }
}

class _TopSection extends StatelessWidget {
  final double screenWidth;

  const _TopSection({
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogo(size: 200),
          const SizedBox(height: 24),
          Text(
            t.welcomeToHail,
            style: AppTextStyles.headline1.copyWith(fontSize: 32),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _BottomPhoto extends StatelessWidget {
  const _BottomPhoto();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(
        'assets/images/welcome_landscape.png',
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF8B7355),
                Color(0xFF4A3728),
                Color(0xFF2D1A0A),
              ],
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.landscape,
              size: 80,
              color: Colors.white54,
            ),
          ),
        ),
      ),
    );
  }
}