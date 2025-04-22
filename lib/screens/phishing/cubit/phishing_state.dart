import 'package:disertatie/screens/phishing/models/phishing_reason_request.dart';

import '../models/phishing_request.dart';

enum PhishingStateEnum { initial, loading, success, failure }

class PhishingState {
  final PhishingStateEnum status;
  final List<PhishingRequest> requests;
  final List<PhishingReasonRequest> reasons;
  final int currentIndex;
  final List<int> selectedPartIndices;
  final String? errorMessage;

  const PhishingState({
    required this.status,
    this.requests = const [],
    this.reasons = const [],
    this.currentIndex = 0,
    this.selectedPartIndices = const [],
    this.errorMessage,
  });

  PhishingState copyWith({
    PhishingStateEnum? status,
    List<PhishingRequest>? requests,
    List<PhishingReasonRequest>? reasons,
    int? currentIndex,
    List<int>? selectedPartIndices,
    String? errorMessage,
  }) {
    return PhishingState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      reasons: reasons ?? this.reasons,
      // ← copy
      currentIndex: currentIndex ?? this.currentIndex,
      selectedPartIndices: selectedPartIndices ?? this.selectedPartIndices,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  PhishingRequest? get currentRequest =>
      (currentIndex < requests.length) ? requests[currentIndex] : null;

  List<Object?> get props => [
    status,
    requests,
    currentIndex,
    selectedPartIndices,
    errorMessage,
  ];
}
