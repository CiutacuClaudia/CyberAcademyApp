import 'package:disertatie/screens/phishing/models/phishing_reason_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/config/api_result.dart';
import '../../../common/widgets/toast.dart';
import '../models/phishing_request.dart';
import '../repository/phishing_repository.dart';
import 'phishing_state.dart';

class PhishingCubit extends Cubit<PhishingState> {
  final PhishingRepository _repository;

  PhishingCubit({PhishingRepository? repository})
      : _repository = repository ?? PhishingRepository(),
        super(const PhishingState(status: PhishingStateEnum.initial)) {
    loadPhishing();
  }

  Future<void> loadPhishing() async {
    emit(state.copyWith(status: PhishingStateEnum.loading));

    final reqResult = await _repository.getPhishingRequests();
    if (reqResult is ApiFailure) {
      final failure = reqResult as ApiFailure;
      emit(state.copyWith(
        status: PhishingStateEnum.failure,
        errorMessage: failure.message,
      ));
      return;
    }

    final reasonResult = await _repository.getPhishingReasons();
    if (reasonResult is ApiFailure) {
      final failure = reasonResult as ApiFailure;
      emit(state.copyWith(
        status: PhishingStateEnum.failure,
        errorMessage: failure.message,
      ));
      return;
    }

    final requests = (reqResult as ApiSuccess<List<PhishingRequest>>).data;
    final reasons  = (reasonResult as ApiSuccess<List<PhishingReasonRequest>>).data;

    if (requests.isEmpty) {
      emit(state.copyWith(
        status: PhishingStateEnum.failure,
        errorMessage: 'No phishing emails found',
      ));
    } else {
      emit(state.copyWith(
        status: PhishingStateEnum.success,
        requests: requests,
        reasons: reasons,
        currentIndex: 0,
        selectedPartIndices: [],
      ));
    }
  }


  void addPart(int index) {
    if (!state.selectedPartIndices.contains(index)) {
      final updated = List<int>.from(state.selectedPartIndices)..add(index);
      emit(state.copyWith(selectedPartIndices: updated));
    }
  }

  void submit() {
    final req = state.currentRequest;
    if (req == null) return;

    final correct =
    { for (int i = 0; i < req.parts.length; i++) if (req.parts[i].phishing) i };
    final selected = state.selectedPartIndices.toSet();

    if (selected.containsAll(correct) && correct.containsAll(selected)) {
      ToastService.showSuccessToast(message: '🎉Congrats');
      _goToNext();
    } else {
      ToastService.showErrorToast(
        message: 'Some phishing parts are missing or incorrect',
      );
    }
  }

  void skip() {
    _goToNext();
  }

  void _goToNext() {
    final next = state.currentIndex + 1;
    if (next < state.requests.length) {
      emit(state.copyWith(currentIndex: next, selectedPartIndices: []));
    } else {
      emit(state.copyWith(currentIndex: 0, selectedPartIndices: []));
    }
  }
}
