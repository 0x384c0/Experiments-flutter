// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reddit_posts_response_child_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedditPostsResponseChildDataDTO _$RedditPostsResponseChildDataDTOFromJson(
        Map<String, dynamic> json) =>
    RedditPostsResponseChildDataDTO()
      ..permalink = json['permalink'] as String?
      ..author = json['author'] as String?
      ..category = json['category'] as String?
      ..icon = json['icon'] as String?
      ..title = json['title'] as String?;

Map<String, dynamic> _$RedditPostsResponseChildDataDTOToJson(
        RedditPostsResponseChildDataDTO instance) =>
    <String, dynamic>{
      'permalink': instance.permalink,
      'author': instance.author,
      'category': instance.category,
      'icon': instance.icon,
      'title': instance.title,
    };
