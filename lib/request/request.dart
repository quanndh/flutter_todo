import 'package:test1/constants/ennviroment.dart';
import 'package:test1/models/topic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<TopicModel>> getTopic() async {
  var url = Uri.http(AppEnv.baseUrl, "/topics");

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;

    return jsonResponse.map((e) {
      return TopicModel.fromJson(e);
    }).toList();
  }

  throw Exception("Lỗi");
}
