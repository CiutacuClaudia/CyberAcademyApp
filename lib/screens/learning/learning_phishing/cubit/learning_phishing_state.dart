import 'package:equatable/equatable.dart';
import '../models/learning_phishing_request.dart';

enum LearningPhishingStatus { initial, loading, success, failure }

class LearningPhishingState extends Equatable {
  final LearningPhishingStatus status;
  final List<PhishingCard> cards;
  final String? errorMessage;
  final int currentIndex;

  const LearningPhishingState({
    required this.status,
    this.cards = const [],
    this.errorMessage,
    this.currentIndex = 0,
  });

  const LearningPhishingState.initial()
    : status = LearningPhishingStatus.initial,
      cards = const [],
      errorMessage = null,
      currentIndex = 0;

  LearningPhishingState copyWith({
    LearningPhishingStatus? status,
    List<PhishingCard>? cards,
    String? errorMessage,
    int? currentIndex,
  }) {
    return LearningPhishingState(
      status: status ?? this.status,
      cards: cards ?? this.cards,
      errorMessage: errorMessage ?? this.errorMessage,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [status, cards, errorMessage, currentIndex];
}
