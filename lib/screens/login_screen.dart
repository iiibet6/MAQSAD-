import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> _login() async {
    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // 🔥 هنا الانتقال لشاشة الاهتمامات
      Navigator.pushReplacementNamed(context, '/interests');

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'حدث خطأ')),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                const SizedBox(height: 40),
                const Center(child: AppLogo(size: 60)),
                const SizedBox(height: 40),

                /// Email
                LabeledTextField(
                  label: 'البريد الالكتروني',
                  hint: 'email@domain.com',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                /// Password
                LabeledTextField(
                  label: 'الرمز السري',
                  hint: '',
                  controller: passwordController,
                  isPassword: true,
                ),

                const SizedBox(height: 30),

                /// Login Button
                PrimaryButton(
                  label: isLoading ? 'جاري الدخول...' : 'دخول',
                  onPressed: isLoading ? null : _login,
                ),

                const SizedBox(height: 20),

                const OrDivider(),

                const SizedBox(height: 20),

                /// Register Button
                PrimaryButton(
                  label: 'إنشاء حساب جديد',
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}