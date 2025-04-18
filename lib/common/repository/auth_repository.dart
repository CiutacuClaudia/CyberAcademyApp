import 'dart:convert';
import 'package:http_interceptor/http_interceptor.dart';
import '../../network/config/api_config.dart';
import '../../network/config/api_interceptor.dart';
import '../../network/config/api_result.dart';
import '../models/refresh_token/refresh_token_request.dart';

class AuthRepository {
  final InterceptedClient _client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  Future<String?> refreshAccessToken(String refreshToken) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/cyberacademy/users/refresh');

    final refreshRequest = RefreshTokenRequest(refreshToken: refreshToken);
    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(refreshRequest.toJson()),
    );

    if (response.statusCode == ApiStatusCode.ok) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return json['accessToken'] as String?;
    } else {
      // Optionally handle error messages here.
      return null;
    }
  }
}