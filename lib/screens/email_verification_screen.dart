import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isLoading = false;
  bool canResendEmail = false;

  @override
  void initState() {
    super.initState();
    _sendVerificationEmail();
  }

  Future<void> _sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await user.sendEmailVerification();

      setState(() => canResendEmail = false);

      await Future.delayed(const Duration(seconds: 30));
      if (mounted) {
        setState(() => canResendEmail = true);
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'فشل إرسال رابط التحقق')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    }
  }

  Future<void> _checkEmailVerified() async {
    setState(() => isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await user.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser;

      if (refreshedUser != null && refreshedUser.emailVerified) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/interests');
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('لم يتم التحقق من البريد الإلكتروني بعد'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _goBackToLogin() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser?.email ?? 'email@domain.com';
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('التحقق من البريد الإلكتروني'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Icon(
                Icons.mark_email_read_outlined,
                size: 80,
                color: Colors.brown,
              ),
              const SizedBox(height: 24),
              const Text(
                'تحقق من بريدك الإلكتروني',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'أرسلنا رابط التحقق إلى:\n$userEmail',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              const Text(
                'افتح بريدك الإلكتروني واضغط على رابط التحقق، ثم ارجع واضغط على زر "تحققت".',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: isLoading ? null : _checkEmailVerified,
                child: Text(isLoading ? 'جاري التحقق...' : 'تحققت'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: canResendEmail ? _sendVerificationEmail : null,
                child: const Text('إعادة إرسال رابط التحقق'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _goBackToLogin,
                child: const Text('العودة لتسجيل الدخول'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}