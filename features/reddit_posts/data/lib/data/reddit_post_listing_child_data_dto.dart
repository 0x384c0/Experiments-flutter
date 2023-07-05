import 'package:json_annotation/json_annotation.dart';

part 'reddit_post_listing_child_data_dto.g.dart';

@JsonSerializable()
class RedditPostListingChildDataDTO {
  RedditPostListingChildDataDTO();

  @JsonKey(name: "author")
  String? author;
  @JsonKey(name: "text")
  String? text;
  @JsonKey(name: "thumbnail")
  String? thumbnail;
  @JsonKey(name: "subreddit")
  String? subreddit;

  factory RedditPostListingChildDataDTO.fromJson(Map<String, dynamic> json) => _$RedditPostListingChildDataDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RedditPostListingChildDataDTOToJson(this);
}