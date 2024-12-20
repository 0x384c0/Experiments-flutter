import 'package:common_presentation/extensions/build_context_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeRangeLocalization on DateTimeRange {
  String toStringLocalized(BuildContext context) {
    final format = DateFormat.yMMMd(context.commonLocalization.localeName);
    var result = format.format(start);
    if (isMultipleDays) result += ' - ${format.format(end)}';
    return result;
  }

  bool get isMultipleDays => !isSameDay(start, end);

  DateTimeRange get correctedDayRange {
    DateTime correctedStart = start;
    DateTime correctedEnd = end;

    // Ensure start is before end, swap if necessary
    if (correctedStart.isAfter(correctedEnd)) {
      final temp = correctedStart;
      correctedStart = correctedEnd;
      correctedEnd = temp;
    }

    // Set the start to the start of the day
    correctedStart = DateTime(correctedStart.year, correctedStart.month, correctedStart.day);

    // Set the end to the end of the day
    correctedEnd = DateTime(correctedEnd.year, correctedEnd.month, correctedEnd.day, 23, 59, 59, 999);

    return DateTimeRange(start: correctedStart, end: correctedEnd);
  }

  /// Checks if two DateTime objects are the same day.
  /// Returns `false` if either of them is null.
  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
