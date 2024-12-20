import 'package:freezed_annotation/freezed_annotation.dart';

import 'reddit_post_listing_child_dto.dart';

part 'reddit_post_listing_data_dto.g.dart';

part 'reddit_post_listing_data_dto.freezed.dart';

@freezed
class RedditPostListingDataDTO with _$RedditPostListingDataDTO {
  const factory RedditPostListingDataDTO({
    @JsonKey(name: "after") String? after,
    @JsonKey(name: "children") List<RedditPostListingChildDTO>? children,
  }) = _RedditPostListingDataDTO;

  factory RedditPostListingDataDTO.fromJson(Map<String, dynamic> json) => _$RedditPostListingDataDTOFromJson(json);
}
