// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoResponse _$PhotoResponseFromJson(Map<String, dynamic> json) =>
    PhotoResponse(
      photos:
          (json['photos'] as List<dynamic>)
              .map((e) => Photo.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$PhotoResponseToJson(PhotoResponse instance) =>
    <String, dynamic>{'photos': instance.photos};

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
  id: (json['id'] as num).toInt(),
  photographer: json['photographer'] as String,
  url: json['url'] as String,
  src: ImageSources.fromJson(json['src'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
  'id': instance.id,
  'photographer': instance.photographer,
  'url': instance.url,
  'src': instance.src,
};

ImageSources _$ImageSourcesFromJson(Map<String, dynamic> json) => ImageSources(
  original: json['original'] as String,
  medium: json['medium'] as String,
  small: json['small'] as String,
);

Map<String, dynamic> _$ImageSourcesToJson(ImageSources instance) =>
    <String, dynamic>{
      'original': instance.original,
      'medium': instance.medium,
      'small': instance.small,
    };
