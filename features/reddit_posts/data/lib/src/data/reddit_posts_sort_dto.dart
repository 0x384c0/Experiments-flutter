import 'package:json_annotation/json_annotation.dart';

enum RedditPostsSortDTO {
  @JsonValue("top")
  top,
  @JsonValue("controversial")
  controversial,
}
