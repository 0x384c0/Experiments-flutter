// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reddit_posts_response_child_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedditPostsResponseChildDTO _$RedditPostsResponseChildDTOFromJson(
        Map<String, dynamic> json) =>
    RedditPostsResponseChildDTO()
      ..data = json['data'] == null
          ? null
          : RedditPostsResponseChildDataDTO.fromJson(
              json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$RedditPostsResponseChildDTOToJson(
        RedditPostsResponseChildDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
