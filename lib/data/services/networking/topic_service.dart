import 'package:test1/data/dtos/topics/create_topic_dto.dart';
import 'package:test1/data/models/topic.dart';
import 'package:test1/data/services/networking/api_provider.dart';
import 'package:test1/data/services/networking/response/common_list_response.dart';
import 'package:test1/data/services/networking/response/common_response.dart';

class TopicService {
  final ApiProvider apiProvider;
  TopicService({required this.apiProvider});

  Future<CommonListResponse<TopicModel>?> getListTopic() async {
    try {
      final res = await apiProvider.get(path: "/topics");

      if (res == null) return null;

      return CommonListResponse<TopicModel>.fromJson(
          json: res.data, fromJson: (json) => TopicModel.fromJson(json));
    } catch (err) {
      throw AssertionError(err.toString());
    }
  }

  Future<TopicModel?> createTopic(CreateTopicDto topic) async {
    try {
      final res = await apiProvider.post(path: "/topics", body: topic.toJson());

      if (res == null) return null;

      var commonRes = CommonResponse.fromJson(res.data);

      return TopicModel.fromJson(commonRes.data!);
    } catch (err) {
      throw AssertionError(err.toString());
    }
  }
}
