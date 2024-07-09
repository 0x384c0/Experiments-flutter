import 'package:freezed_annotation/freezed_annotation.dart';

import 'reddit_post_listing_data_dto.dart';

part 'reddit_post_listing_dto.freezed.dart';

part 'reddit_post_listing_dto.g.dart';

@freezed
class RedditPostListingDTO with _$RedditPostListingDTO {
  const factory RedditPostListingDTO({
    @JsonKey(name: "data") RedditPostListingDataDTO? data,
  }) = _RedditPostListingDTO;

  factory RedditPostListingDTO.fromJson(Map<String, dynamic> json) => _$RedditPostListingDTOFromJson(json);
}
