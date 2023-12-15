// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reddit_post_listing_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedditPostListingDTO _$RedditPostListingDTOFromJson(
        Map<String, dynamic> json) =>
    RedditPostListingDTO()
      ..data = json['data'] == null
          ? null
          : RedditPostListingDataDTO.fromJson(
              json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$RedditPostListingDTOToJson(
        RedditPostListingDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
