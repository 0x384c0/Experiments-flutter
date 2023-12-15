// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reddit_post_listing_child_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedditPostListingChildDTO _$RedditPostListingChildDTOFromJson(
        Map<String, dynamic> json) =>
    RedditPostListingChildDTO()
      ..data = json['data'] == null
          ? null
          : RedditPostListingChildDataDTO.fromJson(
              json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$RedditPostListingChildDTOToJson(
        RedditPostListingChildDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
