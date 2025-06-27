package com.example.droid_dex_flutter
import android.content.Context
import com.blinkit.droiddex.DroidDex
import com.blinkit.droiddex.constants.PerformanceLevel
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.EventChannel
import androidx.lifecycle.LiveData
import androidx.lifecycle.Observer

/** DroidDexFlutterPlugin */
class DroidDexFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var methodChannel : MethodChannel
  private  lateinit var eventChannel : EventChannel
  private lateinit var context: Context
  private val METHOD_CHANNEL = "droid_dex/data"
  private val EVENT_CHANNEL = "droid_dex/live_data"
  private var eventSink: EventChannel.EventSink? = null

  private var liveDataObserver: Observer<PerformanceLevel>? = null
  private var activeLiveData: LiveData<PerformanceLevel>? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL)
    methodChannel.setMethodCallHandler(this)

    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, EVENT_CHANNEL)

    eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
      override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events

        val args = arguments as? Map<*, *>
        val type = args?.get("type") as? String

        liveDataObserver = Observer { level ->
          events?.success(level.ordinal)
        }

        when (type) {
          "getPerformanceLevelLd" -> {
            val classId = (args["performanceClass"] as? Int)
            if (classId != null) {
              activeLiveData = DroidDex.getPerformanceLevelLd(classId)
            } else {
              events?.error("INVALID_ARGUMENT", "Missing or invalid 'performanceClass'", null)
            }
          }
          "getAveragePLOfMultiplePerformanceClassesLd" -> {
            val classIds = (args["performanceClassesList"] as? List<*>)?.mapNotNull { it as? Int }
            if (!classIds.isNullOrEmpty()) {
              activeLiveData =  DroidDex.getPerformanceLevelLd(*classIds.toIntArray())
            } else {
              events?.error("INVALID_ARGUMENT", "Missing or invalid 'performanceClassesList'", null)
            }
          }
          "getWeightedPerformanceLevelLiveData" -> {
            val rawList = args["performanceClassWeightPairList"] as? List<*>
            if (rawList != null) {
              val classWeightPairs = rawList.mapNotNull { item ->
                (item as? Map<*, *>)?.let {
                  val classId = it["class"] as? Int
                  val weight = (it["weight"] as? Number)?.toFloat()
                  if (classId != null && weight != null) {
                    Pair(classId, weight)
                  } else null
                }
              }.toTypedArray()
              activeLiveData = DroidDex.getWeightedPerformanceLevelLd(*classWeightPairs)
            } else {
              events?.error("INVALID_ARGUMENT", "Missing or invalid 'performanceClassWeightPairList'", null)
            }
          }
          else -> {
            events?.error("INVALID_TYPE", "Unsupported type", null)
            return
          }
        }

        // Observe
        activeLiveData?.observeForever(liveDataObserver!!)
      }

      override fun onCancel(arguments: Any?) {
        // Clean up observer
        liveDataObserver?.let { observer ->
          activeLiveData?.removeObserver(observer)
        }
        liveDataObserver = null
        activeLiveData = null
      }
    })
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "init" -> {
        DroidDex.init(context)
        result.success("DroidDex initialized")
      }
      "getPerformanceLevel" -> {
        val classId = call.argument<Int?>("performanceClass")
        if (classId != null) {
          val perfLevel = DroidDex.getPerformanceLevel(classId)
          result.success(perfLevel.ordinal)
        } else {
          result.error("INVALID_ARGUMENT", "Missing or invalid 'performanceClass'", null)
        }
      }
      "getAveragePerformanceLevelOfMultiplePerformanceClasses" -> {
        val classIds = call.argument<List<Int>>("performanceClassesList")?.toIntArray()
        if (classIds != null) {
          val perfLevel = DroidDex.getPerformanceLevel(*classIds)
          result.success(perfLevel.ordinal)
        } else {
          result.error("INVALID_ARGUMENT", "Missing or invalid 'performanceClasses'", null)
        }
      }
      "getWeightedPerformanceLevel" -> {
        val rawList = call.argument<List<Map<String, Any>>>("performanceClassWeightPairList")

        if (rawList != null) {
          val classWeightPairs = rawList.mapNotNull { item ->
            val classId = (item["class"] as? Int)
            val weight = (item["weight"] as? Number)?.toFloat()
            if (classId != null && weight != null) {
              Pair(classId, weight)
            } else null
          }.toTypedArray()

          val perfLevel = DroidDex.getWeightedPerformanceLevel(*classWeightPairs)
          result.success(perfLevel.ordinal)
        } else {
          result.error("INVALID_ARGUMENT", "Missing or invalid 'performanceClassWeightPairList'", null)
        }
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel.setMethodCallHandler(null)
    eventChannel.setStreamHandler(null)
  }
}
