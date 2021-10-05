import 'package:test1/data/services/networking/response/error_response.dart';

class ApiException implements Exception {
  final ErrorResponse errorResponse;

  ApiException(this.errorResponse);

  @override
  String toString() => errorResponse.toJson().toString();
}
