import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/dimensions.dart';
import '../../../utils/routes.dart';
import '../../common/widgets/toast.dart';
import 'cubit/reset_password_cubit.dart';
import 'cubit/reset_password_state.dart';
import 'widgets/reset_password_confirmation_form.dart';

class ResetPasswordConfirmationScreen extends StatelessWidget {
  const ResetPasswordConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => ResetPasswordCubit(),
      child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state.status == ResetPasswordStatus.success) {
            ToastService.showSuccessToast(message: loc.passwordResetSuccessful);
            context.goNamed(Routes.loginScreen.name);
          } else if (state.status == ResetPasswordStatus.failure) {
            ToastService.showErrorToast(
              message: state.errorMessage ?? loc.somethingWentWrongError,
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Dimensions.size_6),
              child: Card(
                color: colorScheme.primaryFixed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.size_4),
                ),
                elevation: Dimensions.size_2,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.size_4),
                  child: const ResetPasswordConfirmationForm(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
