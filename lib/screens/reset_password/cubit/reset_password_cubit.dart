import 'package:disertatie/screens/reset_password/cubit/reset_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/config/api_result.dart';
import '../repository/reset_password_repository.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepository _repository;

  ResetPasswordCubit({ResetPasswordRepository? repository})
      : _repository = repository ?? ResetPasswordRepository(),
        super(const ResetPasswordState());

  Future<void> confirmReset({
    required String code,
    required String newPassword,
  }) async {
    emit(state.copyWith(status: ResetPasswordStatus.loading));
    final result = await _repository.confirmReset(
      code: code,
      newPassword: newPassword,
    );
    if (result is ApiSuccess) {
      emit(state.copyWith(status: ResetPasswordStatus.success));
    } else {
      emit(
        state.copyWith(
          status: ResetPasswordStatus.failure,
          errorMessage: (result as ApiFailure).message,
        ),
      );
    }
  }

  Future<void> requestReset(String email) async {
    emit(state.copyWith(status: ResetPasswordStatus.loading));
    final result = await _repository.requestReset(email: email);
    if (result is ApiSuccess) {
      emit(state.copyWith(status: ResetPasswordStatus.success));
    } else {
      emit(
        state.copyWith(
          status: ResetPasswordStatus.failure,
          errorMessage: (result as ApiFailure).message,
        ),
      );
    }
  }
}