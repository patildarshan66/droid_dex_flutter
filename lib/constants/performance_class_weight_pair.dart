class PerformanceClassWeightPair {
  final int performanceClass;
  final double weight;

  PerformanceClassWeightPair({
    required this.performanceClass,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'class': performanceClass,
      'weight': weight,
    };
  }

  static PerformanceClassWeightPair fromMap(Map<String, dynamic> map) {
    return PerformanceClassWeightPair(
      performanceClass: map['class'] as int,
      weight: (map['weight'] as num).toDouble(),
    );
  }
}
