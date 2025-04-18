import 'dart:convert';
import 'package:http_interceptor/http_interceptor.dart';

import '../../../network/config/api_result.dart';
import '../../../common/models/user/user.dart';
import '../../../network/config/api_config.dart';
import '../../../network/config/api_interceptor.dart';
import '../models/register_request.dart';

class RegisterRepository {
  final InterceptedClient _client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  Future<ApiResult<User>> registerUser(RegisterRequest request) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/cyberacademy/users/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(request.toJson());

    final response = await _client.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return ApiSuccess(User.fromJson(json));
    } else {
      return ApiFailure(
        statusCode: response.statusCode,
        message: _extractErrorMessage(response.body),
      );
    }
  }

  String _extractErrorMessage(String responseBody) {
    try {
      final Map<String, dynamic> decoded = jsonDecode(responseBody);
      return decoded['message'] ?? 'Something went wrong';
    } catch (_) {
      return 'Something went wrong';
    }
  }
}
