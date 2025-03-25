import 'package:disertatie/widgets/authentication/custom_button_widget.dart';
import 'package:disertatie/widgets/authentication/custom_text_widget.dart';
import 'package:disertatie/widgets/authentication/password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/register_cubit.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password, _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Create Account',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          CustomTextWidget(
            label: 'Email',
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email';
              }
              if (!value.contains('@')) {
                return 'Email must contain "@"';
              }
              if (value.length > 40) {
                return 'Email must not exceed 40 characters';
              }
              return null;
            },
            onChanged: (value) => _email = value,
          ),
          const SizedBox(height: 16),
          PasswordWidget(
            label: 'Password',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              final passwordRegex = RegExp(
                r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[+!@#\$&*~]).{10,}$',
              );
              if (!passwordRegex.hasMatch(value)) {
                return 'Password must be at least 10 characters.\n'
                    'Include uppercase, lowercase, number, and special character.';
              }
              return null;
            },
            onChanged: (value) => _password = value,
            onSaved: (value) => _password = value,
          ),
          const SizedBox(height: 16),
          PasswordWidget(
            label: 'Confirm Password',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (_password != null && value != _password) {
                return 'Passwords do not match';
              }
              return null;
            },
            onChanged: (value) => _confirmPassword = value,
            onSaved: (value) => _confirmPassword = value,
          ),
          const SizedBox(height: 24),
          CustomButtonWidget(
            label: 'Register',
            onPressed: _submitForm,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account?'),
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<RegisterCubit>().register(
        _email!,
        _password!,
        _confirmPassword!,
      );
    }
  }
}
