import 'dart:convert';
import 'package:http_interceptor/http/intercepted_client.dart';

import '../../../network/config/api_config.dart';
import '../../../network/config/api_interceptor.dart';
import '../../../network/config/api_result.dart';
import '../../../network/config/authorization_interceptor/authorization_interceptor.dart';
import '../model/create_phishing_request.dart';

class CreatePhishingRepository {
  final _client = InterceptedClient.build(
    interceptors: [LoggingInterceptor(), AuthInterceptor()],
  );

  Future<ApiResult<void>> createPhishing(CreatePhishingRequest request) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/cyberacademy/phishing/parts');
    final resp = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (resp.statusCode == 201) {
      return ApiSuccess(null);
    } else {
      String msg = 'Failed to save';
      try {
        final json = jsonDecode(resp.body);
        msg = json['message'] ?? msg;
      } catch (_) {}
      return ApiFailure(statusCode: resp.statusCode, message: msg);
    }
  }
}
