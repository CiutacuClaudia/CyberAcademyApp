import 'package:flutter/material.dart';
import 'input_text_widget.dart';

class InputPasswordWidget extends StatefulWidget {
  final String label;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;

  const InputPasswordWidget({
    super.key,
    this.label = 'Password',
    this.validator,
    this.onChanged,
    this.onSaved,
  });

  @override
  State<InputPasswordWidget> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<InputPasswordWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return InputTextWidget(
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
