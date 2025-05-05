import 'package:disertatie/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/custom_button_widget.dart';
import '../../../common/widgets/input_password_widget.dart';
import '../../../common/widgets/input_text_widget.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/validators.dart';
import '../cubit/register_cubit.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<RegisterCubit>().register(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        loc: AppLocalizations.of(context)!,
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
              loc.registerTitle,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryFixed,
              ),
            ),
            const SizedBox(height: Dimensions.size_5),
            InputTextWidget(
              label: loc.firstName,
              prefixIcon: Icons.person,
              validator:
                  (value) => validateName(value, loc: loc, isFirstName: true),
              onChanged: (value) => _firstNameController.text = value,
            ),
            const SizedBox(height: Dimensions.size_4),
            InputTextWidget(
              label: loc.lastName,
              prefixIcon: Icons.person_outline,
              validator:
                  (value) => validateName(value, loc: loc, isFirstName: false),
              onChanged: (value) => _lastNameController.text = value,
            ),
            const SizedBox(height: Dimensions.size_4),
            InputTextWidget(
              label: loc.email,
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => validateEmail(value, loc: loc),
              onChanged: (value) => _emailController.text = value,
            ),
            const SizedBox(height: Dimensions.size_4),
            InputPasswordWidget(
              label: loc.password,
              validator: (value) => validateRegisterPassword(value, loc: loc),
              onChanged: (value) => _passwordController.text = value,
              onSaved: (value) => _passwordController.text = value!,
            ),
            const SizedBox(height: Dimensions.size_4),
            InputPasswordWidget(
              label: loc.confirmPassword,
              validator:
                  (value) => validateConfirmPassword(
                    value,
                    _passwordController.text,
                    loc: loc,
                  ),
              onChanged: (value) => _confirmPasswordController.text = value,
              onSaved: (value) => _confirmPasswordController.text = value!,
            ),
            const SizedBox(height: Dimensions.size_6),
            CustomButtonWidget(
              label: loc.registerTitle,
              onPressed: _submitForm,
            ),
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
              label: loc.loginTitle,
              onPressed: () {
                context.goNamed(Routes.loginScreen.name);
              },
            ),
          ],
        ),
      ),
    );
  }
}
