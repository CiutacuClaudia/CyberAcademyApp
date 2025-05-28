import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../common/models/user/user.dart';
import '../../../common/repository/auth_repository.dart';
import '../../../network/config/api_result.dart';
import '../../../utils/storage_keys.dart';
import '../repository/login_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _repository;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  LoginCubit({LoginRepository? repository, AuthRepository? authRepository})
    : _repository = repository ?? LoginRepository(),
      super(const LoginState(status: LoginStateEnum.initial)) {
    _secureStorage.deleteAll();
  }

  Future<void> login({
    required String email,
    required String password,
    required AppLocalizations loc,
  }) async {
    emit(state.copyWith(status: LoginStateEnum.loading));

    final result = await _repository.loginUser(
      email: email,
      password: password,
    );
    if (result is ApiSuccess<User>) {
      await _saveUserToSecureStorage(result.data);
      emit(state.copyWith(status: LoginStateEnum.success));
    } else {
      emit(
        state.copyWith(
          status: LoginStateEnum.failure,
          errorMessage: loc.loginFailed,
        ),
      );
    }
  }

  Future<void> _saveUserToSecureStorage(User user) async {
    await _secureStorage.write(
      key: StorageKeys.accessToken,
      value: user.accessToken,
    );
    await _secureStorage.write(
      key: StorageKeys.refreshToken,
      value: user.refreshToken,
    );
    await _secureStorage.write(key: StorageKeys.uuid, value: user.uuid);
    await _secureStorage.write(key: StorageKeys.email, value: user.email);
    await _secureStorage.write(
      key: StorageKeys.firstName,
      value: user.firstName,
    );
    await _secureStorage.write(key: StorageKeys.lastName, value: user.lastName);
    await _secureStorage.write(
      key: StorageKeys.isAdmin,
      value: user.isAdmin.toString(),
    );
  }
}
