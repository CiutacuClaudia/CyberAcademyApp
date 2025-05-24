import 'package:equatable/equatable.dart';
import '../models/learning_viruses_request.dart';

enum LearningVirusesStatus { initial, loading, success, failure }

class LearningVirusesState extends Equatable {
  final LearningVirusesStatus status;
  final List<LearningViruses> data;
  final String? errorMessage;

  const LearningVirusesState({
    required this.status,
    this.data = const [],
    this.errorMessage,
  });

  const LearningVirusesState.initial()
    : status = LearningVirusesStatus.initial,
      data = const [],
      errorMessage = null;

  LearningVirusesState copyWith({
    LearningVirusesStatus? status,
    List<LearningViruses>? data,
    String? errorMessage,
  }) {
    return LearningVirusesState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
