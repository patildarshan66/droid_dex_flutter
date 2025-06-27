import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'constants/performance_class_weight_pair.dart';
import 'droid_dex_flutter_platform_interface.dart';

/// An implementation of [DroidDexFlutterPlatform] that uses method channels.
class MethodChannelDroidDexFlutter extends DroidDexFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('droid_dex/data');

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final eventChannel = const EventChannel('droid_dex/live_data');

  /// Initialize the DroidDex library
  @override
  Future<void> init() async {
    await methodChannel.invokeMethod('init');
  }

  /// Get performance level for integer class ID
  @override
  Future<int> getPerformanceLevel(int performanceClass) async {
    final int result = await methodChannel.invokeMethod('getPerformanceLevel', {
      'performanceClass': performanceClass,
    });
    return result;
  }

  /// Get performance level for a list of integer class IDs
  @override
  Future<int> getAveragePerformanceLevelOfMultiplePerformanceClasses(
    List<int> performanceClassesList,
  ) async {
    final int result = await methodChannel.invokeMethod(
      'getAveragePerformanceLevelOfMultiplePerformanceClasses',
      {'performanceClassesList': performanceClassesList},
    );
    return result;
  }

  /// Get live performance level data for a integer class ID
  @override
  Future<Stream<int>> getPerformanceLevelLiveData(int performanceClass) async {
    return eventChannel.receiveBroadcastStream({
      "performanceClass": performanceClass,
      "type": "getPerformanceLevelLd",
    }).cast<int>();
  }

  /// Get Live performance level for a list of integer class IDs
  @override
  Future<Stream<int>> getAveragePLOfMultiplePerformanceClassesLiveData(
    List<int> performanceClassesList,
  ) async {
    return eventChannel.receiveBroadcastStream({
      "performanceClassesList": performanceClassesList,
      "type": "getAveragePLOfMultiplePerformanceClassesLd",
    }).cast<int>();
  }

  /// Get performance level for a list of integer class IDs with Weight
  @override
  Future<int> getWeightedPerformanceLevel(
    List<PerformanceClassWeightPair> performanceClassWeightPairList,
  ) async {
    final int result = await methodChannel
        .invokeMethod('getWeightedPerformanceLevel', {
          'performanceClassWeightPairList':
              performanceClassWeightPairList.map((e) => e.toMap()).toList(),
        });
    return result;
  }
  /// Get Live performance level for a list of integer class IDs with Weight
  @override
  Future<Stream<int>> getWeightedPerformanceLevelLiveData(
    List<PerformanceClassWeightPair> performanceClassWeightPairList,
  ) async {
    return eventChannel.receiveBroadcastStream({
      "performanceClassWeightPairList": performanceClassWeightPairList.map((e) => e.toMap()).toList(),
      "type": "getWeightedPerformanceLevelLiveData",
    }).cast<int>();
  }
}
