import 'package:json_annotation/json_annotation.dart';

part 'topic.g.dart';

@JsonSerializable(
  createFactory: true,
)
class TopicModel {
  String id;
  String name;
  String color;

  TopicModel({required this.id, required this.name, required this.color});

  factory TopicModel.fromJson(Map<String, dynamic> json) =>
      _$TopicModelFromJson(json);
}
