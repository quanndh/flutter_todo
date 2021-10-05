import 'package:dio/dio.dart';
import 'package:test1/constants/ennviroment.dart';
import 'package:test1/data/services/networking/middleware/api_logger.middleware.dart';
import 'package:test1/data/services/networking/middleware/response_checker_middleware.dart';

class ApiProvider {
  final AppEnv appEnv;
  final _dio = Dio(BaseOptions());

  ApiProvider({required this.appEnv}) {
    _dio.options.baseUrl = appEnv.baseUrl;
    _dio.interceptors.addAll([
      CURLLogInterceptor(),
      ResponseCheckerInterceptor(),
    ]);
  }

  Future<Response?> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (error) {
      return null;
    }
  }

  Future<Response?> post({
    required String path,
    required Map<String, dynamic> body,
  }) async {
    //try catch is a must
    try {
      return await _dio.post(path, data: body);
    } catch (error) {
      return null;
    }
  }

  Future<Response?> put({
    required String path,
    Map<String, dynamic>? body,
  }) async {
    //try catch is a must
    try {
      return await _dio.put(path, data: body);
    } catch (error) {
      return null;
    }
  }

  Future<Response?> patch({
    required String path,
    required Map<String, dynamic> body,
  }) async {
    //try catch is a must
    try {
      return await _dio.patch(path, data: body);
    } catch (error) {
      return null;
    }
  }

  Future<Response?> delete({
    required String path,
  }) async {
    //try catch is a must
    try {
      return await _dio.delete(path);
    } catch (error) {
      return null;
    }
  }
}
