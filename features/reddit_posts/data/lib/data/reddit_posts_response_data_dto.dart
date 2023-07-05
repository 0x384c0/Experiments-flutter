import 'package:json_annotation/json_annotation.dart';
import 'reddit_posts_response_child_dto.dart';

part 'reddit_posts_response_data_dto.g.dart';

@JsonSerializable()
class RedditPostsResponseDataDTO {
  RedditPostsResponseDataDTO();

  @JsonKey(name: "children")
  List<RedditPostsResponseChildDTO>? children;

  factory RedditPostsResponseDataDTO.fromJson(Map<String, dynamic> json) => _$RedditPostsResponseDataDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RedditPostsResponseDataDTOToJson(this);
}