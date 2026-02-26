import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/auth_choice_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/interests_screen.dart';
import 'screens/home_screen.dart';
import 'screens/account_screen.dart';
import 'screens/map_screen.dart';
import 'screens/explore_screen.dart'; // 👈 الجديد

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MaqsadApp());
}

class MaqsadApp extends StatelessWidget {
  const MaqsadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مقصد',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (_) => const WelcomeScreen(),
        '/auth-choice': (_) => const AuthChoiceScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/interests': (_) => const InterestsScreen(), // onboarding فقط
        '/home': (_) => const HomeScreen(),
        '/account': (_) => const AccountScreen(),
        '/map': (_) => const MapScreen(),
        '/explore': (_) => const ExploreScreen(), // 👈 الجديد
      },
    );
  }
}