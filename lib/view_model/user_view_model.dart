

import 'package:flutter/material.dart';
import 'package:solink_flutter/network/api_result.dart';
import 'package:solink_flutter/network/data/user_response.dart';
import 'package:solink_flutter/repository/user_repository.dart';
import 'package:solink_flutter/ui/state_holder/state_holder.dart';

class UserViewModel with ChangeNotifier {
  StateHolder<UserStateHolder> _state = const Loading();
  StateHolder<UserStateHolder> get state => _state;

  final UserRepository userRepository = UserRepository();
  final int userId;
  final int pageNum;
  final int pagePer;

  UserViewModel({
    required this.userId,
    required this.pageNum,
    required this.pagePer,
  }) {
    fetchData(userId, pageNum, pagePer);
  }

  Future<void> fetchData(int userId, int pageNum, int pagePer) async {
    _state = const Loading();
    notifyListeners();

    final userResult = await userRepository.fetchUserById(userId);
    if (userResult case APIError<UserResponse> apiError) {
      _state = Error(apiError.message);
      notifyListeners();
      return;
    } else if (userResult case APISuccess<UserResponse> apiSuccess){
      _state = Success((name: apiSuccess.data.name, imageUrl: ""));
      notifyListeners();
    }
  }
}