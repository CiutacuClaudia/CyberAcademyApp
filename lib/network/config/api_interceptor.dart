import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:logging/logging.dart';

final _log = Logger('API');

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<bool> shouldInterceptRequest() async => true;

  @override
  Future<bool> shouldInterceptResponse() async => true;

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    _log.info("[REQUEST] ${request.method} ${request.url}");
    _log.fine("Headers: ${request.headers}");
    if (request is http.Request) {
      _log.fine("Body: ${request.body}");
    }

    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    _log.info(
      "[RESPONSE] ${response.statusCode} from ${response.request?.url}",
    );
    if (response is http.Response) {
      _log.fine("Body: ${response.body}");
    }
    return response;
  }
}