import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/auth_choice_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/interests_screen.dart';
import 'screens/home_screen.dart';
import 'screens/account_screen.dart';
import 'screens/map_screen.dart';
import 'screens/explore_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp],
  );

  runApp(const MaqsadApp());
}

class MaqsadApp extends StatelessWidget {
  const MaqsadApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      title: 'مقصد',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,

      // 🔥 نحدد البداية حسب حالة تسجيل الدخول
      initialRoute: user == null ? '/' : '/interests',

      routes: {
        '/': (_) => const WelcomeScreen(),
        '/auth-choice': (_) => const AuthChoiceScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/interests': (_) => const InterestsScreen(),
        '/home': (_) => const HomeScreen(),
        '/account': (_) => const AccountScreen(),
        '/map': (_) => const MapScreen(),
        '/explore': (_) => const ExploreScreen(),
      },
    );
  }
}