/*import 'package:dio/dio.dart';
import 'package:sonic_app/core/networking/api_exceptions.dart';
import 'package:sonic_app/core/networking/dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  // GET
  Future<dynamic> get(String endPoint) async {
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  // POST
  Future<dynamic> post(String endPoint, Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: data);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  // PUT||update
  Future<dynamic> put(String endPoint, Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: data);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  // DELETE
  Future<dynamic> delete(String endPoint) async {
    try {
      final response = await _dioClient.dio.delete(endPoint);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }
}
*/
