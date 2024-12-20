import 'package:flutter/material.dart';

import '../extensions/date_time_range.dart';

mixin StateDateRangeMixin<T> {
  DateTimeRange? get initialRange;

  DateTimeRange? get selectedRange;

  Future onDateRangeSelected(DateTimeRange? range);

  onLeftPressed() => _swipeByDay(-1);

  VoidCallback? get onRightPressed => _isCanSwipeByDay(1) ? () => _swipeByDay(1) : null;

  DateTimeRange get selectedRangeOrDefault =>
      selectedRange ??
      initialRange ??
      DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now(),
      );

  DateTime _getSwipedDate(int day) {
    final fromDate = day < 0 ? selectedRangeOrDefault.start : selectedRangeOrDefault.end;
    return DateTime(
      fromDate.year,
      fromDate.month,
      fromDate.day + day,
    );
  }

  bool get isOneDaySelected => !selectedRangeOrDefault.isMultipleDays;

  final _lastDay = DateTime.now();

  bool _isCanSwipeByDay(int day) => _getSwipedDate(day).isBefore(_lastDay);

  _swipeByDay(int day) {
    final date = _getSwipedDate(day);
    if (_isCanSwipeByDay(day)) onDateRangeSelected(DateTimeRange(start: date, end: date));
  }
}
