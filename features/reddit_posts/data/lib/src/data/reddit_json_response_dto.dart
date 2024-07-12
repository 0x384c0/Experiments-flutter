import 'package:features_reddit_posts_data/src/data/reddit_post_listing_data_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reddit_json_response_dto.freezed.dart';

part 'reddit_json_response_dto.g.dart';

@freezed
class RedditJsonResponseDTO with _$RedditJsonResponseDTO {
  const factory RedditJsonResponseDTO({
    @JsonKey(name: "json") RedditJsonDTO? json,
  }) = _RedditJsonResponseDTO;

  factory RedditJsonResponseDTO.fromJson(Map<String, dynamic> json) => _$RedditJsonResponseDTOFromJson(json);
}

@freezed
class RedditJsonDTO with _$RedditJsonDTO {
  const factory RedditJsonDTO({
    @JsonKey(name: "data") RedditJsonDataDTO? data,
  }) = _RedditJsonDTO;

  factory RedditJsonDTO.fromJson(Map<String, dynamic> json) => _$RedditJsonDTOFromJson(json);
}

@freezed
class RedditJsonDataDTO with _$RedditJsonDataDTO {
  const factory RedditJsonDataDTO({
    @JsonKey(name: "things") List<RedditPostListingDataDTO>? things,
  }) = _RedditJsonDataDTO;

  factory RedditJsonDataDTO.fromJson(Map<String, dynamic> json) => _$RedditJsonDataDTOFromJson(json);
}
