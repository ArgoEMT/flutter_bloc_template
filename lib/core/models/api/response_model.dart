/// A generic response model that can be used to wrap any response from the API.
class ResponseModel<T> {
  ResponseModel({
    required this.success,
    this.message,
    this.result,
  }) : assert(
          success || message != null,
          'An error message must be provided when success is false',
        );

  ResponseModel.fromJson(Map<String, dynamic> json)
      : result = json['body'],
        success = json['successful'],
        message = json['message'];

  ResponseModel.fromResponse({
    required ResponseModel otherResponse,
    required this.result,
  })  : success = otherResponse.success,
        message = otherResponse.message;

  final String? message;
  final bool success;

  T? result;

  ResponseModel.copy(ResponseModel other)
      : success = other.success,
        message = other.message,
        result = other.result;

  @override
  String toString() => 'ResponseModel(message: $message, success: $success)';
}
