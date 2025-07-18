import 'package:disertatie/router/shell_with_navbar.dart';
import 'package:disertatie/router/shell_with_navbar_admin.dart';
import 'package:disertatie/screens/create_phishing_game/create_phishing_screen.dart';
import 'package:disertatie/screens/crypto/crypto_screen.dart';
import 'package:disertatie/screens/learning/learning_ciphers/learning_ciphers_screen.dart';
import 'package:disertatie/screens/learning/learning_phishing/learning_phishing_screen.dart';
import 'package:disertatie/screens/learning/learning_screen.dart';
import 'package:disertatie/screens/phishing/phishing_screen.dart';
import 'package:disertatie/screens/xss/xss_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:disertatie/utils/routes.dart';

import 'package:disertatie/screens/splash_screen/splash_screen.dart';
import 'package:disertatie/screens/register_screen/register_screen.dart';
import 'package:disertatie/screens/reset_password/reset_password_screen.dart';
import 'package:disertatie/screens/reset_password/reset_password_confirmation_screen.dart';

import '../screens/adminHomeScreen/admin_home_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/learning/learning_viruses/learning_viruses_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/settings/settings_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.splashScreen.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: Routes.splashScreen.name,
        path: Routes.splashScreen.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: Routes.registerScreen.name,
        path: Routes.registerScreen.path,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        name: Routes.loginScreen.name,
        path: Routes.loginScreen.path,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: Routes.resetPasswordScreen.name,
        path: Routes.resetPasswordScreen.path,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        name: Routes.resetPasswordConfirmationScreen.name,
        path: Routes.resetPasswordConfirmationScreen.path,
        builder: (context, state) => const ResetPasswordConfirmationScreen(),
      ),
      StatefulShellRoute(
        builder: (context, state, navigationShell) => navigationShell,
        navigatorContainerBuilder: (
          BuildContext context,
          StatefulNavigationShell navigationShell,
          List<Widget> children,
        ) {
          return AdminShellWithNavbar(
            navigationShell: navigationShell,
            children: children,
          );
        },
        branches: [
          StatefulShellBranch(
            initialLocation: Routes.adminHomeScreen.path,
            navigatorKey: RoutesKeys.homeAdminNavigatorKey,
            routes: [
              GoRoute(
                name: Routes.adminHomeScreen.name,
                path: Routes.adminHomeScreen.path,
                parentNavigatorKey: RoutesKeys.homeAdminNavigatorKey,
                builder: (context, state) => const AdminHomeScreen(),
                routes: [
                  GoRoute(
                    name: Routes.createPhishingGameScreen.name,
                    path: Routes.createPhishingGameScreen.path,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const CreatePhishingScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: Routes.settingsAdminScreen.path,
            navigatorKey: RoutesKeys.settingsAdminNavigatorKey,
            routes: [
              GoRoute(
                name: Routes.settingsAdminScreen.name,
                path: Routes.settingsAdminScreen.path,
                parentNavigatorKey: RoutesKeys.settingsAdminNavigatorKey,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute(
        builder: (context, state, navigationShell) => navigationShell,
        navigatorContainerBuilder: (
          BuildContext context,
          StatefulNavigationShell navigationShell,
          List<Widget> children,
        ) {
          return ShellWithNavbar(
            navigationShell: navigationShell,
            children: children,
          );
        },
        branches: [
          StatefulShellBranch(
            initialLocation: Routes.homeScreen.path,
            navigatorKey: RoutesKeys.homeNavigatorKey,
            routes: [
              GoRoute(
                name: Routes.homeScreen.name,
                path: Routes.homeScreen.path,
                parentNavigatorKey: RoutesKeys.homeNavigatorKey,
                builder: (context, state) => const HomeScreen(),
                routes: [
                  GoRoute(
                    name: Routes.cryptoScreen.name,
                    path: Routes.cryptoScreen.path,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const CryptoScreen(),
                  ),
                  GoRoute(
                    name: Routes.phishingScreen.name,
                    path: Routes.phishingScreen.path,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final code = state.uri.queryParameters['userCode'];
                      return PhishingScreen(userCode: code);
                    },
                  ),
                  GoRoute(
                    name: Routes.xssScreen.name,
                    path: Routes.xssScreen.path,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const XssScreen(),
                  ),
                ],
              ),
            ],
          ),

          StatefulShellBranch(
            initialLocation: Routes.learningScreen.path,
            navigatorKey: RoutesKeys.learningNavigatorKey,
            routes: [
              GoRoute(
                name: Routes.learningScreen.name,
                path: Routes.learningScreen.path,
                parentNavigatorKey: RoutesKeys.learningNavigatorKey,
                builder: (context, state) => const LearningScreen(),
                routes: [
                  GoRoute(
                    name: Routes.learningCiphersScreen.name,
                    path: Routes.learningCiphersScreen.path,
                    parentNavigatorKey: RoutesKeys.learningNavigatorKey,
                    builder: (context, state) => const LearningCiphersScreen(),
                  ),
                  GoRoute(
                    name: Routes.learningVirusesScreen.name,
                    path: Routes.learningVirusesScreen.path,
                    parentNavigatorKey: RoutesKeys.learningNavigatorKey,
                    builder: (context, state) => const LearningVirusesScreen(),
                  ),
                  GoRoute(
                    name: Routes.learningPhishingScreen.name,
                    path: Routes.learningPhishingScreen.path,
                    parentNavigatorKey: RoutesKeys.learningNavigatorKey,
                    builder: (context, state) => const LearningPhishingScreen(),
                  ),
                ],
              ),
            ],
          ),

          StatefulShellBranch(
            initialLocation: Routes.settingsScreen.path,
            navigatorKey: RoutesKeys.settingsNavigatorKey,
            routes: [
              GoRoute(
                name: Routes.settingsScreen.name,
                path: Routes.settingsScreen.path,
                parentNavigatorKey: RoutesKeys.settingsNavigatorKey,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
