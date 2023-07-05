import 'package:json_annotation/json_annotation.dart';

import 'reddit_post_listing_child_dto.dart';

part 'reddit_post_listing_data_dto.g.dart';

@JsonSerializable()
class RedditPostListingDataDTO {
  RedditPostListingDataDTO();

  @JsonKey(name: "children")
  List<RedditPostListingChildDTO>? children;

  factory RedditPostListingDataDTO.fromJson(Map<String, dynamic> json) => _$RedditPostListingDataDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RedditPostListingDataDTOToJson(this);
}