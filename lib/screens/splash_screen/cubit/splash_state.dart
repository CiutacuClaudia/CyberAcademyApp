import 'package:equatable/equatable.dart';

/// Enum to track the state of the splash screen.
enum SplashStateEnum { initial, loading, finished }

class SplashState extends Equatable {
  final SplashStateEnum state;

  const SplashState({required this.state});

  SplashState copyWith({SplashStateEnum? state}) {
    return SplashState(
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [state];
}
