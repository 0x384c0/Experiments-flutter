import 'package:freezed_annotation/freezed_annotation.dart';

import 'timestamp_parser.dart';
import 'user.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
sealed class QuestionsResponse with _$QuestionsResponse {
  factory QuestionsResponse({
    required List<Question> items,
    required int total,
  }) = _QuestionsResponse;

  factory QuestionsResponse.fromJson(Map<String, Object?> json) => _$QuestionsResponseFromJson(json);
}

@freezed
sealed class Question with _$Question {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Question({
    required int viewCount,
    required int score,
    int? bountyAmount,
    int? acceptedAnswerId,
    required User owner,
    required int answerCount,
    @TimestampParser() required DateTime creationDate,
    required int questionId,
    required String link,
    required String title,
    required String body,
  }) = _Question;

  factory Question.fromJson(Map<String, Object?> json) => _$QuestionFromJson(json);
}
