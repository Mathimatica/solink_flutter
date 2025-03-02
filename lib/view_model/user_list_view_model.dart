import 'package:flutter/material.dart';
import 'package:solink_flutter/network/api_result.dart';
import 'package:solink_flutter/network/data/photo_response.dart';
import 'package:solink_flutter/network/service/server_locator.dart';
import 'package:solink_flutter/repository/photo_repository.dart';
import 'package:solink_flutter/repository/user_repository.dart';
import 'package:solink_flutter/ui/screen/user_screen.dart';
import 'package:solink_flutter/ui/state_holder/state_holder.dart';

class UserRoute extends MaterialPageRoute<void> {
  final String name;
  final String imageUrl;

  UserRoute({required this.name, required this.imageUrl})
    : super(builder: (context) => UserScreen(name: name, imageUrl: imageUrl));
}

class UserListViewModel with ChangeNotifier {
  StateHolder<UserListStateHolder> _state = const Loading();
  StateHolder<UserListStateHolder> get state => _state;

  final UserRepository userRepository = locator<UserRepository>(); 
  final PhotoRepository photoRepository = locator<PhotoRepository>(); 
  final int pageNum;
  final int pagePer;

  UserListViewModel({required this.pageNum, required this.pagePer}) {
    fetchData(pageNum, pagePer);
  }

  Future<void> fetchData(int pageNum, int pagePer) async {
    _state = const Loading();
    notifyListeners();

    final photoResult = await photoRepository.getPhotos(pageNum, pagePer);
    if (photoResult case APIError<PhotoResponse> apiError) {
      _state = Error(apiError.message);
      notifyListeners();
      return;
    } else if (photoResult case APISuccess<PhotoResponse> photoSuccess) {
      _state = Success((
        users:
            photoSuccess.data.photos.map((photo) {
              return (
                name: photo.photographer,
                imageUrl: photo.src.small,
                processOnClick: (onClick) {
                  onClick(photo);
                },
              );
            }).toList(),
      ));
      notifyListeners();
    }
  }
}
