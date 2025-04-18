import 'package:disertatie/screens/crypto/crypto_screen.dart';
import 'package:disertatie/screens/phishing/phishing_screen.dart';
import 'package:disertatie/screens/reset_password/reset_password_confirmation_screen.dart';
import 'package:disertatie/screens/reset_password/reset_password_screen.dart';
import 'package:disertatie/screens/splash_screen/splash_screen.dart';
import 'package:disertatie/utils/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:disertatie/screens/login_screen/login_screen.dart';
import 'package:disertatie/screens/main_screen/main_screen.dart';
import 'package:disertatie/screens/register_screen/register_screen.dart';

class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: Routes.splashScreen,
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: Routes.registerScreen,
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        name: Routes.mainScreen,
        path: '/main',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        name: Routes.loginScreen,
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: Routes.resetPasswordScreen,
        path: '/resetPassword',
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        name: Routes.resetPasswordConfirmationScreen,
        path: '/resetPasswordConfirmationScreen',
        builder: (context, state) => const ResetPasswordConfirmationScreen(),
      ),
      GoRoute(
        name: Routes.cryptoScreen,
        path: '/cryptoScreen',
        builder: (context, state) => const CryptoScreen(),
      ),
      GoRoute(
        name: Routes.phishingScreen,
        path: '/phishingScreen',
        builder: (context, state) => const PhishingScreen(),
      ),
    ],
  );
}
