class CommonResponse {
  final int code;
  final String? message;
  final Map<String, dynamic>? data;

  CommonResponse({
    required this.code,
    this.message,
    this.data,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      code: json['code'] as int,
      message: json['message'],
      data: json['data']);
  }
}
