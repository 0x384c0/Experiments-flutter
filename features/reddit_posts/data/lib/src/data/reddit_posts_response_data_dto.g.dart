// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reddit_posts_response_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedditPostsResponseDataDTO _$RedditPostsResponseDataDTOFromJson(
        Map<String, dynamic> json) =>
    RedditPostsResponseDataDTO()
      ..children = (json['children'] as List<dynamic>?)
          ?.map((e) =>
              RedditPostsResponseChildDTO.fromJson(e as Map<String, dynamic>))
          .toList()
      ..after = json['after'] as String?;

Map<String, dynamic> _$RedditPostsResponseDataDTOToJson(
        RedditPostsResponseDataDTO instance) =>
    <String, dynamic>{
      'children': instance.children,
      'after': instance.after,
    };
