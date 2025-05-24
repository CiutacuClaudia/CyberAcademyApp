import 'package:equatable/equatable.dart';
import '../models/learning_ciphers_request.dart';

enum LearningCiphersStatus { initial, loading, success, failure }

class LearningCiphersState extends Equatable {
  final LearningCiphersStatus status;
  final List<LearningCipher> data;
  final String? errorMessage;

  const LearningCiphersState({
    required this.status,
    this.data = const [],
    this.errorMessage,
  });

  const LearningCiphersState.initial()
    : status = LearningCiphersStatus.initial,
      data = const [],
      errorMessage = null;

  LearningCiphersState copyWith({
    LearningCiphersStatus? status,
    List<LearningCipher>? data,
    String? errorMessage,
  }) {
    return LearningCiphersState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
