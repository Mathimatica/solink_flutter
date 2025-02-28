import 'package:dio/dio.dart';
import 'package:solink_flutter/network/api_result.dart';
import 'package:solink_flutter/network/data/photo_response.dart';

class PhotoService {
  final Dio _dio;

  PhotoService()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://api.pexels.com/',
          connectTimeout: Duration(seconds: 5),
          receiveTimeout: Duration(seconds: 5),
        ))..options.headers['Authorization'] = 'FyawVqgusyrCd8HvbeY1OpuPTp4fn0tcvaPvirjDMN1ua3uHDLM95Ikg';

  Future<ApiResult<PhotoResponse>> getPhotos(int page, int perPage) async {
    try {
      final response = await _dio.get(
        '/v1/curated',
        queryParameters: {'page': page, 'per_page': perPage},
      );
      return APISuccess(PhotoResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioException && e.response != null) {
        return APIError(e.response!.data?.toString());
      }
      return APIError(e.toString());
    }
  }
}