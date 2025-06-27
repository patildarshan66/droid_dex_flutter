## 1.0.0

### 🚀 Initial Release

- ✅ Flutter plugin for [Droid Dex](https://lambda.blinkit.com/droid-dex-1f807901626f) (Android-only).
- 🧠 Provides APIs to fetch device performance level based on different performance classes.
- ⚙️ Includes:
    - `init()` to initialize DroidDex.
    - `getPerformanceLevel(performanceClass)`
    - `getAveragePerformanceLevelOfMultiplePerformanceClasses(performanceClassesList)`
    - `getPerformanceLevelLiveData(performanceClass)`
    - `getAveragePLOfMultiplePerformanceClassesLiveData(performanceClassesList)`
    - `getWeightedPerformanceLevel(performanceClassWeightPairList)`
    - `getWeightedPerformanceLevelLiveData(performanceClassWeightPairList)`
- 📦 Includes complete working example app in `example/`.

---

🔗 **Droid Dex native library:** [GitHub Repo](https://github.com/grofers/droid-dex)  
📖 **Background article:** [How Blinkit Cracked Android's Performance Puzzle](https://lambda.blinkit.com/droid-dex-1f807901626f)
