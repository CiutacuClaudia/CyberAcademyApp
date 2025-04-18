import 'dart:convert';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../../../network/config/api_config.dart';
import '../../../network/config/api_interceptor.dart';
import '../../../network/config/api_result.dart';
import '../model/reset_password_request.dart';
import '../model/reset_password_confirm_request.dart';

class ResetPasswordRepository {
  final InterceptedClient _client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  Future<ApiResult<void>> confirmReset({
    required String code,
    required String newPassword,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/cyberacademy/users/reset-password');

    final request = ResetPasswordConfirmRequest(
      code: code,
      newPassword: newPassword,
    );

    final response = await _client.post(
      url,
      headers: ApiConfig.jsonHeaders,
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == ApiStatusCode.ok) {
      return ApiSuccess(null);
    } else {
      String message = 'Something went wrong';
      try {
        final json = jsonDecode(response.body);
        message = json['message'] ?? message;
      } catch (_) {}
      return ApiFailure(statusCode: response.statusCode, message: message);
    }
  }

  Future<ApiResult<void>> requestReset({required String email}) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/cyberacademy/users/reset-password-request');

    final request = ResetPasswordRequest(email: email);
    final response = await _client.post(
      url,
      headers: ApiConfig.jsonHeaders,
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == ApiStatusCode.ok) {
      return ApiSuccess(null);
    } else {
      String message = 'Something went wrong';
      try {
        final json = jsonDecode(response.body);
        message = json['message'] ?? message;
      } catch (_) {}
      return ApiFailure(statusCode: response.statusCode, message: message);
    }
  }
}