import 'package:disertatie/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../utils/routes.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_state.dart';
import 'widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using theme colors from your generated theme.
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.state == RegisterStateEnum.success) {
            // Navigate to the main screen using GoRouter.
            context.goNamed(Routes.mainScreen);
          }
        },
        child: Scaffold(
          // Full-screen design without an AppBar.
          body: Stack(
            children: [
              // Background gradient using theme colors.
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colorScheme.primary, colorScheme.primaryContainer],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(Dimensions.size_6),
                  child: Column(
                    children: [
                      const SizedBox(height: Dimensions.size_5),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Dimensions.size_4,
                          ),
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
                              } else if (state.state ==
                                  RegisterStateEnum.success) {
                                // Navigate to the main screen using GoRouter.
                                context.goNamed(Routes.mainScreen);
                                return const SizedBox(); // Prevent the widget from rebuilding endlessly.
                              } else if (state.state ==
                                  RegisterStateEnum.failure) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      state.errorMessage ??
                                          'Registration failed.',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).colorScheme.error,
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
            ],
          ),
        ),
      ),
    );
  }
}
