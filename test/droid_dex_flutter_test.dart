import 'package:droid_dex_flutter/constants/performance_class.dart';
import 'package:droid_dex_flutter/constants/performance_class_weight_pair.dart';
import 'package:droid_dex_flutter/constants/performance_level.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:droid_dex_flutter/droid_dex_flutter.dart';
import 'package:droid_dex_flutter/droid_dex_flutter_platform_interface.dart';
import 'package:droid_dex_flutter/droid_dex_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDroidDexFlutterPlatform
    with MockPlatformInterfaceMixin
    implements DroidDexFlutterPlatform {
  @override
  Future<int> getPerformanceLevel(int performanceClass) {
    expect(
      performanceClass,
      PerformanceClass.storage,
    ); // optional: assert expected input
    return Future.value(0);
  }

  @override
  Future<void> init() async {
    // mock behavior, optional logging or noop
  }

  @override
  Future<int> getAveragePerformanceLevelOfMultiplePerformanceClasses(
    List<int> performanceClassesList,
  ) {
    expect(performanceClassesList, [
      PerformanceClass.memory,
      PerformanceClass.network,
    ]);
    return Future.value(0);
  }

  @override
  Future<Stream<int>> getPerformanceLevelLiveData(int performanceClass) {
    expect(
      performanceClass,
      PerformanceClass.storage,
    ); // optional: assert expected input
    return Future.value(Stream.value(0));
  }

  @override
  Future<Stream<int>> getAveragePLOfMultiplePerformanceClassesLiveData(
    List<int> performanceClassesList,
  ) {
    expect(performanceClassesList, [
      PerformanceClass.memory,
      PerformanceClass.network,
    ]); // optional: assert expected input
    return Future.value(Stream.value(0));
  }

  @override
  Future<int> getWeightedPerformanceLevel(
    List<PerformanceClassWeightPair> performanceClassWeightPairList,
  ) {
    expect(performanceClassWeightPairList, [
      PerformanceClassWeightPair(
        performanceClass: PerformanceClass.cpu,
        weight: 2.0,
      ),
      PerformanceClassWeightPair(
        performanceClass: PerformanceClass.battery,
        weight: 3.0,
      ),
    ]);
    return Future.value(0);
  }

  @override
  Future<Stream<int>> getWeightedPerformanceLevelLiveData(
    List<PerformanceClassWeightPair> performanceClassWeightPairList,
  ) {
    expect(performanceClassWeightPairList, [
      PerformanceClassWeightPair(
        performanceClass: PerformanceClass.cpu,
        weight: 2.0,
      ),
      PerformanceClassWeightPair(
        performanceClass: PerformanceClass.battery,
        weight: 3.0,
      ),
    ]);
    return Future.value(Stream.value(0));
  }
}

void main() {
  final DroidDexFlutterPlatform initialPlatform =
      DroidDexFlutterPlatform.instance;

  test('$MethodChannelDroidDexFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDroidDexFlutter>());
  });

  test('getPerformanceLevel returns mock value', () async {
    final droidDexFlutterPlugin = DroidDexFlutter();
    final fakePlatform = MockDroidDexFlutterPlatform();
    DroidDexFlutterPlatform.instance = fakePlatform;

    final result = await droidDexFlutterPlugin.getPerformanceLevel(
      PerformanceClass.storage,
    );
    expect(result, PerformanceLevel.unknown);
  });

  test(
    'getAveragePerformanceLevelOfMultiplePerformanceClasses returns mock value',
    () async {
      final droidDexFlutterPlugin = DroidDexFlutter();
      final fakePlatform = MockDroidDexFlutterPlatform();
      DroidDexFlutterPlatform.instance = fakePlatform;

      final result = await droidDexFlutterPlugin
          .getAveragePerformanceLevelOfMultiplePerformanceClasses([
            PerformanceClass.storage,
            PerformanceClass.memory,
          ]);
      expect(result, PerformanceLevel.unknown);
    },
  );

  test('getPerformanceLevelLiveData returns mock value', () async {
    final droidDexFlutterPlugin = DroidDexFlutter();
    final fakePlatform = MockDroidDexFlutterPlatform();
    DroidDexFlutterPlatform.instance = fakePlatform;

    final result = await droidDexFlutterPlugin.getPerformanceLevelLiveData(
      PerformanceClass.storage,
    );
    expect(result, PerformanceLevel.unknown);
  });

  test(
    'getAveragePLOfMultiplePerformanceClassesLiveData returns mock value',
    () async {
      final droidDexFlutterPlugin = DroidDexFlutter();
      final fakePlatform = MockDroidDexFlutterPlatform();
      DroidDexFlutterPlatform.instance = fakePlatform;

      final result = await droidDexFlutterPlugin
          .getAveragePLOfMultiplePerformanceClassesLiveData([
            PerformanceClass.storage,
            PerformanceClass.memory,
          ]);
      expect(result, PerformanceLevel.unknown);
    },
  );

  test('getWeightedPerformanceLevel returns mock value', () async {
    final droidDexFlutterPlugin = DroidDexFlutter();
    final fakePlatform = MockDroidDexFlutterPlatform();
    DroidDexFlutterPlatform.instance = fakePlatform;

    final result = await droidDexFlutterPlugin.getWeightedPerformanceLevel([
      PerformanceClassWeightPair(
        performanceClass: PerformanceClass.network,
        weight: 2.0,
      ),
      PerformanceClassWeightPair(
        performanceClass: PerformanceClass.storage,
        weight: 3.0,
      ),
    ]);
    expect(result, PerformanceLevel.unknown);
  });

  test('getWeightedPerformanceLevelLiveData returns mock value', () async {
    final droidDexFlutterPlugin = DroidDexFlutter();
    final fakePlatform = MockDroidDexFlutterPlatform();
    DroidDexFlutterPlatform.instance = fakePlatform;

    final result = await droidDexFlutterPlugin
        .getWeightedPerformanceLevelLiveData([
          PerformanceClassWeightPair(
            performanceClass: PerformanceClass.network,
            weight: 2.0,
          ),
          PerformanceClassWeightPair(
            performanceClass: PerformanceClass.storage,
            weight: 3.0,
          ),
        ]);
    expect(result, PerformanceLevel.unknown);
  });
}
