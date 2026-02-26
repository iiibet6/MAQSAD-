import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

/// Screen 2 – Auth Choice
/// Full-screen landscape photo with logo + two action buttons.
class AuthChoiceScreen extends StatelessWidget {
  const AuthChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _AuthChoiceBody(),
      ),
    );
  }
}

class _AuthChoiceBody extends StatelessWidget {
  const _AuthChoiceBody();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Full screen background image
        Image.asset(
          'assets/images/auth_bg.png',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF87CEEB), Color(0xFF4A7B4A), Color(0xFF2A5A2A)],
              ),
            ),
          ),
        ),
        // Content overlay
        SafeArea(
  child: Column(
    children: [
      const SizedBox(height: 190),

      const AppLogo(size: 130),

      const SizedBox(height: 60), // 👈 تحكم في المسافة

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: _AuthButtons(),
      ),

      const SizedBox(height: 60), // 👈 هذا يرفع الأزرار لفوق
    ],
  ),
),
      ],
    );
  }
}

class _AuthButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Primary: sign in / register
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary.withOpacity(0.9),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              'تسجيل دخول أو تسجيل جديد',
              style: AppTextStyles.button,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Secondary: guest
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: Text(
              'الدخول كضيف',
              style: AppTextStyles.button.copyWith(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
