import 'dart:convert';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../../../network/config/api_config.dart';
import '../../../network/config/api_result.dart';
import '../../../network/config/api_interceptor.dart';
import '../../../network/config/authorization_interceptor/authorization_interceptor.dart';
import '../models/xss_request.dart';

class XssRepository {
  final InterceptedClient _client = InterceptedClient.build(
    interceptors: [LoggingInterceptor(), AuthInterceptor()],
  );

  Future<ApiResult<List<XssRequest>>> getChallenges() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/cyberacademy/xss/challenges');
    final res = await _client.get(url);

    if (res.statusCode == ApiStatusCode.ok) {
      final List<dynamic> list = jsonDecode(res.body);
      final items =
          list
              .map((j) => XssRequest.fromJson(j as Map<String, dynamic>))
              .toList();
      return ApiSuccess(items);
    } else {
      String msg = 'Error loading XSS challenges';
      try {
        final js = jsonDecode(res.body);
        msg = js['message'] ?? msg;
      } catch (_) {}
      return ApiFailure(statusCode: res.statusCode, message: msg);
    }
  }

  Future<ApiResult<XssRequest>> updateChallenge(XssRequest request) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}/cyberacademy/xss/challenges/${request.id}',
    );
    final res = await _client.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (res.statusCode == ApiStatusCode.ok ||
        res.statusCode == ApiStatusCode.created) {
      final js = jsonDecode(res.body);
      return ApiSuccess(XssRequest.fromJson(js));
    } else {
      String msg = 'Error updating challenge';
      try {
        final js = jsonDecode(res.body);
        msg = js['message'] ?? msg;
      } catch (_) {}
      return ApiFailure(statusCode: res.statusCode, message: msg);
    }
  }
}
