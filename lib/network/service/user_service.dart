import 'package:dio/dio.dart';
import 'package:solink_flutter/network/api_result.dart';
import 'package:solink_flutter/network/data/user_response.dart';

class UserService {
  final Dio _dio;

  UserService()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://jsonplaceholder.typicode.com/',
          connectTimeout: Duration(seconds: 5),
          receiveTimeout: Duration(seconds: 5),
        ));

  Future<ApiResult<UserResponse>> getUserById(int id) async {
    try {
      final response = await _dio.get('/users/$id');
      return APISuccess(UserResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioException && e.response != null) {
        return APIError(e.response!.data?.toString());
      }
      return APIError(e.toString());
    }
  }
}