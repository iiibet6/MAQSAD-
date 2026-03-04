import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    if (passwordController.text.isEmpty) return;

    setState(() => isLoading = true);

    try {
      await user!.updatePassword(passwordController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم تغيير كلمة المرور بنجاح ✅")),
      );

      passwordController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("يجب تسجيل الدخول مجددًا قبل تغيير كلمة المرور")),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text("معلوماتي")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "الاسم",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(user?.displayName ?? "غير متوفر"),
              ),

              const SizedBox(height: 20),

              const Text(
                "البريد الإلكتروني",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(user?.email ?? "غير متوفر"),
              ),

              const SizedBox(height: 30),

              const Text(
                "تغيير كلمة المرور",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "أدخل كلمة مرور جديدة",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _changePassword,
                  child: Text(isLoading
                      ? "جاري التحديث..."
                      : "تحديث كلمة المرور"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}