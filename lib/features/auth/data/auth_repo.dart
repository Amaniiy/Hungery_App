import 'package:dio/dio.dart';
import 'package:sonic_app/core/networking/api_error_model.dart';
import 'package:sonic_app/core/networking/api_exceptions.dart';
import 'package:sonic_app/core/networking/api_service.dart';
import 'package:sonic_app/core/utils/pref_helper.dart';
import 'package:sonic_app/features/auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();

  //-----------------------------------------------------------------------------
  //login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post('/login', {
        //بجبهم من postman
        'email': email,
        'password': password,
      });

      if (response is ApiError) {
        throw response;
      }
      //بنجبهم من postman
      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];

        if (code != 200 || data == null) {
          throw ApiError(message: msg);
        }

        final user = UserModel.fromJson(response['data']);
        //بنحفظ تسجيل الدخول
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        return user;
      } else {
        throw ApiError(message: 'Unexpected Error From Server');
      }

      //حاله الفشل
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //signup

  Future<UserModel?> signup(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await apiService.post('/signup', {
        'name': name,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      });

      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final coder = int.tryParse(code);
        final data = response['data'];

        if (coder != 200 && coder != 201) {
          throw ApiError(message: msg ?? "unknown error");
        }

        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        return user;
      } else {
        throw ApiError(message: 'Unexpected Error From Server');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //get profile data
  //update profile data

  //logout
  //دي عشان لما يضغط علي زر تسجيل الخروج
  Future<void> logout() async {
    final response = await apiService.post('/logout', {});
    if (response['data'] != null) {
      throw ApiError(message: 'Logout Failed');
    }
    //هنمسح التوكن من الجهاز
    await PrefHelper.clearToken();
  }
}
