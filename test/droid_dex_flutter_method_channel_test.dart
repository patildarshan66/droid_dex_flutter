import 'package:droid_dex_flutter/constants/performance_class.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:droid_dex_flutter/droid_dex_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelDroidDexFlutter platform = MethodChannelDroidDexFlutter();
  const MethodChannel channel = MethodChannel('droid_dex_flutter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'getPerformanceLevel') {
            final classes = methodCall.arguments['performanceClass'];
            if (classes != null) {
              return 'HIGH'; // Return mock performance level string
            } else {
              throw PlatformException(
                code: 'INVALID_ARGS',
                message: 'Missing classes',
              );
            }
          } else if (methodCall.method ==
              'getAveragePerformanceLevelOfMultiplePerformanceClasses') {
            final classes = methodCall.arguments['performanceClassesList'];
            if (classes != null) {
              return 'HIGH'; // Return mock performance level string
            } else {
              throw PlatformException(
                code: 'INVALID_ARGS',
                message: 'Missing classes',
              );
            }
          } else if (methodCall.method == 'getWeightedPerformanceLevel') {
            final classes =
                methodCall.arguments['performanceClassWeightPairList'];
            if (classes != null) {
              return 'HIGH'; // Return mock performance level string
            } else {
              throw PlatformException(
                code: 'INVALID_ARGS',
                message: 'Missing classes',
              );
            }
          } else if (methodCall.method == 'init') {
            return 'DroidDex initialized';
          }
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPerformanceLevel returns mocked value', () async {
    final result = await platform.getPerformanceLevel(PerformanceClass.storage);
    expect(result, 'HIGH');
  });
}
