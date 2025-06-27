import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:droid_dex_flutter/droid_dex_flutter.dart';
import 'package:droid_dex_flutter/constants/performance_class.dart';
import 'package:droid_dex_flutter/constants/performance_class_weight_pair.dart';
import 'package:droid_dex_flutter/constants/performance_level.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _droidDex = DroidDexFlutter();

  PerformanceLevel? singleLevel;
  PerformanceLevel? averageLevel;
  PerformanceLevel? weightedLevel;

  PerformanceLevel? singleLiveLevel;
  PerformanceLevel? averageLiveLevel;
  PerformanceLevel? weightedLiveLevel;

  StreamSubscription? _singleSub;
  StreamSubscription? _averageSub;
  StreamSubscription? _weightedSub;

  final singleClass = PerformanceClass.cpu;
  final multipleClasses = [PerformanceClass.cpu, PerformanceClass.network];
  final weightedPairs = [
    PerformanceClassWeightPair(
      performanceClass: PerformanceClass.network,
      weight: 2.0,
    ),
    PerformanceClassWeightPair(
      performanceClass: PerformanceClass.storage,
      weight: 3.0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    initAll();
  }

  Future<void> initAll() async {
    try {
      await _droidDex.init();

      final sLevel = await _droidDex.getPerformanceLevel(singleClass);
      final aLevel = await _droidDex
          .getAveragePerformanceLevelOfMultiplePerformanceClasses(
            multipleClasses,
          );
      final wLevel = await _droidDex.getWeightedPerformanceLevel(weightedPairs);

      setState(() {
        singleLevel = sLevel;
        averageLevel = aLevel;
        weightedLevel = wLevel;
      });

      final singleStream = await _droidDex.getPerformanceLevelLiveData(
        singleClass,
      );
      final averageStream = await _droidDex
          .getAveragePLOfMultiplePerformanceClassesLiveData(multipleClasses);
      final weightedStream = await _droidDex
          .getWeightedPerformanceLevelLiveData(weightedPairs);

      _singleSub = singleStream.listen((event) {
        setState(() => singleLiveLevel = event);
      });
      _averageSub = averageStream.listen((event) {
        setState(() => averageLiveLevel = event);
      });
      _weightedSub = weightedStream.listen((event) {
        setState(() => weightedLiveLevel = event);
      });
    } on PlatformException catch (e) {
      debugPrint("DroidDex init failed: ${e.message}");
    }
  }

  @override
  void dispose() {
    _singleSub?.cancel();
    _averageSub?.cancel();
    _weightedSub?.cancel();
    super.dispose();
  }

  Widget _buildRow(String label, PerformanceLevel? level) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text('$label: ${level?.name ?? "Unknown"}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('DroidDex Flutter Example')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRow("Single Class Level", singleLevel),
              _buildRow("Average Level", averageLevel),
              _buildRow("Weighted Level", weightedLevel),
              const Divider(height: 32),
              _buildRow("Live: Single Class", singleLiveLevel),
              _buildRow("Live: Average Classes", averageLiveLevel),
              _buildRow("Live: Weighted", weightedLiveLevel),
            ],
          ),
        ),
      ),
    );
  }
}
