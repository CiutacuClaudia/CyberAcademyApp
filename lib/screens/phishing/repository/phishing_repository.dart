import 'dart:convert';

import 'package:disertatie/screens/phishing/models/phishing_reason_request.dart';

import '../../../network/config/api_config.dart';
import '../../../network/config/api_result.dart';
import '../../../network/config/api_interceptor.dart';
import '../../../network/config/authorization_interceptor/authorization_interceptor.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import '../models/phishing_request.dart';

class PhishingRepository {
  final InterceptedClient _client = InterceptedClient.build(
    interceptors: [LoggingInterceptor(), AuthInterceptor()],
  );

  Future<ApiResult<List<PhishingRequest>>> getPhishingRequests() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/cyberacademy/phishing/parts');
    final response = await _client.get(url);

    if (response.statusCode == ApiStatusCode.ok) {
      final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      final requests = jsonList
          .map((j) => PhishingRequest.fromJson(j as Map<String, dynamic>))
          .toList();
      return ApiSuccess(requests);
    } else {
      String message = 'Something went wrong';
      try {
        final json = jsonDecode(response.body);
        message = json['message'] ?? message;
      } catch (_) {}
      return ApiFailure(statusCode: response.statusCode, message: message);
    }
  }
  Future<ApiResult<List<PhishingReasonRequest>>> getPhishingReasons() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/cyberacademy/phishing/reasons');
    final response = await _client.get(url);

    if (response.statusCode == ApiStatusCode.ok) {
      final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      final requests = jsonList
          .map((j) => PhishingReasonRequest.fromJson(j as Map<String, dynamic>))
          .toList();
      return ApiSuccess(requests);
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
