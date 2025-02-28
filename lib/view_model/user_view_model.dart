

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solink_flutter/network/api_result.dart';
import 'package:solink_flutter/network/data/photo_response.dart';
import 'package:solink_flutter/network/data/user_response.dart';
import 'package:solink_flutter/repository/photo_repository.dart';
import 'package:solink_flutter/repository/user_repository.dart';
import 'package:solink_flutter/ui/state_holder/state_holder.dart';

class UserViewModel with ChangeNotifier {
  StateHolder<UserStateHolder> _state = const Loading();
  StateHolder<UserStateHolder> get state => _state;

  final UserRepository userRepository = UserRepository();
  final PhotoRepository photoRepository = PhotoRepository();
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
    } else if (userResult case APISuccess<UserResponse> userSuccess){

      final photoResult = await photoRepository.getPhotos(pageNum, pagePer);
          if (photoResult case APIError<PhotoResponse> apiError) {
      _state = Error(apiError.message);
      notifyListeners();
      return;
    } else if (photoResult case APISuccess<PhotoResponse> photoSuccess){ 
      final random = Random();
      Photo randomPhoto = photoSuccess.data.photos[random.nextInt(photoSuccess.data.photos.length)];
      _state = Success((name: userSuccess.data.name, imageUrl: randomPhoto.src.original));
      notifyListeners();
    }
    }
  }
}