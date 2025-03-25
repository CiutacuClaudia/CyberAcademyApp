import 'package:flutter/material.dart';
import 'custom_text_widget.dart';

class PasswordWidget extends StatefulWidget {
  final String label;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;

  const PasswordWidget({
    super.key,
    this.label = 'Password',
    this.validator,
    this.onChanged,
    this.onSaved,
  });

  @override
  State<PasswordWidget> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextWidget(
      label: widget.label,
      prefixIcon: Icons.lock,
      obscureText: _obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
    );
  }
}
