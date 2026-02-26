import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

/// Screen 3 – Login
/// Background photo at top, white card (bottom sheet feel) with form.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _LoginBody(),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top photo section
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.22,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/auth_bg.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: const Color(0xFF87CEEB)),
              ),
            ],
          ),
        ),
        // White card
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: const _LoginForm(),
          ),
        ),
      ],
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Drag handle + close
          _FormHeader(onClose: () => Navigator.pop(context)),
          const SizedBox(height: 16),
          // Logo small
          const Center(child: AppLogo(size: 60)),
          const SizedBox(height: 24),
          // Email
          LabeledTextField(
            label: 'البريد الالكتروني',
            hint: 'مثال :email@domain.com',
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          // Password
          LabeledTextField(
            label: 'الرمز السري',
            hint: '',
            isPassword: true,
            controller: _passCtrl,
          ),
          const SizedBox(height: 8),
          // Forgot password
          GestureDetector(
            onTap: () {},
            child: const Text(
              'إعادة تعيين كلمة السر',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13,
                decoration: TextDecoration.underline,
                color: AppColors.textPrimary,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 20),
          // Login button
          PrimaryButton(
            label: 'دخول',
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
          ),
          const SizedBox(height: 20),
          const _OrDivider(),
          const SizedBox(height: 20),
          // Register button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('إنشاء حساب جديد', style: AppTextStyles.button),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormHeader extends StatelessWidget {
  final VoidCallback onClose;
  const _FormHeader({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.textSecondary),
          onPressed: onClose,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const Spacer(),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const Spacer(),
        const SizedBox(width: 32),
      ],
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.divider, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'أو',
            style: AppTextStyles.caption.copyWith(fontSize: 14),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.divider, thickness: 1)),
      ],
    );
  }
}
