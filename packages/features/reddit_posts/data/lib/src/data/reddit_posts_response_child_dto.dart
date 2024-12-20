import 'package:freezed_annotation/freezed_annotation.dart';
import 'reddit_posts_response_child_data_dto.dart';

part 'reddit_posts_response_child_dto.g.dart';

part 'reddit_posts_response_child_dto.freezed.dart';

@freezed
class RedditPostsResponseChildDTO with _$RedditPostsResponseChildDTO {
  const factory RedditPostsResponseChildDTO({
    @JsonKey(name: "data") RedditPostsResponseChildDataDTO? data,
  }) = _RedditPostsResponseChildDTO;

  factory RedditPostsResponseChildDTO.fromJson(Map<String, dynamic> json) =>
      _$RedditPostsResponseChildDTOFromJson(json);
}
