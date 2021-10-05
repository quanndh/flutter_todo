import 'dart:convert';

import 'package:dio/dio.dart';

extension Curl on RequestOptions {
  String toCurl() {
    var components = <String>['curl -i'];
    components.add('"${uri.toString()}"');

    components.add('-X $method');

    headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    var data = json.encode(this.data);
    if (data != '{}') {
      data = data.replaceAll('"', '\\"');
      components.add('-d "$data"');
    }

    return components.join('\\\n\t');
  }
}

extension ResponseCurl on Response {
  String toCurl() {
    final components = ['response'];

    components.add('Status: $statusCode');

    headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    var data = json.encode(this.data);
    data = data.replaceAll('"', '\\"');
    components.add('-d "$data"');

    return components.join('\\\n\t');
  }
}

class CURLLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    printWrapped(options.toCurl());
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printWrapped(response.toCurl());
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    printWrapped(err.response?.toCurl());
    return super.onError(err, handler);
  }

  void printWrapped(String? text) {
    if (text == null) {
      return;
    }
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    // ignore: avoid_print
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
