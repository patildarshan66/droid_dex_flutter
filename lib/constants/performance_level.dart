enum PerformanceLevel {
  unknown(0),
  low(1),
  average(2),
  high(3),
  excellent(4);

  final int level;
  const PerformanceLevel(this.level);

  static PerformanceLevel fromLevel(int? level) {
    return PerformanceLevel.values.firstWhere(
      (e) => e.level == level,
      orElse: () => PerformanceLevel.unknown,
    );
  }
}
