import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import '../../../common/models/user/user.dart';
import '../../../network/config/api_config.dart';
import '../../../network/config/api_result.dart';
import '../../../network/config/api_interceptor.dart';
import '../../../network/config/authorization_interceptor/authorization_interceptor.dart';

class SettingsRepository {
  final _client = InterceptedClient.build(
    interceptors: [LoggingInterceptor(), AuthInterceptor()],
  );
  final _storage = const FlutterSecureStorage();

  Future<ApiResult<User>> fetchCurrentUser() async {
    // 1) Read token
    final token = await _storage.read(key: 'accessToken');
    if (token == null) {
      return ApiFailure(statusCode: 401, message: 'Not authenticated');
    }

    Map<String, dynamic> claims = JwtDecoder.decode(token);
    final String userId =
        claims['uuid'] as String? ?? claims['sub'] as String? ?? '';
    if (userId.isEmpty) {
      return ApiFailure(statusCode: 400, message: 'Invalid token – no user ID');
    }

    final url = Uri.parse('${ApiConfig.baseUrl}/cyberacademy/users/$userId');
    final resp = await _client.get(url);

    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body);
      return ApiSuccess(User.fromJson(json));
    } else {
      String msg = 'Failed to load user';
      try {
        final j = jsonDecode(resp.body);
        msg = j['message'] ?? msg;
      } catch (_) {}
      return ApiFailure(statusCode: resp.statusCode, message: msg);
    }
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
  }
}
