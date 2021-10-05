import 'package:test1/data/models/topic.dart';
import 'package:test1/data/services/networking/api_provider.dart';

class TopicService {
  final ApiProvider apiProvider;
  TopicService({required this.apiProvider});

  Future<List<TopicModel>> getListTopic() async {
    try {
      final res = await apiProvider.get(path: "/topics");
      return res as Future<List<TopicModel>>;
    } catch (_) {
      throw AssertionError("aass");
    }
  }
}
