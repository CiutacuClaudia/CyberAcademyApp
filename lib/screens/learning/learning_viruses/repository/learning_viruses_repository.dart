import 'dart:convert';
import 'package:disertatie/network/config/authorization_interceptor/authorization_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../../../../network/config/api_config.dart';
import '../../../../network/config/api_interceptor.dart';
import '../../../../network/config/api_result.dart';
import '../models/learning_viruses_request.dart';

class LearningVirusesRepository {
  final InterceptedClient _client = InterceptedClient.build(
    interceptors: [LoggingInterceptor(), AuthInterceptor()],
  );

  Future<ApiResult<List<LearningViruses>>> fetchCiphers() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/cyberacademy/learning/viruses');
    final response = await _client.get(url, headers: ApiConfig.jsonHeaders);

    if (response.statusCode == ApiStatusCode.ok) {
      final List<dynamic> list = jsonDecode(response.body);
      final ciphers =
          list
              .map((e) => LearningViruses.fromJson(e as Map<String, dynamic>))
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
