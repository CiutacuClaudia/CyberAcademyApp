import 'package:equatable/equatable.dart';

enum SplashStateEnum {
  initial,
  loading,
  finished,
  navigateDashboard,
  navigateLogin,
}

class SplashState extends Equatable {
  final SplashStateEnum state;

  const SplashState({required this.state});

  SplashState copyWith({SplashStateEnum? state}) {
    return SplashState(state: state ?? this.state);
  }

  @override
  List<Object?> get props => [state];
}
