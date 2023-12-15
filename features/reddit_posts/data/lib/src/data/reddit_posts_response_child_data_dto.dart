import 'package:json_annotation/json_annotation.dart';

part 'reddit_posts_response_child_data_dto.g.dart';

@JsonSerializable()
class RedditPostsResponseChildDataDTO {
  RedditPostsResponseChildDataDTO();

  @JsonKey(name: "permalink")
  String? permalink;
  @JsonKey(name: "author")
  String? author;
  @JsonKey(name: "subreddit")
  String? subreddit;
  @JsonKey(name: "thumbnail")
  String? thumbnail;
  @JsonKey(name: "title")
  String? title;

  factory RedditPostsResponseChildDataDTO.fromJson(Map<String, dynamic> json) => _$RedditPostsResponseChildDataDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RedditPostsResponseChildDataDTOToJson(this);
}