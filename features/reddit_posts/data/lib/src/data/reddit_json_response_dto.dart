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
    @JsonKey(name: "json") RedditJsonDTO? json,
  }) = _RedditJsonDTO;

  factory RedditJsonDTO.fromJson(Map<String, dynamic> json) => _$RedditJsonDTOFromJson(json);
}
