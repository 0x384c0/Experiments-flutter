import 'package:freezed_annotation/freezed_annotation.dart';

part 'reddit_posts_response_child_data_dto.g.dart';

part 'reddit_posts_response_child_data_dto.freezed.dart';

@freezed
class RedditPostsResponseChildDataDTO with _$RedditPostsResponseChildDataDTO {
  const factory RedditPostsResponseChildDataDTO({
    @JsonKey(name: "permalink") String? permalink,
    @JsonKey(name: "author") String? author,
    @JsonKey(name: "subreddit") String? subreddit,
    @JsonKey(name: "thumbnail") String? thumbnail,
    @JsonKey(name: "title") String? title,
  }) = _RedditPostsResponseChildDataDTO;

  factory RedditPostsResponseChildDataDTO.fromJson(Map<String, dynamic> json) =>
      _$RedditPostsResponseChildDataDTOFromJson(json);
}
