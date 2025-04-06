import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Validates a name field (first or last name).
/// Returns a localized error message if the validation fails, otherwise null.
String? validateName(
  String? value, {
  required AppLocalizations loc,
  required bool isFirstName,
}) {
  if (value == null || value.isEmpty) {
    return isFirstName ? loc.firstNameRequired : loc.lastNameRequired;
  }
  if (value.length < 3 || value.length > 50) {
    return isFirstName ? loc.firstNameLengthError : loc.lastNameLengthError;
  }
  return null;
}

/// Validates the password.
/// Checks that the password is at least 8 characters and includes an uppercase letter,
/// a lowercase letter, a digit, and a special character.
String? validateRegisterPassword(String? value, {required AppLocalizations loc}) {
  if (value == null || value.isEmpty) {
    return loc.passwordRequired;
  }
  if (value.length < 8) {
    return loc.passwordLengthError;
  }
  final regex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&+])[A-Za-z\d@$!%*?&+]+$',
  );

  if (!regex.hasMatch(value)) {
    return loc.passwordPatternError;
  }
  return null;
}

String? validateLoginPassword(String? value, {required AppLocalizations loc}) {
  if (value == null || value.isEmpty) {
    return loc.passwordRequired;
  }
  return null;
}

/// Validates the confirm password field.
/// Returns an error if the field is empty or does not match the original password.
String? validateConfirmPassword(
  String? confirmValue,
  String? passwordValue, {
  required AppLocalizations loc,
}) {
  if (confirmValue == null || confirmValue.isEmpty) {
    return loc.confirmPasswordRequired;
  }
  if (confirmValue != passwordValue) {
    return loc.passwordsDoNotMatch;
  }
  return null;
}

/// Validates an email address.
/// Returns a localized error message if the email is empty or invalid, otherwise null.
String? validateEmail(String? value, {required AppLocalizations loc}) {
  if (value == null || value.isEmpty) {
    return loc.emailRequired;
  }
  final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return loc.invalidEmail;
  }
  return null;
}

/// Validates the reset code.
/// Ensures the code is non-empty, contains only numbers, and is exactly 6 digits long.
String? validateResetCode(String? value, {required AppLocalizations loc}) {
  if (value == null || value.isEmpty) {
    return loc.fieldRequired;
  }
  if (!RegExp(r'^\d+$').hasMatch(value)) {
    return loc.verificationCodeError;
  }
  if (value.length != 6) {
    return loc.verificationCodeError;
  }
  return null;
}
