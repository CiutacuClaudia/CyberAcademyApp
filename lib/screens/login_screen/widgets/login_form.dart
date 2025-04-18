import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/dimensions.dart';
import '../../../utils/routes.dart';
import '../../../utils/validators.dart';
import '../cubit/login_cubit.dart';
import 'package:disertatie/common/widgets/input_text_widget.dart';
import 'package:disertatie/common/widgets/input_password_widget.dart';
import 'package:disertatie/common/widgets/custom_button_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final loc = AppLocalizations.of(context)!;
      context.read<LoginCubit>().login(
        email: _emailController.text,
        password: _passwordController.text,
        loc: loc,
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
              loc.loginTitle,
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
              onChanged: (value) => {_emailController.text = value},
            ),
            const SizedBox(height: Dimensions.size_4),
            InputPasswordWidget(
              label: loc.password,
              validator: (value) => validateLoginPassword(value, loc: loc),
              onChanged: (value) => _passwordController.text = value,
              onSaved: (value) => _passwordController.text = value!,
            ),
            const SizedBox(height: Dimensions.size_6),
            CustomButtonWidget(label: loc.loginTitle, onPressed: _submitForm),
            const SizedBox(height: Dimensions.size_4),
            Row(
              children: [
                const Expanded(
                  child: Divider(thickness: 1, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    loc.or,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const Expanded(
                  child: Divider(thickness: 1, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.size_4),
            CustomButtonWidget(
              label: loc.registerTitle,
              onPressed: () {
                context.goNamed(Routes.registerScreen);
              },
            ),
            const SizedBox(height: Dimensions.size_4),
            TextButton(
              onPressed: () => context.goNamed(Routes.resetPasswordScreen),
              style: TextButton.styleFrom(foregroundColor: colorScheme.scrim),
              child: Text(loc.resetPassword),
            ),
            const SizedBox(height: Dimensions.size_4),
          ],
        ),
      ),
    );
  }
}
