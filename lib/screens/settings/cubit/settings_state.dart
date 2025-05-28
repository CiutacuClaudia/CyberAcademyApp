import 'package:equatable/equatable.dart';
import '../../../common/models/user/user.dart';

enum SettingsStatus { initial, loading, success, failure }

class SettingsState extends Equatable {
  final SettingsStatus status;
  final User? user;
  final String? errorMessage;

  const SettingsState({required this.status, this.user, this.errorMessage});

  SettingsState copyWith({
    SettingsStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return SettingsState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}
