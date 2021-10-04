class TopicModel {
  String id;
  String name;

  TopicModel({required this.id, required this.name});

  TopicModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json["id"];

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
