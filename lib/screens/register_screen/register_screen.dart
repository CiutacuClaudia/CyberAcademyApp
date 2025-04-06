import 'package:disertatie/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common/widgets/authentication/toast.dart';
import '../../utils/routes.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_state.dart';
import 'widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.state == RegisterStateEnum.success) {
            ToastService.showSuccessToast(message: loc.registrationSuccessful);
            context.goNamed(Routes.loginScreen);
          } else if (state.state == RegisterStateEnum.failure) {
            ToastService.showErrorToast(message: loc.somethingWentWrongError);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Dimensions.size_6),
              child: Column(
                children: [
                  const SizedBox(height: Dimensions.size_5),
                  Card(
                    color: colorScheme.primaryFixed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.size_4),
                    ),
                    elevation: Dimensions.size_2,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.size_4),
                      child: BlocBuilder<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                          if (state.state == RegisterStateEnum.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state.state == RegisterStateEnum.success) {
                            context.goNamed(Routes.mainScreen);
                            return const SizedBox(); // Prevent the widget from rebuilding endlessly.
                          } else if (state.state == RegisterStateEnum.failure) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  state.errorMessage ?? 'Registration failed.',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                                const SizedBox(height: Dimensions.size_4),
                                const RegisterForm(),
                              ],
                            );
                          }
                          return const RegisterForm();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
