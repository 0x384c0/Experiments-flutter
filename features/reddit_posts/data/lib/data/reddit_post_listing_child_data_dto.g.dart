// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reddit_post_listing_child_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedditPostListingChildDataDTO _$RedditPostListingChildDataDTOFromJson(
        Map<String, dynamic> json) =>
    RedditPostListingChildDataDTO()
      ..author = json['author'] as String?
      ..text = json['text'] as String?
      ..thumbnail = json['thumbnail'] as String?
      ..subreddit = json['subreddit'] as String?;

Map<String, dynamic> _$RedditPostListingChildDataDTOToJson(
        RedditPostListingChildDataDTO instance) =>
    <String, dynamic>{
      'author': instance.author,
      'text': instance.text,
      'thumbnail': instance.thumbnail,
      'subreddit': instance.subreddit,
    };
