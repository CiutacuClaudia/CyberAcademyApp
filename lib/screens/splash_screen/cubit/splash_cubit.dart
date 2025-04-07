import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../common/repository/auth_repository.dart';
import '../../../utils/storage_keys.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final FlutterSecureStorage _secureStorage;
  final AuthRepository _authRepository;

  SplashCubit({
    required FlutterSecureStorage secureStorage,
    required AuthRepository authRepository,
  }) : _secureStorage = secureStorage,
       _authRepository = authRepository,
       super(const SplashState(state: SplashStateEnum.initial)) {
    _checkAuthentication();
    _startAnimation();
  }

  Future<void> _checkAuthentication() async {
    final startTime = DateTime.now();

    final accessToken = await _secureStorage.read(key: StorageKeys.accessToken);
    final refreshToken = await _secureStorage.read(
      key: StorageKeys.refreshToken,
    );

    SplashStateEnum state;
    if (accessToken != null && refreshToken != null) {
      if (!JwtDecoder.isExpired(accessToken)) {
        state = SplashStateEnum.navigateDashboard;
      } else {
        final newAccessToken = await _authRepository.refreshAccessToken(
          refreshToken,
        );
        if (newAccessToken != null) {
          await _secureStorage.write(
            key: StorageKeys.accessToken,
            value: newAccessToken,
          );
          state = SplashStateEnum.navigateDashboard;
        } else {
          state = SplashStateEnum.navigateLogin;
        }
      }
    } else {
      state = SplashStateEnum.navigateLogin;
    }

    final elapsed = DateTime.now().difference(startTime);
    const minSplashDuration = Duration(seconds: 2);
    if (elapsed < minSplashDuration) {
      await Future.delayed(minSplashDuration - elapsed);
    }

    emit(SplashState(state: state));
  }
  void _startAnimation() async {
    emit(state.copyWith(state: SplashStateEnum.loading));
    await Future.delayed(const Duration(seconds: 3));
    if (!isClosed) {
      emit(state.copyWith(state: SplashStateEnum.finished));
    }
  }
}
