import 'dart:convert';
import 'package:disertatie/screens/crypto/models/playfair_cipher_request.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../../../network/config/api_config.dart';
import '../../../network/config/api_interceptor.dart';
import '../../../network/config/api_result.dart';
import '../../../network/config/authorization_interceptor/authorization_interceptor.dart';
import '../models/caesar_cipher_request.dart';

class CryptoRepository {
  final InterceptedClient _client = InterceptedClient.build(
    interceptors: [LoggingInterceptor(), AuthInterceptor()],
  );

  Future<ApiResult<List<CaesarCipher>>> getCaesarCiphers() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/cyberacademy/ciphers/caesar');
    final response = await _client.get(url);

    if (response.statusCode == ApiStatusCode.ok) {
      final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      final ciphers =
          jsonList
              .map(
                (json) => CaesarCipher.fromJson(json as Map<String, dynamic>),
              )
              .toList();
      return ApiSuccess(ciphers);
    } else {
      String message = 'Something went wrong';
      try {
        final json = jsonDecode(response.body);
        message = json['message'] ?? message;
      } catch (_) {}
      return ApiFailure(statusCode: response.statusCode, message: message);
    }
  }

  Future<ApiResult<List<PlayfairCipher>>> getPlayfairCiphers() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/cyberacademy/ciphers/playfair');
    final response = await _client.get(url);

    if (response.statusCode == ApiStatusCode.ok) {
      final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      final ciphers =
          jsonList
              .map(
                (json) => PlayfairCipher.fromJson(json as Map<String, dynamic>),
              )
              .toList();
      return ApiSuccess(ciphers);
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
