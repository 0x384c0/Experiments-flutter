class TimelapseSettings {
  final int intervalSeconds;
  final DateTime? startDate;
  final DateTime? endDate;

  const TimelapseSettings({
    this.intervalSeconds = 5,
    this.startDate,
    this.endDate,
  });

  TimelapseSettings copyWith({
    int? intervalSeconds,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return TimelapseSettings(
      intervalSeconds: intervalSeconds ?? this.intervalSeconds,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
