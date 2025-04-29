import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
