import 'package:json_annotation/json_annotation.dart';

part 'reddit_json_response_dto.g.dart';

@JsonSerializable()
class RedditJsonResponseDTO {
  RedditJsonResponseDTO();

  @JsonKey(name: "json")
  RedditJsonDTO? json;

  factory RedditJsonResponseDTO.fromJson(Map<String, dynamic> json) => _$RedditJsonResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RedditJsonResponseDTOToJson(this);
}

@JsonSerializable()
class RedditJsonDTO {
  RedditJsonDTO();

  factory RedditJsonDTO.fromJson(Map<String, dynamic> json) => _$RedditJsonDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RedditJsonDTOToJson(this);
}
