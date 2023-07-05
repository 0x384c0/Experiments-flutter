import 'package:json_annotation/json_annotation.dart';

import 'reddit_post_listing_data_dto.dart';

part 'reddit_post_listing_dto.g.dart';

@JsonSerializable()
class RedditPostListingDTO {
  RedditPostListingDTO();

  @JsonKey(name: "data")
  RedditPostListingDataDTO? data;

  factory RedditPostListingDTO.fromJson(Map<String, dynamic> json) => _$RedditPostListingDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RedditPostListingDTOToJson(this);
}