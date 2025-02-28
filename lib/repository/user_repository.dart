import 'package:solink_flutter/network/api_result.dart';
import 'package:solink_flutter/network/data/user_response.dart';
import 'package:solink_flutter/network/service/user_service.dart';

class UserRepository {
  final UserService apiService = UserService();

  UserRepository();

  Future<ApiResult<UserResponse>> fetchUserById(int userId) async {
    return await apiService.getUserById(userId);
  }
}