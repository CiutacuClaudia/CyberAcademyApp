import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/models/user/user.dart';
import '../../../network/config/api_result.dart';
import '../repository/settings_repository.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _repo;

  SettingsCubit({SettingsRepository? repository})
    : _repo = repository ?? SettingsRepository(),
      super(const SettingsState(status: SettingsStatus.initial));

  Future<void> loadUser() async {
    emit(state.copyWith(status: SettingsStatus.loading));
    final res = await _repo.fetchCurrentUser();
    if (res is ApiFailure) {
      final failure = res as ApiFailure;
      emit(
        state.copyWith(
          status: SettingsStatus.failure,
          errorMessage: failure.message,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: SettingsStatus.success,
          user: (res as ApiSuccess<User>).data,
        ),
      );
    }
  }

  Future<void> logout() async {
    await _repo.clearTokens();
  }
}
