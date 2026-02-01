/*import 'package:dio/dio.dart';
import 'package:sonic_app/core/networking/api_error_model.dart';

class ApiExceptions {
  static ApiError handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return ApiError(message: "Connection timeout");
      case DioErrorType.receiveTimeout:
        return ApiError(message: "Receive timeout");
      case DioErrorType.sendTimeout:
        return ApiError(message: "Send timeout");
      case DioErrorType.cancel:
        return ApiError(message: "Request was cancelled");
      default:
        return ApiError(
          message: "Unexpected Error: ${error.message}",
          statuscode: error.response?.statusCode,
        );
    }
  }
}
*/
