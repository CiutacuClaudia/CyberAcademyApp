import 'package:equatable/equatable.dart';

enum RegisterStateEnum { initial, loading, success, failure }

class RegisterState extends Equatable {
  final RegisterStateEnum state;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? errorMessage;

  const RegisterState({
    required this.state,
    this.nameError,
    this.emailError,
    this.passwordError,
    this.errorMessage,
  });

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
