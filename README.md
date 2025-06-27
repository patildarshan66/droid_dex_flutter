# 🧠 DroidDex Flutter

A Flutter plugin for DroidDex — Blinkit’s Android performance profiling library. This plugin bridges your Flutter app with native Kotlin performance signals using MethodChannel and EventChannel.


# 📚 Resources
🔗 [DroidDex GitHub Repository](https://github.com/grofers/droid-dex)


# 📰 Medium Article (Blinkit Engineering)
[How Blinkit Cracked Android's Performance Puzzle with Droid Dex](https://lambda.blinkit.com/droid-dex-1f807901626f)

# 🚀 Features

## 📊 Get performance levels for:

1. CPU
2. Battery
3. Network
4. Storage
5. Memory

## ⚖️ Weighted performance scoring via custom importance

## 🔁 Real-time performance updates using event streams

## ⚡️ Simple API with  enums and model wrappers

# Usage

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  droid_dex_flutter: ^1.0.1
```

In your library add the following import:

```dart
import 'package:droid_dex_flutter/droid_dex_flutter.dart';
```

For help getting started with Flutter, view the online [documentation](https://flutter.io/).

# 🧪 Example

Here's a minimal example:

```dart
final droidDex = DroidDexFlutter();
await droidDex.init();

final pairs = [
PerformanceClassWeightPair(
performanceClass: PerformanceClass.cpu,
weight: 2.0,
),
PerformanceClassWeightPair(
performanceClass: PerformanceClass.battery,
weight: 1.5,
),
];

final staticLevel = await droidDex.getWeightedPerformanceLevel(pairs);
print("Static Level: ${staticLevel.name}");

// Start real-time stream
final stream = await droidDex.getWeightedPerformanceLevelLiveData(pairs);
stream.listen((level) {
print("Live Level: ${level.name}");
});
```
For a complete working demo, check the example app.

# 🎯 API Overview

## Initialization

```dart

await DroidDexFlutter().init();

```

## Get Performance Level

```dart

Future<int> getPerformanceLevel(int performanceClass);

```

## Weighted Performance Level

```dart

Future<int> getWeightedPerformanceLevel(List<PerformanceClassWeightPair> pairs);

```

## Live Data

```dart
Future<Stream<int>> getPerformanceLevelLiveData(int performanceClass);

Future<Stream<int>> getWeightedPerformanceLevelLiveData(List<PerformanceClassWeightPair> pairs);

```

## 🧩 Native Dependencies

This plugin currently supports Android only. Make sure your minSdkVersion is at least 24 and that Kotlin is properly configured.

## 🤝 Contributing
Pull requests and issue reports are welcome! If you find a bug or have a feature request, feel free to open an issue on GitHub.

