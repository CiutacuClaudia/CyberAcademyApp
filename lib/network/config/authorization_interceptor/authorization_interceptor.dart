import 'package:disertatie/router/app_router.dart';
import 'package:disertatie/utils/routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../common/repository/auth_repository.dart';
import '../../../utils/storage_keys.dart';

class AuthInterceptor implements InterceptorContract {
  static final AuthInterceptor _instance = AuthInterceptor._internal(
    const FlutterSecureStorage(),
    AuthRepository(),
  );

  factory AuthInterceptor() {
    return _instance;
  }

  AuthInterceptor._internal(this.secureStorage, this.authRepository);

  final FlutterSecureStorage secureStorage;
  final AuthRepository authRepository;

  @override
  Future<bool> shouldInterceptRequest() async => true;

  @override
  Future<bool> shouldInterceptResponse() async => true;

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    String? accessToken = await secureStorage.read(
      key: StorageKeys.accessToken,
    );

    if (accessToken != null) {
      if (JwtDecoder.isExpired(accessToken)) {
        final refreshToken = await secureStorage.read(
          key: StorageKeys.refreshToken,
        );
        if (refreshToken != null) {
          final newAccessToken = await authRepository.refreshAccessToken(
            refreshToken,
          );
          if (newAccessToken != null) {
            await secureStorage.write(
              key: StorageKeys.accessToken,
              value: newAccessToken,
            );
            accessToken = newAccessToken;
          } else {
            await secureStorage.delete(key: StorageKeys.accessToken);
            await secureStorage.delete(key: StorageKeys.refreshToken);
            AppRouter.goRouter.goNamed(Routes.loginScreen.name);
            accessToken = null;
          }
        } else {
          await secureStorage.delete(key: StorageKeys.accessToken);
          accessToken = null;
        }
      }
      if (accessToken != null) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    if (response.statusCode == 401) {
      await secureStorage.delete(key: StorageKeys.accessToken);
      await secureStorage.delete(key: StorageKeys.refreshToken);
      AppRouter.goRouter.goNamed(Routes.loginScreen.name);
    }
    return response;
  }
}
