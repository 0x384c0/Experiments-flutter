import 'package:json_annotation/json_annotation.dart';

import 'reddit_post_listing_child_data_dto.dart';

part 'reddit_post_listing_child_dto.g.dart';

@JsonSerializable()
class RedditPostListingChildDTO {
  RedditPostListingChildDTO();

  @JsonKey(name: "data")
  RedditPostListingChildDataDTO? data;

  factory RedditPostListingChildDTO.fromJson(Map<String, dynamic> json) => _$RedditPostListingChildDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RedditPostListingChildDTOToJson(this);
}