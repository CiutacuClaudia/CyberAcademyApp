import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/widgets/authentication/custom_button_widget.dart';
import '../../../common/widgets/authentication/input_text_widget.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/validators.dart';
import '../cubit/reset_password_cubit.dart';

class ResetPasswordConfirmationForm extends StatefulWidget {
  const ResetPasswordConfirmationForm({super.key});

  @override
  _ResetPasswordConfirmationFormState createState() =>
      _ResetPasswordConfirmationFormState();
}

class _ResetPasswordConfirmationFormState
    extends State<ResetPasswordConfirmationForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _codeController;
  late final TextEditingController _newPasswordController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
    _newPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<ResetPasswordCubit>().confirmReset(
        code: _codeController.text,
        newPassword: _newPasswordController.text,
      );
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
              loc.confirmReset,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryFixed,
              ),
            ),
            const SizedBox(height: Dimensions.size_5),
            InputTextWidget(
              label: loc.resetCode,
              prefixIcon: Icons.code,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return loc.emailSent;
                }
                return null;
              },
              onChanged: (value) => _codeController.text = value,
            ),
            const SizedBox(height: Dimensions.size_4),
            InputTextWidget(
              label: loc.newPassword,
              prefixIcon: Icons.lock,
              obscureText: true,
              validator: (value) => validateRegisterPassword(value, loc: loc),
              onChanged: (value) => _newPasswordController.text = value,
              onSaved: (value) => _newPasswordController.text = value!,
            ),
            const SizedBox(height: Dimensions.size_6),
            CustomButtonWidget(label: loc.confirmReset, onPressed: _submitForm),
          ],
        ),
      ),
    );
  }
}
