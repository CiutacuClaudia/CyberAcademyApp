import 'package:disertatie/screens/splash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:disertatie/screens/login_screen/login_screen.dart';
import 'package:disertatie/screens/main_screen/main_screen.dart';
import 'package:disertatie/screens/register_screen/register_screen.dart';

class AppRouter {
  static final GoRouter goRouter =  GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/main',
          builder: (context, state) => const MainScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
      ],
    );
  }
