import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_widgets.dart';

/// Screen 4 – Register New Account
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: _RegisterBody()),
      ),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  const _RegisterBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Center(child: AppLogo(size: 70)),
          const SizedBox(height: 32),
          const LabeledTextField(label: 'الأسم', hint: 'مثال: Albatul'),
          const SizedBox(height: 16),
          const LabeledTextField(
            label: 'البريد الالكتروني',
            hint: 'مثال :email@domain.com',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          const _BirthDateField(),
          const SizedBox(height: 16),
          const LabeledTextField(
            label: 'كلمة المرور',
            hint: '',
            isPassword: true,
          ),
          const SizedBox(height: 16),
          const LabeledTextField(
            label: 'تأكيد كلمة المرور',
            hint: '',
            isPassword: true,
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            label: 'التالي',
            onPressed: () => Navigator.pushNamed(context, '/email-confirm'),
            trailing: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }
}

class _BirthDateField extends StatelessWidget {
  const _BirthDateField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'تاريخ الميلاد',
          style: AppTextStyles.bodyLarge,
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _pickDate(context),
          child: AbsorbPointer(
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '  /   /',
                hintTextDirection: TextDirection.ltr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _pickDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
  }
}
