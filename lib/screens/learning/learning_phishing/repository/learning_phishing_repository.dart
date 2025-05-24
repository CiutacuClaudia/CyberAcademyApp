import 'dart:convert';
import 'package:http_interceptor/http_interceptor.dart';
import '../../../../network/config/api_config.dart';
import '../../../../network/config/api_interceptor.dart';
import '../../../../network/config/api_result.dart';
import '../../../../network/config/authorization_interceptor/authorization_interceptor.dart';
import '../models/learning_phishing_request.dart';

class LearningPhishingRepository {
  final InterceptedClient _client = InterceptedClient.build(
    interceptors: [LoggingInterceptor(), AuthInterceptor()],
  );

  Future<ApiResult<List<PhishingCard>>> fetchCards() async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}/cyberacademy/learning/phishing/cards',
    );
    final resp = await _client.get(url, headers: ApiConfig.jsonHeaders);

    if (resp.statusCode == ApiStatusCode.ok) {
      final List<dynamic> list = jsonDecode(resp.body);
      final cards =
          list
              .map((e) => PhishingCard.fromJson(e as Map<String, dynamic>))
              .toList();
      return ApiSuccess(cards);
    } else {
      String msg = 'Something went wrong';
      try {
        final j = jsonDecode(resp.body);
        msg = j['message'] ?? msg;
      } catch (_) {}
      return ApiFailure(statusCode: resp.statusCode, message: msg);
    }
  }
}
