import 'package:freezed_annotation/freezed_annotation.dart';

class TimestampParser implements JsonConverter<DateTime, int> {
  const TimestampParser();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json * 1000, isUtc: true);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}
