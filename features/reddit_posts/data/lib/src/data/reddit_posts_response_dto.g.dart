// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reddit_posts_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedditPostsResponseDTO _$RedditPostsResponseDTOFromJson(
        Map<String, dynamic> json) =>
    RedditPostsResponseDTO()
      ..data = json['data'] == null
          ? null
          : RedditPostsResponseDataDTO.fromJson(
              json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$RedditPostsResponseDTOToJson(
        RedditPostsResponseDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
