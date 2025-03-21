import 'package:equatable/equatable.dart';

// Enum to track the state of the registration process
enum RegisterStateEnum { initial, loading, success, failure }

class RegisterState extends Equatable {
  final RegisterStateEnum state; // Tracks the registration state
  final String? nameError; // Error message for the name field
  final String? emailError; // Error message for the email field
  final String? passwordError; // Error message for the password field
  final String? errorMessage; // General error message (for unexpected errors)

  const RegisterState({
    required this.state,
    this.nameError,
    this.emailError,
    this.passwordError,
    this.errorMessage,
  });

  // Method to copy and modify the current state
  RegisterState copyWith({
    RegisterStateEnum? state,
    String? nameError,
    String? emailError,
    String? passwordError,
    String? errorMessage,
  }) {
    return RegisterState(
      state: state ?? this.state,
      nameError: nameError ?? this.nameError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    state,
    nameError,
    emailError,
    passwordError,
    errorMessage,
  ];
}
