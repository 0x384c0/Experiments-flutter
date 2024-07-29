import 'package:freezed_annotation/freezed_annotation.dart';

part 'reddit_post_listing_child_data_dto.freezed.dart';

part 'reddit_post_listing_child_data_dto.g.dart';

@freezed
class RedditPostListingChildDataDTO with _$RedditPostListingChildDataDTO {
  const factory RedditPostListingChildDataDTO({
    @JsonKey(name: "author") String? author,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "body") String? body,
    @JsonKey(name: "thumbnail") String? thumbnail,
    @JsonKey(name: "subreddit") String? subreddit,
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "parent_id") String? parentId,
    @JsonKey(name: "children") List<String>? children,
  }) = _RedditPostListingChildDataDTO;

  factory RedditPostListingChildDataDTO.fromJson(Map<String, dynamic> json) =>
      _$RedditPostListingChildDataDTOFromJson(json);
}
