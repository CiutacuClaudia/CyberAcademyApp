import 'package:flutter/material.dart';
import '../../../utils/dimensions.dart';

class InputTextWidget extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final TextInputType? keyboardType;

  const InputTextWidget({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      style: TextStyle(color: colorScheme.onPrimaryFixed),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: colorScheme.outline),
        floatingLabelStyle: TextStyle(color: colorScheme.onPrimaryFixed),
        prefixIcon: Icon(prefixIcon),
        prefixIconColor: WidgetStateColor.resolveWith((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.focused)) {
            return colorScheme.onPrimaryFixed;
          }
          return colorScheme.outline;
        }),
        suffixIcon: suffixIcon,
        suffixIconColor: WidgetStateColor.resolveWith((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.focused)) {
            return colorScheme.onPrimaryFixed;
          }
          return colorScheme.outline;
        }),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.size_2),
          borderSide: BorderSide(
            color: colorScheme.outline,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.size_2),
          borderSide: BorderSide(
            color: colorScheme.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.size_2),
          borderSide: BorderSide(
            color: colorScheme.onPrimaryFixed,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.size_2),
          borderSide: BorderSide(
            color: colorScheme.error,
          ),
        ),
        errorStyle: TextStyle(color: colorScheme.error),
      ),
    );
  }
}
