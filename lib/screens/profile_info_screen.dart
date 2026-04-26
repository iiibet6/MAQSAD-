import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../l10n/app_localizations.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final user = FirebaseAuth.instance.currentUser;

  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> _changePassword() async {
    final t = AppLocalizations.of(context)!;

    if (passwordController.text.isEmpty) return;

    setState(() => isLoading = true);

    try {
      await user!.updatePassword(
        passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.passwordChangedSuccess,
          ),
        ),
      );

      passwordController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.reloginRequired,
          ),
        ),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: Directionality.of(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.myInfo),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                t.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Text(
                  user?.displayName ?? t.notAvailable,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                t.email,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Text(
                  user?.email ?? t.notAvailable,
                ),
              ),

              const SizedBox(height: 30),

              Text(
                t.changePassword,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: passwordController,
                obscureText: true,

                decoration: InputDecoration(
                  hintText: t.enterNewPassword,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed:
                      isLoading ? null : _changePassword,child: Text(
                    isLoading
                        ? t.updating
                        : t.updatePassword,
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