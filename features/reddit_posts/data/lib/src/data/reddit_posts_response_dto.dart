import 'reddit_posts_response_data_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reddit_posts_response_dto.freezed.dart';

part 'reddit_posts_response_dto.g.dart';

@freezed
class RedditPostsResponseDTO with _$RedditPostsResponseDTO {
  const factory RedditPostsResponseDTO({
    @JsonKey(name: "data") RedditPostsResponseDataDTO? data,
  }) = _RedditPostsResponseDTO;

  factory RedditPostsResponseDTO.fromJson(Map<String, dynamic> json) => _$RedditPostsResponseDTOFromJson(json);
}
