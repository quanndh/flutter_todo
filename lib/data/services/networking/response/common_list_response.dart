class CommonListResponse<T> {
  final int code;
  final String? message;
  final List<T>? data;

  CommonListResponse({
    required this.code,
    this.message,
    required this.data,
  });

  factory CommonListResponse.fromJson({
    required Map<String, dynamic> json,
    required Function(Map<String, dynamic> json) fromJson,
  }) {
    final itemsJson = json['data'] as List<dynamic>;
    final results =
        List<T>.from(itemsJson.map((itemsJson) => fromJson(itemsJson)));
    return CommonListResponse(
      code: json['code'] as int,
      message: json['message'],
      data: results.toList(),
    );
  }
}
