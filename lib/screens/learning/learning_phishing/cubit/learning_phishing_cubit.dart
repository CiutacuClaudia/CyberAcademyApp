import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../network/config/api_result.dart';
import '../models/learning_phishing_request.dart';
import '../repository/learning_phishing_repository.dart';
import 'learning_phishing_state.dart';

class LearningPhishingCubit extends Cubit<LearningPhishingState> {
  final LearningPhishingRepository _repo;

  LearningPhishingCubit({LearningPhishingRepository? repository})
    : _repo = repository ?? LearningPhishingRepository(),
      super(const LearningPhishingState.initial()) {
    fetchCards();
  }

  Future<void> fetchCards() async {
    emit(state.copyWith(status: LearningPhishingStatus.loading));
    final result = await _repo.fetchCards();
    if (result is ApiSuccess<List<PhishingCard>>) {
      emit(
        state.copyWith(
          status: LearningPhishingStatus.success,
          cards: result.data,
          currentIndex: 0,
        ),
      );
    } else {
      final f = result as ApiFailure;
      emit(
        state.copyWith(
          status: LearningPhishingStatus.failure,
          errorMessage: f.message,
        ),
      );
    }
  }

  void nextCard() {
    final next = state.currentIndex + 1;
    if (next <= state.cards.length) {
      emit(state.copyWith(currentIndex: next));
    }
  }
}
