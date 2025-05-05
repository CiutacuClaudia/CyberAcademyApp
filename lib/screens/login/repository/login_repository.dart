import 'dart:convert';
import 'package:http_interceptor/http_interceptor.dart';

import '../../../common/models/user/user.dart';
import '../../../network/config/api_config.dart';
import '../../../network/config/api_interceptor.dart';
import '../../../network/config/api_result.dart';
import '../models/login_request.dart';

class LoginRepository {
  final InterceptedClient _client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  Future<ApiResult<User>> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/cyberacademy/users/login');
    final request = LoginRequest(email: email, password: password);

    final response = await _client.post(
      url,
      headers: ApiConfig.jsonHeaders,
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == ApiStatusCode.ok) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return ApiSuccess(User.fromJson(json));
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
