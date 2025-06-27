import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'constants/performance_class_weight_pair.dart';
import 'droid_dex_flutter_method_channel.dart';

abstract class DroidDexFlutterPlatform extends PlatformInterface {
  /// Constructs a DroidDexFlutterPlatform.
  DroidDexFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static DroidDexFlutterPlatform _instance = MethodChannelDroidDexFlutter();

  /// The default instance of [DroidDexFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelDroidDexFlutter].
  static DroidDexFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DroidDexFlutterPlatform] when
  /// they register themselves.
  static set instance(DroidDexFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init() {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<int> getPerformanceLevel(int performanceClass) {
    throw UnimplementedError('getPerformanceLevel() has not been implemented.');
  }

  Future<int> getAveragePerformanceLevelOfMultiplePerformanceClasses(
    List<int> performanceClassesList,
  ) {
    throw UnimplementedError('getPerformanceLevel() has not been implemented.');
  }

  Future<Stream<int>> getPerformanceLevelLiveData(int performanceClass) {
    throw UnimplementedError(
      'getPerformanceLevelLiveData() has not been implemented.',
    );
  }

  Future<Stream<int>> getAveragePLOfMultiplePerformanceClassesLiveData(
    List<int> performanceClassesList,
  ) {
    throw UnimplementedError(
      'getAveragePLOfMultiplePerformanceClassesLiveData() has not been implemented.',
    );
  }

  Future<int> getWeightedPerformanceLevel(
    List<PerformanceClassWeightPair> performanceClassWeightPairList,
  ) {
    throw UnimplementedError(
      'getAveragePLOfMultiplePerformanceClassesLiveData() has not been implemented.',
    );
  }

  Future<Stream<int>> getWeightedPerformanceLevelLiveData(
    List<PerformanceClassWeightPair> performanceClassWeightPairList,
  ) {
    throw UnimplementedError(
      'getWeightedPerformanceLevelLiveData() has not been implemented.',
    );
  }
}
