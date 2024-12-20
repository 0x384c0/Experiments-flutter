import 'package:freezed_annotation/freezed_annotation.dart';
import 'reddit_posts_response_child_dto.dart';

part 'reddit_posts_response_data_dto.g.dart';

part 'reddit_posts_response_data_dto.freezed.dart';

@freezed
class RedditPostsResponseDataDTO with _$RedditPostsResponseDataDTO {
  const factory RedditPostsResponseDataDTO({
    @JsonKey(name: "children") List<RedditPostsResponseChildDTO>? children,
    @JsonKey(name: "after") String? after,
  }) = _RedditPostsResponseDataDTO;

  factory RedditPostsResponseDataDTO.fromJson(Map<String, dynamic> json) => _$RedditPostsResponseDataDTOFromJson(json);
}
