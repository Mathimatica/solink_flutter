import 'package:solink_flutter/network/api_result.dart';
import 'package:solink_flutter/network/data/photo_response.dart';
import 'package:solink_flutter/network/service/photo_service.dart';
import 'package:solink_flutter/network/service/server_locator.dart';

class PhotoRepository {
  final PhotoService apiService = locator<PhotoService>(); 

  PhotoRepository();

  Future<ApiResult<PhotoResponse>> getPhotos(int page, int perPage) async {
    return await apiService.getPhotos(page, perPage);
  }
}