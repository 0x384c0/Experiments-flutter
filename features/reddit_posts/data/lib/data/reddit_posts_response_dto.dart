import 'package:json_annotation/json_annotation.dart';

part 'reddit_posts_response_dto.g.dart';

@JsonSerializable()
class RedditPostsResponseDTO {
  RedditPostsResponseDTO();

  factory RedditPostsResponseDTO.fromJson(Map<String, dynamic> json) => _$RedditPostsResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RedditPostsResponseDTOToJson(this);
}
