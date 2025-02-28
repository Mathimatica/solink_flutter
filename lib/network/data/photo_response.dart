import 'package:json_annotation/json_annotation.dart';

part 'photo_response.g.dart';

@JsonSerializable()
class PhotoResponse {
  final List<Photo> photos;

  PhotoResponse({required this.photos});

  factory PhotoResponse.fromJson(Map<String, dynamic> json) => _$PhotoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoResponseToJson(this);
}

@JsonSerializable()
class Photo {
  final int id;
  final String photographer;
  final String url;
  final ImageSources src;

  Photo({
    required this.id,
    required this.photographer,
    required this.url,
    required this.src,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}

@JsonSerializable()
class ImageSources {
  final String original;
  final String medium;
  final String small;

  ImageSources({
    required this.original,
    required this.medium,
    required this.small,
  });

  factory ImageSources.fromJson(Map<String, dynamic> json) => _$ImageSourcesFromJson(json);
  Map<String, dynamic> toJson() => _$ImageSourcesToJson(this);
}