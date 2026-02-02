import 'package:dio/dio.dart';
import 'package:sonic_app/core/networking/api_error_model.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;
    if (responseData is Map<String, dynamic> &&
        responseData['message'] != null) {
      return ApiError(message: responseData['message'], statuscode: statusCode);
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Connection timeout");
      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Receive timeout");
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Send timeout");
      case DioExceptionType.cancel:
        return ApiError(message: "Request was cancelled");
      default:
        return ApiError(message: "Please Try Again");
    }
  }
}
