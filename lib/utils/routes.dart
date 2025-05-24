import 'package:flutter/material.dart';

class RoutesKeys {
  static final GlobalKey<NavigatorState> homeNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> learningNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> settingsNavigatorKey =
      GlobalKey<NavigatorState>();
}

class AppRoute {
  final String name;
  final String path;

  const AppRoute({required this.name, required this.path});
}

class Routes {
  static const AppRoute splashScreen = AppRoute(name: 'splash', path: '/');
  static const AppRoute registerScreen = AppRoute(
    name: 'register',
    path: '/register',
  );
  static const AppRoute loginScreen = AppRoute(name: 'login', path: '/login');
  static const AppRoute resetPasswordScreen = AppRoute(
    name: 'resetPassword',
    path: '/resetPassword',
  );
  static const AppRoute resetPasswordConfirmationScreen = AppRoute(
    name: 'resetPasswordConfirmation',
    path: '/resetPasswordConfirmationScreen',
  );

  static const AppRoute homeScreen = AppRoute(name: 'home', path: '/home');
  static const AppRoute learningScreen = AppRoute(
    name: 'learning',
    path: '/learningScreen',
  );
  static const AppRoute cryptoScreen = AppRoute(
    name: 'crypto',
    path: '/cryptoScreen',
  );
  static const AppRoute phishingScreen = AppRoute(
    name: 'phishing',
    path: '/phishingScreen',
  );
  static const AppRoute xssScreen = AppRoute(name: 'xss', path: '/xssScreen');
  static const AppRoute settingsScreen = AppRoute(
    name: 'settings',
    path: '/settings',
  );
  static const AppRoute learningCiphersScreen = AppRoute(
    name: 'learningCiphers',
    path: '/learningCiphers',
  );
  static const AppRoute learningNetworkAttacksScreen = AppRoute(
    name: 'learningNetworkAttacks',
    path: '/learningNetworkAttacks',
  );
  static const AppRoute learningPhishingScreen = AppRoute(
    name: 'learningPhishing',
    path: '/learningPhishing',
  );
  static const AppRoute learningVirusesScreen = AppRoute(
    name: 'learningViruses',
    path: '/learningViruses',
  );
}
