import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class ArabicPatternBorder extends StatelessWidget {
  const ArabicPatternBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 1, // عدليها حسب السماكة اللي تبين
      child: Image.asset(
        'assets/images/pattern_border.png',
        fit: BoxFit.fitWidth, // 👈 أهم سطر
        alignment: Alignment.topCenter, // 👈 يوسّطها
      ),
    );
  }
}

class PatternBorderFallback extends StatelessWidget {
  const PatternBorderFallback({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14,
      color: AppColors.primary,
      child: Row(
        children: List.generate(
          40,
          (i) => Expanded(
            child: Container(
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: i.isEven ? AppColors.accent : AppColors.primaryDark,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  App Logo
// ─────────────────────────────────────────────
class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: size,
      height: size,
      errorBuilder: (_, __, ___) => Icon(
        Icons.location_on,
        size: size,
        color: AppColors.accent,
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Primary filled button
// ─────────────────────────────────────────────
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? trailing;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (trailing != null) ...[
              trailing!,
              const SizedBox(width: 8),
            ],
            Text(label, style: AppTextStyles.button),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Outlined button
// ─────────────────────────────────────────────
class OutlinedAppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const OutlinedAppButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(label, style: AppTextStyles.buttonOutlined),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Labeled Text Field
// ─────────────────────────────────────────────
class LabeledTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label,
            style: AppTextStyles.bodyLarge,
            textDirection: TextDirection.rtl),
        const SizedBox(height: 8),
        _PasswordAwareField(
          hint: hint,
          isPassword: isPassword,
          controller: controller,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}

class _PasswordAwareField extends StatefulWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const _PasswordAwareField({
    required this.hint,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<_PasswordAwareField> createState() => _PasswordAwareFieldState();
}

class _PasswordAwareFieldState extends State<_PasswordAwareField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword && _obscure,
      keyboardType: widget.keyboardType,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintTextDirection: TextDirection.rtl,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: () =>
                    setState(() => _obscure = !_obscure),
              )
            : null,
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Section Header
// ─────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (trailing != null) trailing!,
        Text(title,
            style: AppTextStyles.sectionTitle,
            textDirection: TextDirection.rtl),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Bottom Navigation Bar (FIXED VERSION)
// ─────────────────────────────────────────────
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/account');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/map');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/explore');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/home');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _navigate(context, index),
      backgroundColor: AppColors.navBarBg,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: AppColors.textSecondary,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      items:  [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Account',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          label: 'Map',
        ),
        BottomNavigationBarItem(
  icon: Image.asset(
    'assets/icons/image_search.png',
    width: currentIndex == 2 ? 28 : 24,
    height: currentIndex == 2 ? 28 : 24,
    color: currentIndex == 2
        ? AppColors.accent
        : AppColors.textSecondary,
  ),
  label: 'Explore',
),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
      ],
    );
  }
}
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.divider,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'أو',
            style: AppTextStyles.caption.copyWith(fontSize: 14),
          ),
        ),
        const Expanded(
          child: Divider(
            color: AppColors.divider,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}