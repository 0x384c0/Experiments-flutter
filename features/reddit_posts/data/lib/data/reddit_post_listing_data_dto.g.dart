// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reddit_post_listing_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedditPostListingDataDTO _$RedditPostListingDataDTOFromJson(
        Map<String, dynamic> json) =>
    RedditPostListingDataDTO()
      ..children = (json['children'] as List<dynamic>?)
          ?.map((e) =>
              RedditPostListingChildDTO.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$RedditPostListingDataDTOToJson(
        RedditPostListingDataDTO instance) =>
    <String, dynamic>{
      'children': instance.children,
    };
