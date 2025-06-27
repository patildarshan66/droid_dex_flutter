import 'constants/performance_class_weight_pair.dart';
import 'constants/performance_level.dart';
import 'droid_dex_flutter_platform_interface.dart';

class DroidDexFlutter {
  Future<void> init() async {
    return await DroidDexFlutterPlatform.instance.init();
  }

  /// @param performance class
  /// @return PerformanceLevel for the input class
  ///
  /// Steps for getting PerformanceLevel:
  /// - Check if the class has been initialized or not
  /// - Get the PerformanceLevel of individual PerformanceClass
  /// - Ignore the ones for which the PerformanceLevel is UNKNOWN
  Future<PerformanceLevel> getPerformanceLevel(int performanceClass) async {
    final performanceLevel = await DroidDexFlutterPlatform.instance
        .getPerformanceLevel(performanceClass);
    return PerformanceLevel.fromLevel(performanceLevel);
  }

  /// @param classes spread list of performance classes
  /// @return Average PerformanceLevel for the input classes
  ///
  /// Steps for getting PerformanceLevel:
  /// - Check if the class has been initialized or not
  /// - Get the PerformanceLevel of individual PerformanceClass
  /// - Ignore the ones for which the PerformanceLevel is UNKNOWN
  /// - Take average of all these PerformanceClass
  Future<PerformanceLevel>
  getAveragePerformanceLevelOfMultiplePerformanceClasses(
    List<int> performanceClassesList,
  ) async {
    final performanceLevel = await DroidDexFlutterPlatform.instance
        .getAveragePerformanceLevelOfMultiplePerformanceClasses(
          performanceClassesList,
        );
    return PerformanceLevel.fromLevel(performanceLevel);
  }

  /// @param performance class
  /// @return LiveData of Average PerformanceLevel for the input class
  ///
  /// Steps for getting PerformanceLevel:
  /// - Check if the class has been initialized or not
  /// - Get the PerformanceLevel of individual PerformanceClass
  /// - Ignore the ones for which the PerformanceLevel is UNKNOWN
  Future<Stream<PerformanceLevel>> getPerformanceLevelLiveData(
    int performanceClass,
  ) async {
    final performanceLevelData = await DroidDexFlutterPlatform.instance
        .getPerformanceLevelLiveData(performanceClass);
    return performanceLevelData.map(
      (level) => PerformanceLevel.fromLevel(level),
    );
  }

  /// @param classes spread list of performance classes
  /// @return LiveData of Average PerformanceLevel for the input classes
  ///
  /// Steps for getting PerformanceLevel:
  /// - Check if the class has been initialized or not
  /// - Get the PerformanceLevel of individual PerformanceClass
  /// - Ignore the ones for which the PerformanceLevel is UNKNOWN
  /// - Take average of all these PerformanceClass
  Future<Stream<PerformanceLevel>>
  getAveragePLOfMultiplePerformanceClassesLiveData(
    List<int> performanceClassesList,
  ) async {
    final performanceLevelData = await DroidDexFlutterPlatform.instance
        .getAveragePLOfMultiplePerformanceClassesLiveData(
          performanceClassesList,
        );
    return performanceLevelData.map(
      (level) => PerformanceLevel.fromLevel(level),
    );
  }

  /// @param classes spread list of performance classes mapped with weight
  /// @return Weighted Average PerformanceLevel for the input classes
  ///
  /// Steps for getting PerformanceLevel:
  /// - Check if the class has been initialized or not
  /// - Get the PerformanceLevel of individual PerformanceClass
  /// - Ignore the ones for which the PerformanceLevel is UNKNOWN
  /// - Take weighted average of all these PerformanceClass
  Future<PerformanceLevel> getWeightedPerformanceLevel(
    List<PerformanceClassWeightPair> performanceClassWeightPairList,
  ) async {
    final performanceLevel = await DroidDexFlutterPlatform.instance
        .getWeightedPerformanceLevel(performanceClassWeightPairList);
    return PerformanceLevel.fromLevel(performanceLevel);
  }

  /// @param classes spread list of performance classes mapped with weight
  /// @return LiveData of Weighted Average PerformanceLevel for the input classes
  ///
  /// Steps for getting PerformanceLevel:
  /// - Check if the class has been initialized or not
  /// - Get the PerformanceLevel of individual PerformanceClass
  /// - Ignore the ones for which the PerformanceLevel is UNKNOWN
  /// - Take weighted average of all these PerformanceClass
  Future<Stream<PerformanceLevel>> getWeightedPerformanceLevelLiveData(
    List<PerformanceClassWeightPair> performanceClassWeightPairList,
  ) async {
    final performanceLevelData = await DroidDexFlutterPlatform.instance
        .getWeightedPerformanceLevelLiveData(performanceClassWeightPairList);
    return performanceLevelData.map(
      (level) => PerformanceLevel.fromLevel(level),
    );
  }
}
