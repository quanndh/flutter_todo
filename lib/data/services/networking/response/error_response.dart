class ErrorResponse {
  final int code;
  final String message;
  final dynamic details;

  ErrorResponse({
    required this.code,
    required this.message,
    required this.details,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
        code: json['code'] as int,
        message: json['message'] as String,
        details: json['details']);
  }

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'code': code,
      'message': message,
      'details': details,
    };
    return val;
  }
}
