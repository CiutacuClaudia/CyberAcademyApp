import 'package:disertatie/screens/splash_screen/widgets/splash_form.dart';
import 'package:disertatie/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:disertatie/common/repository/auth_repository.dart';

import 'cubit/splash_cubit.dart';
import 'cubit/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => SplashCubit(
            secureStorage: const FlutterSecureStorage(),
            authRepository: AuthRepository(),
          ),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.state == SplashStateEnum.navigateDashboard) {
            context.goNamed(Routes.homeScreen.name);
          } else if (state.state == SplashStateEnum.navigateLogin) {
            context.goNamed(Routes.loginScreen.name);
          } else if (state.state == SplashStateEnum.finished) {
            context.goNamed(Routes.registerScreen.name);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: const Center(child: SplashForm()),
        ),
      ),
    );
  }
}
