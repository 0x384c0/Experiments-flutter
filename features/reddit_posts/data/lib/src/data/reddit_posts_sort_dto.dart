import 'package:freezed_annotation/freezed_annotation.dart';

enum RedditPostsSortDTO {
  @JsonValue("top")
  top,
  @JsonValue("controversial")
  controversial,
}
