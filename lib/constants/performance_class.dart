class PerformanceClass {
  static const int cpu = 0;
  static const int memory = 1;
  static const int storage = 2;
  static const int network = 3;
  static const int battery = 4;

  static String name(int value) {
    switch (value) {
      case cpu:
        return 'CPU';
      case memory:
        return 'MEMORY';
      case storage:
        return 'STORAGE';
      case network:
        return 'NETWORK';
      case battery:
        return 'BATTERY';
      default:
        return 'Unknown($value)';
    }
  }

  static const List<int> values = [cpu, memory, storage, network, battery];
}
