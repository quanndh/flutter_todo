import 'package:dio/dio.dart';
import 'package:test1/data/services/networking/exception/api_exception.dart';
import 'package:test1/data/services/networking/response/error_response.dart';

/// An interceptor for dio response
/// check the code of response body -> if code != 2xx, parse the body to ErrorResponse
/// and throw exception
/// Notes: work for all type of response http code, the exception receive in try catch will
/// be DioError (error = ApiException, type = other)
class ResponseCheckerInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is Map<String, dynamic>) {
      _checkResponse(response.data as Map<String, dynamic>);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.data is Map<String, dynamic>) {
      _checkResponse(err.response!.data as Map<String, dynamic>);
    }
    super.onError(err, handler);
  }

  void _checkResponse(Map<String, dynamic> responseData) {
    if (responseData['code'] is int) {
      final code = responseData['code'] as int;
      if (code < 200 || code >= 300) {
        final errorResponse = ErrorResponse.fromJson(responseData);
        throw ApiException(errorResponse);
      }
    }
  }
}
