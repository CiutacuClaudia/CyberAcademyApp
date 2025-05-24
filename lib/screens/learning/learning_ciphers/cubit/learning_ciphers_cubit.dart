import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../network/config/api_result.dart';
import '../models/learning_ciphers_request.dart';
import '../repository/learning_ciphers_repository.dart';
import 'learning_ciphers_state.dart';

class LearningCiphersCubit extends Cubit<LearningCiphersState> {
  final LearningCiphersRepository _repository;

  LearningCiphersCubit({LearningCiphersRepository? repository})
    : _repository = repository ?? LearningCiphersRepository(),
      super(const LearningCiphersState.initial()) {
    fetchCiphers();
  }

  Future<void> fetchCiphers() async {
    emit(state.copyWith(status: LearningCiphersStatus.loading));

    final result = await _repository.fetchCiphers();
    if (result is ApiSuccess<List<LearningCipher>>) {
      emit(
        state.copyWith(
          status: LearningCiphersStatus.success,
          data: result.data,
        ),
      );
    } else {
      final failure = result as ApiFailure;
      emit(
        state.copyWith(
          status: LearningCiphersStatus.failure,
          errorMessage: failure.message,
        ),
      );
    }
  }
}
