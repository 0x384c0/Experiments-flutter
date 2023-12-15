// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reddit_post_listing_child_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedditPostListingChildDataDTO _$RedditPostListingChildDataDTOFromJson(
        Map<String, dynamic> json) =>
    RedditPostListingChildDataDTO()
      ..author = json['author'] as String?
      ..title = json['title'] as String?
      ..body = json['body'] as String?
      ..thumbnail = json['thumbnail'] as String?
      ..subreddit = json['subreddit'] as String?;

Map<String, dynamic> _$RedditPostListingChildDataDTOToJson(
        RedditPostListingChildDataDTO instance) =>
    <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'body': instance.body,
      'thumbnail': instance.thumbnail,
      'subreddit': instance.subreddit,
    };
