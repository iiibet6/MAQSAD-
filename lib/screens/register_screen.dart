import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';
import '../l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  DateTime? selectedDate;
  bool isLoading = false;

  String countryCode = '+966';

  Future<void> _register() async {
    final t = AppLocalizations.of(context)!;

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.passwordsDoNotMatch)),
      );
      return;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.selectBirthDateMessage)),
      );
      return;
    }

    if (phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.enterPhoneMessage)),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final user = userCredential.user;
      final uid = user!.uid;

      await user.updateDisplayName(nameController.text.trim());

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': '$countryCode${phoneController.text.trim()}',
        'birthDate': Timestamp.fromDate(selectedDate!),
        'interests': [],
        'favorites': [],
        'createdAt': FieldValue.serverTimestamp(),
      });

      await user.sendEmailVerification();

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/email-verification');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? t.generalError)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${t.unexpectedError}: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
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
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

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
                const SizedBox(height: 32),LabeledTextField(
                  label: t.name,
                  hint: t.nameExample,
                  controller: nameController,
                ),

                const SizedBox(height: 16),

                LabeledTextField(
                  label: t.email,
                  hint: 'email@domain.com',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                LabeledTextField(
                  label: t.phoneNumber,
                  hint: t.phoneExample,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  prefix: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: countryCode,
                      items: const [
                        DropdownMenuItem(value: '+966', child: Text('🇸🇦 +966')),
                        DropdownMenuItem(value: '+971', child: Text('🇦🇪 +971')),
                        DropdownMenuItem(value: '+965', child: Text('🇰🇼 +965')),
                        DropdownMenuItem(value: '+20', child: Text('🇪🇬 +20')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          countryCode = value!;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      t.birthDate,
                      style: AppTextStyles.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _pickDate,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.inputBorder,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          selectedDate == null
                              ? t.selectDate
                              : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                LabeledTextField(
                  label: t.password,
                  hint: '',
                  controller: passwordController,
                  isPassword: true,
                ),

                const SizedBox(height: 16),

                LabeledTextField(
                  label: t.confirmPassword,
                  hint: '',
                  controller: confirmPasswordController,
                  isPassword: true,
                ),

                const SizedBox(height: 40),

                PrimaryButton(
                  label: isLoading ? t.registering : t.next,
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