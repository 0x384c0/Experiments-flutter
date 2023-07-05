import 'package:json_annotation/json_annotation.dart';
import 'reddit_posts_response_child_data_dto.dart';

part 'reddit_posts_response_child_dto.g.dart';

@JsonSerializable()
class RedditPostsResponseChildDTO {
  RedditPostsResponseChildDTO();

  @JsonKey(name: "data")
  RedditPostsResponseChildDataDTO? data;

  factory RedditPostsResponseChildDTO.fromJson(Map<String, dynamic> json) => _$RedditPostsResponseChildDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RedditPostsResponseChildDTOToJson(this);
}