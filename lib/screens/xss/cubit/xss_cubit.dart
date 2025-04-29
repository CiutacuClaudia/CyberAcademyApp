import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/toast.dart';
import '../../../network/config/api_result.dart';
import '../models/xss_request.dart';
import '../repository/xss_repository.dart';
import 'xss_state.dart';

class XssCubit extends Cubit<XssState> {
  final XssRepository _repository;

  XssCubit({XssRepository? repository})
    : _repository = repository ?? XssRepository(),
      super(const XssState(status: XssStateEnum.initial)) {
    loadChallenges();
  }

  Future<void> loadChallenges() async {
    emit(state.copyWith(status: XssStateEnum.loading));

    final res = await _repository.getChallenges();
    if (res is ApiFailure) {
      final failure = res as ApiFailure;
      emit(
        state.copyWith(
          status: XssStateEnum.failure,
          errorMessage: failure.message,
        ),
      );
      return;
    }

    final list = (res as ApiSuccess<List<XssRequest>>).data;
    if (list.isEmpty) {
      emit(
        state.copyWith(
          status: XssStateEnum.failure,
          errorMessage: 'No XSS challenges found',
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: XssStateEnum.success,
          challenges: list,
          currentIndex: 0,
        ),
      );
    }
  }

  Future<void> submitComment(String comment) async {
    final req = state.currentChallenge;
    if (req == null) return;

    final updated = List<String>.from(req.comments)..add(comment);

    final putRes = await _repository.updateChallenge(
      XssRequest(id: req.id, blogContent: req.blogContent, comments: updated, flag: req.flag),
    );

    if (putRes is ApiFailure) {
      final failure = putRes as ApiFailure;
      ToastService.showErrorToast(message: failure.message);
      return;
    }

    final updatedChallenge = (putRes as ApiSuccess<XssRequest>).data;
    final all = List<XssRequest>.from(state.challenges)
      ..[state.currentIndex] = updatedChallenge;

    emit(state.copyWith(challenges: all));
  }

  void next() {
    final nextIdx = state.currentIndex + 1;
    if (nextIdx < state.challenges.length) {
      emit(state.copyWith(currentIndex: nextIdx));
    } else {
      emit(state.copyWith(currentIndex: 0));
    }
  }
}
