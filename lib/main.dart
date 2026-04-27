import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';

import 'screens/welcome_screen.dart';
import 'screens/language_selection_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/auth_choice_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/interests_screen.dart';
import 'screens/home_screen.dart';
import 'screens/account_screen.dart';
import 'screens/map_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/mood_screen.dart';
import 'screens/cuisine_screen.dart';
import 'screens/email_verification_screen.dart';
import 'screens/chat_screen.dart';
import 'services/favorites_service.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FavoritesService.loadFavorites();
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MaqsadApp());
}

class MaqsadApp extends StatefulWidget {
  const MaqsadApp({super.key});

  static _MaqsadAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MaqsadAppState>();

  @override
  State<MaqsadApp> createState() => _MaqsadAppState();
}

class _MaqsadAppState extends State<MaqsadApp> {

  Locale _locale = const Locale('ar');

  void changeLanguage(String code) {
    setState(() {
      _locale = Locale(code);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      title: 'مقصد',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,

      locale: _locale,

      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],

      // 🌍 ملفات الترجمة
      localizationsDelegates: AppLocalizations.localizationsDelegates,

      // 🌍 fallback
      localeResolutionCallback: (locale, supportedLocales) {
        return supportedLocales.contains(locale)
            ? locale
            : const Locale('ar');
      },

      builder: (context, child) {
        final isArabic =
            Localizations.localeOf(context).languageCode == 'ar';

        return Directionality(
          textDirection:
              isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },

      initialRoute: user == null ? '/' : '/interests',

      routes: {
        '/': (_) => const WelcomeScreen(),
        '/language': (_) => const LanguageSelectionScreen(),
        '/onboarding': (_) => const OnboardingScreen(),
        '/auth-choice': (_) => const AuthChoiceScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/email-verification': (_) => const EmailVerificationScreen(),
        '/interests': (_) => const InterestsScreen(),
        '/mood': (_) => const MoodScreen(),
        '/cuisine': (_) => const CuisineScreen(),
        '/home': (_) => const HomeScreen(),
        '/account': (_) => const AccountScreen(),
        '/map': (_) => const MapScreen(),
        '/explore': (_) => const ExploreScreen(),
        '/chatbot': (_) => const ChatScreen(),
      },
    );
  }
}