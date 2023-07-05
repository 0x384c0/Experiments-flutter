import 'package:features_reddit_posts_data/data/reddit_posts_response_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reddit_posts_response_dto.g.dart';

@JsonSerializable()
class RedditPostsResponseDTO {
  RedditPostsResponseDTO();

  @JsonKey(name: "data")
  RedditPostsResponseDataDTO? data;

  factory RedditPostsResponseDTO.fromJson(Map<String, dynamic> json) => _$RedditPostsResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RedditPostsResponseDTOToJson(this);
}