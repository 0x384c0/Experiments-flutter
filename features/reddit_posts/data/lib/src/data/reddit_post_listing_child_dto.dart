import 'package:freezed_annotation/freezed_annotation.dart';

import 'reddit_post_listing_child_data_dto.dart';

part 'reddit_post_listing_child_dto.g.dart';

part 'reddit_post_listing_child_dto.freezed.dart';

@freezed
class RedditPostListingChildDTO with _$RedditPostListingChildDTO {
  const factory RedditPostListingChildDTO({
    @JsonKey(name: "data") RedditPostListingChildDataDTO? data,
  }) = _RedditPostListingChildDTO;

  factory RedditPostListingChildDTO.fromJson(Map<String, dynamic> json) => _$RedditPostListingChildDTOFromJson(json);
}
