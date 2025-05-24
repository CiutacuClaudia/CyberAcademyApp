import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../network/config/api_result.dart';
import '../models/learning_viruses_request.dart';
import '../repository/learning_viruses_repository.dart';
import 'learning_viruses_state.dart';

class LearningVirusesCubit extends Cubit<LearningVirusesState> {
  final LearningVirusesRepository _repository;

  LearningVirusesCubit({LearningVirusesRepository? repository})
    : _repository = repository ?? LearningVirusesRepository(),
      super(const LearningVirusesState.initial()) {
    fetchCiphers();
  }

  Future<void> fetchCiphers() async {
    emit(state.copyWith(status: LearningVirusesStatus.loading));

    final result = await _repository.fetchCiphers();
    if (result is ApiSuccess<List<LearningViruses>>) {
      emit(
        state.copyWith(
          status: LearningVirusesStatus.success,
          data: result.data,
        ),
      );
    } else {
      final failure = result as ApiFailure;
      emit(
        state.copyWith(
          status: LearningVirusesStatus.failure,
          errorMessage: failure.message,
        ),
      );
    }
  }
}
