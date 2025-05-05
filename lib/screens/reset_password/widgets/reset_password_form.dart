import 'package:disertatie/common/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/input_text_widget.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/routes.dart';
import '../../../utils/validators.dart';
import '../cubit/reset_password_cubit.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<ResetPasswordCubit>().requestReset(_emailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(Dimensions.size_2),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              loc.resetPassword,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryFixed,
              ),
            ),
            const SizedBox(height: Dimensions.size_5),
            InputTextWidget(
              label: loc.email,
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => validateEmail(value, loc: loc),
              onChanged: (value) => _emailController.text = value,
            ),
            const SizedBox(height: Dimensions.size_6),
            CustomButtonWidget(
              label: loc.resetPassword,
              onPressed: _submitForm,
            ),
            const SizedBox(height: Dimensions.size_4),
            TextButton(
              onPressed: () => context.goNamed(Routes.loginScreen.name),
              style: TextButton.styleFrom(foregroundColor: colorScheme.scrim),
              child: Text(loc.goToLogin),
            ),
          ],
        ),
      ),
    );
  }
}
