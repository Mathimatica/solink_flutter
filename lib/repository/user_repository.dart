import 'package:solink_flutter/network/api_result.dart';
import 'package:solink_flutter/network/data/user_response.dart';
import 'package:solink_flutter/network/service/server_locator.dart';
import 'package:solink_flutter/network/service/user_service.dart';

class UserRepository {
  final UserService apiService = locator<UserService>(); 

  UserRepository();

  Future<ApiResult<UserResponse>> fetchUserById(int userId) async {
    return await apiService.getUserById(userId);
  }
}