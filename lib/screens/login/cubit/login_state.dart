import 'package:equatable/equatable.dart';

import '../../../common/models/user/user.dart';

enum LoginStateEnum { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStateEnum status;
  final String? errorMessage;
  final User? user;

  const LoginState({required this.status, this.errorMessage, this.user});

  LoginState copyWith({
    LoginStateEnum? status,
    String? errorMessage,
    User? user,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: this.errorMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
