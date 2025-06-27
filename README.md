🧠 DroidDex Flutter
A Flutter plugin for DroidDex — Blinkit’s Android performance profiling library. This plugin bridges your Flutter app with native Kotlin performance signals using MethodChannel and EventChannel.

> 🔗 Read the original blog: [How Blinkit Cracked Android's Performance Puzzle with Droid Dex](https://lambda.blinkit.com/droid-dex-1f807901626f)  
> 🧑‍💻 GitHub (Kotlin SDK): [grofers/droid-dex](https://github.com/grofers/droid-dex)


# droid_dex_flutter


🚀 Features
📊 Get performance levels for:

CPU

Battery

Network

Storage

Memory

⚖️ Weighted performance scoring via custom importance

🔁 Real-time performance updates using event streams

⚡️ Simple API with  enums and model wrappers

📦 Installation
Add this to your pubspec.yaml:

yaml

dependencies:
droid_dex_flutter: ^<latest_version>
Then run:

flutter pub get
🧪 Example
Here's a minimal example:

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
For a complete working demo, check the example app.

🎯 API Overview
Initialization


await DroidDexFlutter().init();
Get Performance Level


Future<int> getPerformanceLevel(int performanceClass);
Weighted Performance Level


Future<int> getWeightedPerformanceLevel(List<PerformanceClassWeightPair> pairs);
Live Data


Future<Stream<int>> getPerformanceLevelLiveData(int performanceClass);
Future<Stream<int>> getWeightedPerformanceLevelLiveData(List<PerformanceClassWeightPair> pairs);
🧩 Native Dependencies
This plugin currently supports Android only. Make sure your minSdkVersion is at least 21 and that Kotlin is properly configured.

📚 Resources
🔗 DroidDex GitHub Repository

📰 Medium Article (Blinkit Engineering)

🤝 Contributing
Pull requests and issue reports are welcome! If you find a bug or have a feature request, feel free to open an issue on GitHub.

