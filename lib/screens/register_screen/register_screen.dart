import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
            debugPrint('Navigating to /main');
            context.go('/main');
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
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: BlocBuilder<RegisterCubit, RegisterState>(
                            builder: (context, state) {
                              if (state.state == RegisterStateEnum.loading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state.state ==
                                  RegisterStateEnum.success) {
                                // Navigate to the main screen using GoRouter.
                                debugPrint('Navigating to /main');
                                context.go('/main');
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
                                    const SizedBox(height: 16),
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
