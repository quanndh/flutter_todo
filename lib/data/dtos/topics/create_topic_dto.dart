import 'package:json_annotation/json_annotation.dart';

part 'create_topic_dto.g.dart';

@JsonSerializable(
  createToJson: true,
  createFactory: false,
)
class CreateTopicDto {
  final String name;
  final String color;

  CreateTopicDto({required this.name, required this.color});

  Map<String, dynamic> toJson() => _$CreateTopicDtoToJson(this);
}
