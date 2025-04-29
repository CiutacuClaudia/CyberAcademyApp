import '../models/xss_request.dart';

enum XssStateEnum { initial, loading, success, failure }

class XssState {
  final XssStateEnum status;
  final List<XssRequest> challenges;
  final int currentIndex;
  final String? errorMessage;

  const XssState({
    required this.status,
    this.challenges = const [],
    this.currentIndex = 0,
    this.errorMessage,
  });

  XssState copyWith({
    XssStateEnum? status,
    List<XssRequest>? challenges,
    int? currentIndex,
    String? errorMessage,
  }) {
    return XssState(
      status: status ?? this.status,
      challenges: challenges ?? this.challenges,
      currentIndex: currentIndex ?? this.currentIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  XssRequest? get currentChallenge =>
      (currentIndex < challenges.length) ? challenges[currentIndex] : null;
}
