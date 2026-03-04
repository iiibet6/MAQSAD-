import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  DateTime? selectedDate;
  bool isLoading = false;

  Future<void> _register() async {

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمتا المرور غير متطابقتين')),
      );
      return;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اختاري تاريخ الميلاد')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {

      // 🔐 إنشاء الحساب في Authentication
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final uid = userCredential.user!.uid;

      // 🗄 إنشاء document في Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'birthDate': Timestamp.fromDate(selectedDate!),
        'interests': [],
        'favorites': [],
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 🚀 الانتقال
      Navigator.pushReplacementNamed(context, '/interests');

    } on FirebaseAuthException catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'حدث خطأ')),
      );

    } catch (e) {
  print(e.toString());
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(e.toString())),
  );
}
    setState(() => isLoading = false);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                const Center(child: AppLogo(size: 70)),
                const SizedBox(height: 32),

                LabeledTextField(
                  label: 'الأسم',
                  hint: 'مثال: Albatul',
                  controller: nameController,
                ),

                const SizedBox(height: 16),

                LabeledTextField(
                  label: 'البريد الالكتروني',
                  hint: 'email@domain.com',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                /// تاريخ الميلاد
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'تاريخ الميلاد',
                      style: AppTextStyles.bodyLarge,
                    ),const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _pickDate,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.inputBorder, width: 1.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          selectedDate == null
                              ? 'اختر التاريخ'
                              : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                LabeledTextField(
                  label: 'كلمة المرور',
                  hint: '',
                  controller: passwordController,
                  isPassword: true,
                ),

                const SizedBox(height: 16),

                LabeledTextField(
                  label: 'تأكيد كلمة المرور',
                  hint: '',
                  controller: confirmPasswordController,
                  isPassword: true,
                ),

                const SizedBox(height: 40),

                PrimaryButton(
                  label: isLoading ? 'جاري التسجيل...' : 'التالي',
                  onPressed: isLoading ? null : _register,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}