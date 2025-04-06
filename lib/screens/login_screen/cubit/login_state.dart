import 'package:equatable/equatable.dart';

enum LoginStateEnum { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStateEnum status;
  final String? errorMessage;

  const LoginState({required this.status, this.errorMessage});

  LoginState copyWith({LoginStateEnum? status, String? errorMessage}) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}